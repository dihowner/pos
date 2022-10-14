<?php
// require MODEL_DIR."Category.php";

class Stock extends Utility {

    protected $responseBody;

    function __construct($db) {
        $this->db = $db;
        $this->table = new stdClass();
        $this->table->stock_in = 'stock_in';
        $this->table->stockUpdate = 'stock_update_quantity_history';
        $this->table->stockDailyUpdate = 'daily_update';
        $this->table->stockUpdateArhive = 'stock_update_archive';

        $this->table->sales = 'sales';
        $this->table->salesItem = 'sales_item';

        // Instantiate classes...
        $this->category = new Category($this->db);
        
    }

    public function getStock($type) {
        try {
            switch($type) {

                case "total_stock":
                    $this->responseBody = $this->db->countRecords($this->table->stock_in, "");
                break;

                case "available_stock":
                    $result = $this->db->getAllRecords($this->table->stock_in, "*", " AND stock_qty > 0", "ORDER BY date_created DESC");
                    $this->responseBody = count($result);
                break;
                
                case "unavailable_stock":
                    $result = $this->db->getAllRecords($this->table->stock_in, "*", " AND stock_qty < 1", "ORDER BY date_created DESC");
                    $this->responseBody = count($result);
                break;

                case "total_stock_available_worth":
                    $result = $result = $this->db->getSingleRecord($this->table->stock_in, " COALESCE(sum(stock_costprice * stock_qty), 0) AS costPrice", " AND stock_qty > 0");
                    $this->responseBody = $result;
                break;

                case "total_stock_unavailable_worth":
                    $result = $result = $this->db->getSingleRecord($this->table->stock_in, " COALESCE(sum(stock_costprice * stock_qty), 0) AS costPrice", " AND stock_qty < 1");
                    $this->responseBody = $result;
                break;
            }
            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
            exit;
        }
    }

    public function checkStockExists($stock_id) {
        $searchData = $this->db->getSingleRecord($this->table->stock_in, "*", " AND (id = '$stock_id' OR stock_unique_id = '$stock_id')");
        if($searchData != NULL) {
            $this->responseBody = $this->arrayToObject($searchData);
        } else {
            $this->responseBody =  false;
        }
        
        return $this->responseBody;
    }

    public function searchStock($query) {
        try {
            $result = $this->db->getAllRecords($this->table->stock_in, "*", "AND (stock_name LIKE '%$query%' OR stock_unique_id LIKE '%$query%')");
    
            if (count($result) > 0){
    
                $feedback = $result;
                foreach ($feedback as $index => $item) {
                    $feedback[$index]['category'] = $this->category->getCategoryById($item['stock_category_id']);
                }    
                $this->responseBody =  $this->arrayToObject($feedback);
            } else {
                $this->responseBody =  false;
            }
    
            return $this->responseBody;
        } catch (\Throwable $e) {
            echo $e->getMessage();
        }
    }

    public function createStock($stockData) {
        try {
            $isStockExists = $this->checkStockExists($stockData["stock_unique_id"]);

            if($isStockExists !== false) {
                $_SESSION["stock_exists"] = true;
                $this->responseBody = false;
            }
            else {
                $insert = $this->db->insert($this->table->stock_in, $stockData);                
                if ($insert > 0) {
                    $stockId = $this->db->lastInsertId();
                    $this->responseBody =  $stockId;
                } else {
                    $this->responseBody =  false;
                }
            }

            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
            exit;
        }
    }
    
    public function getStockById($stockId) {
        
        $settings = new Settings($this->db);

        $lowThreshold = $settings->getAllSettings()->low_quantity_threshold;
        
        $result = $this->db->getSingleRecord($this->table->stock_in, "*", " AND (id = '$stockId' OR stock_unique_id = '$stockId')");
        
        if ($result != NULL){

            $feedback = $result;
            
            $feedback['category'] = $this->category->getCategoryById($feedback['stock_category_id']);
            if($feedback['stock_qty'] > $lowThreshold) {
                $feedback['threshold'] = '<span class="badge badge-success">Good >' .$lowThreshold. '</span>'; 
            }
            else if($feedback['stock_qty'] == $lowThreshold) {
                $feedback['threshold'] = '<span class="badge badge-info">Average <=' .$lowThreshold. '</span>'; 
            }
            else {
                $feedback['threshold'] = '<span class="badge badge-warning">Low <' .$lowThreshold. '</span>'; 
            }
            $this->responseBody =  $this->arrayToObject($feedback);
        } else {
            $this->responseBody =  false;
        }
        return $this->responseBody;
    }

    public function getStockByStockId($stockId)
    {
        $result = $this->db->getSingleRecord($this->table->stock_in, "*", " AND stock_unique_id = '$stockId'");

        if ($result != NULL){

            $feedback = $result;
            $feedback['category'] = $this->category->getCategoryById($feedback['stock_category_id']);

            $this->responseBody =  $this->arrayToObject($feedback);
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function getAvailableStocks($categoryId = '')
    {
        if ($categoryId == '') {
            $result = $this->db->getAllRecords($this->table->stock_in, "*", " AND stock_qty > 0", "ORDER BY date_created DESC");
        } else {
            $result = $this->db->getAllRecords($this->table->stock_in, "*", " AND stock_qty > 0 AND category = '$categoryId'", "ORDER BY date_created DESC");
        }

        if (count($result) > 0) {
            foreach ($result as $index => $stockItem) {
                $feedback[$index] = $this->getStockById($stockItem['id']);
                
            }
            $this->responseBody =  $feedback;
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function getUnavailableStocks($categoryId = '')
    {
        if ($categoryId == '') {
            $result = $this->db->getAllRecords($this->table->stock_in, "*", " AND stock_qty < 1", "ORDER BY date_created DESC");
        } else {
            $result = $this->db->getAllRecords($this->table->stock_in, "*", " AND stock_qty < 1 AND category = '$categoryId'", "ORDER BY date_created DESC");
        }

        if (count($result) > 0) {
            foreach ($result as $index => $stockItem) {
                $feedback[$index] = $this->getStockById($stockItem['id']);
            }
            $this->responseBody =  $feedback;
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function deleteStock($stock_id) {
        try {
            $deleteStock = $this->db->delete($this->table->stock_in, ['id' => $stock_id]);
            if($deleteStock) {                
                $this->responseBody = true;
            } else {
                $this->responseBody = false;
            }
            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
            exit;
        }
    }

    public function updateStockDetails($updateData, $updateWhere) {
        try {
            $updateStock = $this->db->update($this->table->stock_in, $updateData, $updateWhere);
            if($updateStock) {                
                $this->responseBody = true;
            } else {
                $this->responseBody = false;
            }
            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
            exit;
        }
    }

    public function updateStockQuantity($quantity , $stock_unique_id) {
        try {
            $getStockById = $this->getStockByStockId($stock_unique_id);

            if($getStockById === false) {
                $_SESSION["stock_not_exists"] = true;
                $this->responseBody = false;
            }
            else {
                $oldQuantity = $getStockById->stock_qty;
                $newQuantity = (float) $oldQuantity + $quantity;

                $this->db->beginTransaction();
                $updateStock = $this->db->update($this->table->stock_in, ["stock_qty" => $newQuantity], ["stock_unique_id" => $stock_unique_id]);

                $stockUpdateData = array(
                    'stock_id' => $getStockById->id,
                    'user_id' => $_SESSION["adminId"],
                    'quantity_added' => $quantity,
                    'old_quantity' => $oldQuantity,
                    'new_quantity' => $newQuantity,
                    'date_created' => date("Y-m-d H:i:s")
                );
                
                if($updateStock) {
                    $this->db->insert($this->table->stockUpdate, $stockUpdateData);
                    $this->db->commit();
                    $this->responseBody = true;
                }
                else {
                    $this->db->rollBack(); 
                    $this->responseBody = false;                   
                }
            }
            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
            exit;
        }
    }

    public function getStockQuantityUpdateHistory()
    {
        $result = $this->db->getAllRecords($this->table->stockUpdate, "*", "", " ORDER BY date_created DESC limit 1");

        if (count($result) > 0){

            $feedback = $result;
            $this->responseBody = $this->arrayToObject($feedback);
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function updateCostPrice($updateData, $updateWhere) {
        try {
            $updateStock = $this->db->update($this->table->stock_in, $updateData, $updateWhere);
            if($updateStock) {                
                $this->responseBody = true;
            } else {
                $this->responseBody = false;
            }
            return $this->responseBody;
        }
        catch(Throwable $e) {
            echo $e->getMessage();
            exit;
        }
    }

    public function deductStock($stock_id, $quantity)
    {
        $theStock = $this->getStockByStockId($stock_id); 
        if ($theStock != false) {
            $newQuantity = $theStock->stock_qty == 0 ? 0:$theStock->stock_qty - $quantity;
            $updateData = [
                'stock_qty' => $newQuantity
            ];

            $updateQuantity = $this->db->update_new($this->table->stock_in, $updateData, "AND (stock_unique_id ='$stock_id')");
            if ($updateQuantity > 0) {
                $this->responseBody =  true;
            } 
            else {
                $this->responseBody =  false;
            }
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }
    
    public function getStockDailyUpdateSalesAmount()
    {
        $result = $this->db->getSingleRecord($this->table->stockDailyUpdate, " COALESCE(SUM(sales_amount), 0) AS grand_sales_amount");

        if ($result != NULL){
            $feedback = $result['grand_sales_amount'];
            $this->responseBody =  $feedback;
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function getStockDailyUpdateDiscount()
    {
        $result = $this->db->getSingleRecord($this->table->stockDailyUpdate, " COALESCE(SUM(sales_discount), 0) AS grand_discount");

        if ($result != NULL){
            $feedback = $result['grand_discount'];
            $this->responseBody =  $feedback;
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function getStockDailyUpdateProfit()
    {
        $result = $this->db->getSingleRecord($this->table->stockDailyUpdate, " COALESCE(SUM(profit), 0) AS grand_profit");

        if ($result != NULL){
            $feedback = $result['grand_profit'];
            $this->responseBody =  $feedback;
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function getStockDailyUpdateRecord($stockId)
    {
        $result = $this->db->getSingleRecord($this->table->stockDailyUpdate, "*", "AND stock_unique_id = '$stockId'");

        if ($result != NULL){
            $feedback = $result;
            $this->responseBody =  $feedback;
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function getAllStocks($catId = '')
    {
        if ($catId == '') {
            $result = $this->db->getAllRecords($this->table->stock_in, "*", "", "ORDER BY date_created DESC");
        } else {
            $result = $this->db->getAllRecords($this->table->stock_in, "*", "AND category = '$catId'", "ORDER BY date_created DESC");
        }

        if (count($result) > 0){
            foreach ($result as $index => $stockItem) {
                $feedback[$index] = $this->getStockById($stockItem['id']);
            }

            $this->responseBody =  $this->arrayToObject($feedback);
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function doStockDailyUpdate($option)
    {
        $sales = new Sales($this->db);
        $settings = new Settings($this->db);
        $allSettings = $settings->getAllSettings();
        $admin = new Admin($this->db);

        $allStocks = $this->getAllStocks();
        
        $now = date('Y-m-d H:i:s');
        $adminId = $_SESSION['adminId'];

        switch ($option) {
            case 'open':
                try {
                    $this->db->getRecFrmQry("TRUNCATE ".$this->table->stockDailyUpdate."");
                    
                    foreach ($allStocks as $index => $stockItem) {
                        if ($stockItem->stock_qty > 0) {
                            $pendingSales = $sales->getStockSalesByPaymentStatus($stockItem->stock_unique_id, 0);

                            $data = [
                                'stock_unique_id' => $stockItem->stock_unique_id,
                                'opening_stock' => $stockItem->stock_qty,
                                'closing_stock' => NULL,
                                'stock_difference' => NULL,
                                'pending' => count($pendingSales),
                                'sales_amount' => NULL,
                                'profit' => NULL,
                            ];
                            $this->db->insert($this->table->stockDailyUpdate, $data);
                        }

                    }
                    
                    $settings->saveAppInfo('stock_last_opened', $now, $now);
                    $settings->saveAppInfo('stock_opened_by', $adminId, $now);
                    $settings->saveAppInfo('stock_status', 'opened', $now);

                    $this->responseBody = true;

                }
                catch (\Throwable $e) {
                    $this->responseBody =  false;
                    echo $e->getMessage();
                    die;
                }
            break;

            case 'close':
                try {
                    
                    foreach ($allStocks as $index => $stockItem) {

                        $stockId = $stockItem->stock_unique_id;
                        $salesAmountDIsc = $this->getEachStockSalesInfo($stockId, [$allSettings->stock_last_opened, $now]);
                        $pendingSales = $sales->getStockSalesByPaymentStatus($stockId, 0);

                        $pendingSales = count($pendingSales);

                        $salesAmount = (!empty($this->objectToArray($salesAmountDIsc)['total_sales'])) ? $this->objectToArray($salesAmountDIsc)['total_sales']:0;
                        $salesDiscount = (!empty($this->objectToArray($salesAmountDIsc)['total_discount'])) ? $this->objectToArray($salesAmountDIsc)['total_discount']:0;

                        $getStockDailyUpdateRecord = $this->getStockDailyUpdateRecord($stockId);
                        
                        // Check if the stock is not part of the stock opened earlier...
                        $openingStock = ($this->getStockDailyUpdateRecord($stockId) === false) ?  0 : (float) ($getStockDailyUpdateRecord['opening_stock']);
                        
                        $removeOpeningStockFromPendingSales = ($openingStock - $pendingSales);

                        $stockQtyLeft = $stockItem->stock_qty;
                        
                        $stockDifference =  $removeOpeningStockFromPendingSales - $stockQtyLeft;

                        // Deduct Stock sold from pending sales... 
                        $stockSold = $stockDifference - $pendingSales;

                        //Stock Cost price...
                        $costAmount = $stockSold * $stockItem->stock_costprice;

                        // How much was made from this stock...
                        $profit = (float) ($salesAmount - $costAmount);

                        $arraySet = [
                            'closing_stock' => $stockItem->stock_qty,
                            'stock_difference' => $stockDifference,
                            'pending' => $pendingSales,
                            'sales_amount' => $salesAmount,
                            'sales_discount' => $salesDiscount,
                            'profit' => $profit,
                        ];

                        $arrayWhere = [
                            'stock_unique_id' => $stockItem->stock_unique_id,
                        ];
                        $this->db->update($this->table->stockDailyUpdate, $arraySet, $arrayWhere);

                        // // print_r($this->getStockDailyUpdateRecord($stockId)['opening_stock']);
                        
                        // $index = $index + 1;

                        // echo $index . " => ". $stockId. " => ".$salesAmount. " => ".$costAmount. " => ".$profit. " => ".$salesDiscount . " => ". $openingStock . " => ". $stockDifference . " => ". $pendingSales . " => ". $stockSold . " => ". $stockQtyLeft . "<br>";

                    }

                    // Update settings table
                    $settings->saveAppInfo('stock_last_closed', $now, $now);
                    $settings->saveAppInfo('stock_closed_by', $adminId, $now);
                    $settings->saveAppInfo('stock_status', 'closed', $now);

                    $recordsHtml = $this->generateDailyStockUpdateHTML($allSettings->stock_last_opened, $now);
                    $filePath = 'stockUpdates/'.time().'.pdf';

                    $this->downloadHTMLToPDF($recordsHtml, $filePath);
                    $this->archiveStockUpdate($allSettings->stock_last_opened, $now, UPLOADS_DIR.$filePath);

                    $this->responseBody = true;
                    
                }
                catch (\Throwable $e) {
                    $this->responseBody =  false;
                    echo $e->getMessage();
                    die;
                }

            break;
        }

        return $this->responseBody;

    }

    public function archiveStockUpdate($dateOpened, $dateClosed, $file)
    {
        $archiveData = [
            "date_opened" => $dateOpened,
            "date_closed" => $dateClosed,
            "file_path" => $file,
        ];

        $insert = $this->db->insert($this->table->stockUpdateArhive, $archiveData);
        if ($insert > 0) {
            $this->responseBody = true;
        } else {
            $this->responseBody = false;
        }

        return $this->responseBody;
    }
    
    public function getEachStockSalesInfo($stockId='', $interval='')
    {
        $whereClause = "WHERE 1";
        $whereClause .= ($stockId != '' ? ' AND si.stock_unique_id = '.$stockId:'');
        $whereClause .= ($interval != '' ? ' AND s.date BETWEEN "'.$interval[0].'" AND "'.$interval[1].'"':'');

        $result = $this->db->getRecFrmQry(
            "SELECT si.stock_unique_id, SUM(si.quantity) AS quantity, si.unit_price, SUM(si.discount) AS total_discount, SUM(si.sub_total) AS total_sales
            FROM ".$this->table->salesItem." si
            LEFT JOIN ".$this->table->sales." s ON s.reference = si.sales_reference
            ".$whereClause." AND s.payment_status = '1'
            GROUP BY si.stock_unique_id"
        );
        
        if (count($result) > 0) {
            $feedback = array(
                'total_qty' => 0, 
                'total_sales' => 0, 
                'total_profit' => 0
            );

            foreach ($result as $index => $productItem) {
                $feedback['sales_items'][$index] = $this->objectToArray(
                    $this->getStockByStockId(
                        $productItem['stock_unique_id']
                    )
                );

                $feedback['sales_items'][$index]['stock_unique_id'] = $productItem['stock_unique_id'];
                $feedback['sales_items'][$index]['quantity_sold'] = (int)$productItem['quantity'];
                $feedback['sales_items'][$index]['total_sales'] = (int)$productItem['total_sales'];
                $feedback['sales_items'][$index]['total_cost'] = $feedback['sales_items'][$index]['stock_costprice']*$feedback['sales_items'][$index]['quantity_sold'];
                $feedback['sales_items'][$index]['profit'] = $feedback['sales_items'][$index]['total_sales']-$feedback['sales_items'][$index]['total_cost'];
                $feedback['sales_items'][$index]['unit_price'] = (int)$productItem['unit_price'];

                $feedback['total_qty'] += $feedback['sales_items'][$index]['quantity_sold'];
                $feedback['total_sales'] += $feedback['sales_items'][$index]['total_sales'];
                $feedback['total_profit'] += $feedback['sales_items'][$index]['profit'];
            }

            $this->responseBody = $this->arrayToObject($feedback);
        }else {
            $this->responseBody = false;
        }
        return $this->responseBody;
    }
    
    public function getStockDailyUpdateRecords()
    {
        $result = $this->db->getAllRecords($this->table->stockDailyUpdate, "*", "", " ORDER BY id DESC");

        if (count($result) > 0){
            $feedback = $result;
            $this->responseBody =  $this->arrayToObject($feedback);
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }

    public function generateDailyStockUpdateHTML($stockOpenDate, $stockCloseDate)
    {
        $stockUpdateRecords = $this->getStockDailyUpdateRecords();

        $records = "";
        foreach ($stockUpdateRecords as $index => $updateRecordInfo) {
            $sales_amount = number_format($updateRecordInfo['sales_amount'] ? $updateRecordInfo['sales_amount'] : 0, 2);
            $sales_discount = number_format($updateRecordInfo['sales_discount'] ? $updateRecordInfo['sales_discount'] : 0, 2);
            $profit = number_format($updateRecordInfo['profit'] ? $updateRecordInfo['profit'] : 0, 2);

            $records .= "
                <tr>
                    <td>
                        ".$this->getStockByStockId($updateRecordInfo['stock_unique_id'])->stock_name."<br>
                        <span class='text-primary'>
                            ".$updateRecordInfo['stock_unique_id']."
                        </span>
                    </td>

                    <td>
                        ".$updateRecordInfo['opening_stock']."
                    </td>
                    
                    <td>
                        ".$updateRecordInfo['closing_stock']."
                    </td>
                    
                    <td>
                        ".$updateRecordInfo['stock_difference']."
                    </td>

                    <td>
                        ".$updateRecordInfo['pending']."
                    </td>

                    <td>
                        N".$sales_amount."
                    </td>

                    <td>
                        N".$sales_discount."
                    </td>
                    
                    <td>
                        N".$profit."
                    </td>
                </tr>
            ";
        }
        
        $recordsHtml = "<!DOCTYPE html>
            <html lang='en'>
                <head>
                    <meta charset='UTF-8'>
                    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
                    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                    <title>Document</title>
                </head>
                <style>
                    td {
                        padding: 5px;
                    }
                </style>
                <body>

                    <div style='text-align: center; margin-bottom: 10px;'>
                        <h3>
                            Stock Update for ".$this->niceDateFormat($stockOpenDate)." - ".$this->niceDateFormat($stockCloseDate)."
                        </h3>
                    </div>

                    <table border='1' style='border-collapse: collapse; width:100%'>
                        <thead>
                            <tr>
                                <th>Stock Name / Model ID</th>
                                <th>Opening Stock</th>
                                <th>Closing Stock</th>
                                <th>Stock Difference</th>
                                <th>Pending Order</th>
                                <th>Sales Amount </th>
                                <th>Sales Discount </th>
                                <th>Profit</th>
                            </tr>
                        </thead>

                        <tbody>
                            ".$records."
                            <tr>
                                <td colspan='7' style='text-align: right;'>
                                    Grand Sales Amount
                                </td>
                                <td>
                                    N".number_format($this->getStockDailyUpdateSalesAmount(), 2)."
                                </td>
                            </tr>
                            <tr>
                                <td colspan='7' style='text-align: right;'>
                                    Grand Sales Discount
                                </td>
                                <td>
                                    N".number_format($this->getStockDailyUpdateDiscount(), 2)."
                                </td>
                            </tr>
                            <tr>
                                <td colspan='7' style='text-align: right;'>
                                    Grand Profit
                                </td>
                                <td>
                                    N".number_format($this->getStockDailyUpdateProfit(), 2)."
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </body>
            </html>
        ";

        $this->responseBody =  $recordsHtml;
        return $this->responseBody;
    }
    
    public function getAllStockUpdateArchiveHistory()
    {
        $result = $this->db->getAllRecords($this->table->stockUpdateArhive, "*", "", " ORDER BY date_closed DESC");

        if (count($result) > 0){

            $feedback = $result;
            $this->responseBody =  $this->arrayToObject($feedback);
        } else {
            $this->responseBody =  false;
        }

        return $this->responseBody;
    }
    
    public function getLowQuantity_Threshold_Stock() {
        $settings = new Settings($this->db);

        $lowThreshold = $settings->getAllSettings()->low_quantity_threshold;

        $result = $this->db->getSingleRecord($this->table->stock_in, "*", " AND stock_qty < $lowThreshold", "ORDER BY date_created DESC limit 1");
        $this->responseBody = count($result);
        return $this->responseBody;

    }

}