<?php
require_once MODEL_DIR.'PaymentMethod.php';

class Sales extends Utility {

    protected $responseBody;

    function __construct($db) {
        $this->db = $db;
        $this->table = new stdClass();
        $this->table->sales = 'sales';
        $this->table->salesItem = 'sales_item';
        $this->table->checkout = 'checkout';        
    }

    public function getSalesAmount($type) {
        try {
            switch($type) {
                
                case "today_sales":
                    $salesDate = date("Y-m-d");
                    $result = $this->db->getSingleRecord($this->table->sales, " COALESCE(SUM(grand_total), 0) AS grand_total, COALESCE(SUM(total_discount), 0) AS grand_discount", " AND payment_status='1' AND date like '%$salesDate%'");
                    $this->responseBody = $result;
                break;

                case "this_week":
                    $startdate = date("Y-m-d H:i:s", strtotime('-1 week sunday 00:00:00'));
                    $enddate = date("Y-m-d H:i:s", strtotime('saturday 23:59:59'));
                    $result = $this->db->getSingleRecord($this->table->sales, " COALESCE(SUM(grand_total), 0) AS grand_total, COALESCE(SUM(total_discount), 0) AS grand_discount", " AND payment_status='1' AND date BETWEEN '".$startdate."' AND '$enddate'");
                    $this->responseBody = $result;
                break;

                case "this_month":
                    $salesDate = date("Y-m");
                    $result = $this->db->getSingleRecord($this->table->sales, " COALESCE(SUM(grand_total), 0) AS grand_total, COALESCE(SUM(total_discount), 0) AS grand_discount", " AND payment_status='1' AND date like '%$salesDate%'");
                    $this->responseBody = $result;
                break;
            }
            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
        }
    }

    public function initiateSales($reference, $cartInfo, $staff) {
        $theSales = $this->getSales($reference);

        if ($theSales == false) {
            $this->db->beginTransaction();
            try {
                
                $insertData = array(
                    'reference' => $reference, 
                    'waiter_id' => $staff,
                    'total_discount' => isset($cartInfo['coupon']) ? $cartInfo["coupon"]["amount"] : 0,
                    'grand_total' => $cartInfo['grand_total'],
                    'payment_method' => 4, //bank transfer
                    'payment_status' => 0, //Not paid
                    'delivery_status' => 0, //Not delivered
                    'date' => date("Y-m-d H:i:s")
                );
                $insert = $this->db->insert($this->table->sales, $insertData);

                if ($insert > 0) {
                    foreach ($cartInfo['items'] as $stockId => $cartItem) {

                        if($cartItem['stock_id'] != "" AND $cartItem['stock_id'] != NULL) {
                            $stock = new Stock($this->db);
                            $stock_id = $cartItem['stock_id'];
                            $quantity = $cartItem['quantity'];
                            $stock->deductStock($stock_id, $quantity);
                        }

                        $insertItem[] = array(
                            'id' => NULL,
                            'sales_reference' => $reference,
                            'stock_unique_id' => $cartItem['stock_id'],
                            'quantity' => $cartItem['quantity'],
                            'unit_price' => $cartItem['unit_price'],
                            'discount' => isset($cartInfo['coupon']) ? $cartInfo["coupon"]["amount"] : 0,
                            'sub_total' => $cartItem['sub_total']
                        );
                    }

                    $multiInsert = $this->db->multiInsert($this->table->salesItem, $insertItem);

                    if($multiInsert) {
                        $this->responseBody = true;
                        $this->db->commit();
                    } else {
                        $this->responseBody = false;
                        $this->db->rollBack();
                    }
                }
                else {
                    $this->responseBody = false;
                    $this->db->rollBack();
                }

            }
            catch(Throwable $e) {
                echo $e->getMessage();
            }
        }
        else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;

    }

    public function getSales($reference)
    {
        try {
            $result = $this->db->getRecFrmQry(
                "SELECT s.*
                FROM ".$this->table->sales." s
                WHERE (s.reference = '$reference' OR s.id = '$reference') "
            );
    
            if (count($result) > 0) {
                $admin = new Admin($this->db);
                $paymentMethod = new PaymentMethod($this->db);
    
                $theSales = $result[0];
    
                $theSales['waiter'] = $admin->getAdminById($theSales['waiter_id']);
                $theSales['cashier'] = $admin->getAdminById($theSales['cashier_id']);
                $theSales['payment_method'] = $paymentMethod->getMethodById($theSales['payment_method']);
                $theSales['payment'] = $paymentMethod->paymentStatus($theSales['payment_status']);
                $theSales['delivery'] = $paymentMethod->deliveryStatus($theSales['delivery_status']);
                $theSales['date'] = $this->niceDateFormat($theSales['date']);
                $theSales['checkout'] = $this->getSalesCheckout($theSales['reference']);
    
                $result = $this->db->getRecFrmQry(
                    "SELECT si.*
                    FROM ".$this->table->salesItem." si
                    WHERE si.sales_reference = '$reference'"
                );

                foreach($result as $index => $result_in) {
                    $stock = new Stock($this->db);
                    $getStockInfo = $stock->getStockByStockId($result_in['stock_unique_id']);
                    $stock_name = $getStockInfo->stock_name;

                    $theSales['sales_item'][$index] = $result_in;  
                    $theSales['sales_item'][$index]['stock_name'] = $stock_name;
                }

                $this->responseBody = $this->arrayToObject($theSales);
            }else {
                $this->responseBody = false;
            }
        } catch (\Throwable $e) {
            $this->responseBody = false;
            echo $e->getMessage();
            die;
        }
        
        return $this->responseBody;
    }

    public function getSalesCheckout($salesReference)
    {
        $result = $this->db->getSingleRecord($this->table->checkout, "*", "AND sales_reference = '$salesReference'");

        if ($result != NULL) {
            $admin = new Admin($this->db);

            $result['admin'] = $admin->getAdminById($result['admin_id']);
            $result['date'] = $this->niceDateFormat($result['date']);

            $this->responseBody = $this->arrayToObject($result);
        }
        else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;
    }
    
    public function processSales($reference, $adminId, $action) {
        try {
            
            $stock = new Stock($this->db);

            $theSales = $this->getSales($reference);

            switch($action) {

                case "complete":
                    if($theSales->payment_status == 0) {
                        $updateData = array(
                            'payment_status' => 1,
                            'cashier_id' => $adminId
                        );
                        $updateSales = $this->db->update_new($this->table->sales, $updateData, " AND reference = $reference");
                        if($updateSales) {
                            $this->responseBody = true;
                        }
                        else {
                            $this->responseBody = false;
                        } 
                    }
                    else {
                        $this->responseBody = false;
                    } 
                break;

                case "checkout":
                    $updateData = array(
                        'delivery_status' => 1,
                    );
                    
                    $this->db->beginTransaction();

                    $updateSales = $this->db->update_new($this->table->sales, $updateData, " AND reference = $reference");
                    if($updateSales) {
                        $insertData = array(
                            'admin_id' => $adminId,
                            'type' => 'deliver',
                            'sales_reference' => $theSales->reference,
                        );
                        $checkoutHistory = $this->db->insert($this->table->checkout, $insertData);
                        $this->db->commit();
                    } else {
                        $this->responseBody = false;
                        $this->db->rollBack();
                    }
                break;
                
                case "cancel":
                    foreach ($theSales->sales_item as $index => $salesItem) {
                        $stockQuantityUpdate = $stock->updateStockQuantity($salesItem['quantity'], $salesItem['stock_unique_id']);
                    }
                    $updateData = array(
                        'payment_status' => 2,
                        'delivery_status' => 2,
                        'cashier_id' => $_SESSION["adminId"]
                    );
                    
                    $this->db->beginTransaction();

                    $updateSales = $this->db->update_new($this->table->sales, $updateData, " AND reference = $reference");
                    if($updateSales) {
                        $insertData = array(
                            'admin_id' => $_SESSION["adminId"],
                            'type' => 'cancel',
                            'sales_reference' => $theSales->reference,
                        );
                        $checkoutHistory = $this->db->insert($this->table->checkout, $insertData);  
                        $this->db->commit();
                        $this->responseBody = true;
                    }
                    else {
                        $this->db->rollBack();
                        $this->responseBody = false;
                    }

                break;

            }

            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
            exit;
        }
    }
    
    public function getAllSales($adminId = '')
    {
        if ($adminId == ''){
            $result = $this->db->getAllRecords($this->table->sales, "*", "", "ORDER BY date DESC limit 500");
        } else {
            $result = $this->db->getAllRecords($this->table->sales, "*", " AND (waiter_id = $adminId OR cashier_id = $adminId)", "ORDER BY date DESC limit 500");
        }

        if (count($result) > 0) {
            
            $admin = new Admin($this->db);
            $paymentMethod = new PaymentMethod($this->db);

            $newSales = array();
            $i = 1;
            foreach($result as $results) {

                $newSales[$i]['waiter'] = $admin->getAdminById($results['waiter_id'])->fullname;
                $newSales[$i]['cashier'] = isset($results['cashier_id']) ? $admin->getAdminById($results['cashier_id'])->fullname:'';

                $newSales[$i]['reference'] = $results['reference'];
                $newSales[$i]['grandTotal'] = $results['grand_total'];
                $newSales[$i]['paymentMethod'] = $paymentMethod->getMethodById($results['payment_method'])->name;
                $newSales[$i]['paymentStatus'] = $paymentMethod->paymentStatus($results['payment_status']);
                $newSales[$i]['payment_status'] = $results['payment_status'];
                $newSales[$i]['delivery_status'] = $results['delivery_status'];
                $newSales[$i]['deliveryStatus'] = $paymentMethod->deliveryStatus($results['delivery_status']);
                $newSales[$i]['date'] = $results['date'];

                $theCheckout = $this->getSalesCheckout($results['reference']);
                if ($theCheckout != FALSE) {
                    $newSales[$i]['checkoutAdmin'] = $admin->getAdminById($theCheckout->admin_id)->fullname;
                    $newSales[$i]['checkoutDate'] = $theCheckout->date;
                }
                $i++;
            }

            $this->responseBody = $newSales;
        } else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;
    }
    public function getCompletedSales($adminId = '')
    {
        if ($adminId == '') {
            $result = $this->db->getAllRecords($this->table->sales, "*", " AND payment_status = '1'", "ORDER BY date DESC");
        } else {
            $result = $this->db->getAllRecords($this->table->sales, "*", " AND payment_status = '1' AND cashier_id = $adminId", "ORDER BY date DESC");
        }

        if (count($result) > 0) {
            
            $admin = new Admin($this->db);
            $paymentMethod = new PaymentMethod($this->db);

            $newSales = array();
            $i = 1;
            foreach($result as $results) {
                $newSales[$i]['cashier'] = $admin->getAdminById($results['cashier_id'])->fullName;
                
                $newSales[$i]['reference'] = $results['reference'];
                $newSales[$i]['grandTotal'] = $results['grand_total'];
                $newSales[$i]['paymentMethod'] = $paymentMethod->getMethodById($results['payment_method'])->name;
                $newSales[$i]['paymentStatus'] = $paymentMethod->paymentStatus($results['payment_status']);
                $newSales[$i]['payment_status'] = $results['payment_status'];
                $newSales[$i]['deliveryStatus'] = $paymentMethod->deliveryStatus($results['delivery_status']);
                $newSales[$i]['date'] = $results['date'];
                $i++;
            }

            $this->responseBody = $newSales;
        } else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;
    }
    
    public function getCheckoutHistory()
    {
        $result = $this->db->getAllRecords($this->table->checkout, "*", " ORDER BY date DESC");

        if (count($result) > 0) {
            $admin = new Admin($this->db);

            foreach($result as $index => $history) {
                
                $items[$index]['admin'] = $admin->getAdminById($history['admin_id'])->fullName;
                $items[$index]['date'] = $this->niceDateFormat($history['date']);
                $items[$index]['reference'] = $history['sales_reference'];

            }
            $this->responseBody = $this->arrayToObject($items);
        }else {
            $this->responseBody = false;
        }
        
        return $this->responseBody;
    }

    public function getStockSalesByPaymentStatus($stockId, $paymentStatus)
    {
        $result = $this->db->getRecFrmQry(
            "SELECT s.*, si.*
            FROM ".$this->table->salesItem." si
            LEFT JOIN ".$this->table->sales." s ON s.reference = si.sales_reference
            WHERE si.stock_unique_id = '$stockId' AND s.payment_status = '$paymentStatus'
            ORDER BY s.date DESC"
        );

        $this->responseBody = $result;
        return $this->responseBody;
    }

}