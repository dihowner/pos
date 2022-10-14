<?php
require_once '../includes/config.php';
require_once CLASS_DIR.'Validator.php';

$stock = new Stock($db);
$admin = new Admin($db);

if(isset($_POST["createStock"])) {
    $myFilters = [
        'product_name', 'product_unique_id', 'product_description' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ],
        'category_id', 'product_price', 'product_quantity' => [
          'sanitization' => 'number|trim',
          'validation' => 'required',
        ]
    ];

    $validator = new Validator($myFilters);
    $validationResults = $validator->run($_POST);
      
    if ($validationResults === FALSE) {
        $validationErrors = $validator->getValidationErrors();
        foreach($validationErrors as $error){
            $_SESSION['errorMessage'][] = $error;
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    } 
    else {
        $sanitizedInputData = $validationResults;
        
        $adminInfo = $admin->getAdminById($_SESSION["adminId"]);
        $created_by = $adminInfo->fullname;

        $stockData = array(
            'stock_name' => $sanitizedInputData['product_name'], 
            'stock_unique_id' => $sanitizedInputData['product_unique_id'], 
            'stock_category_id' => $sanitizedInputData['category_id'], 
            'stock_price' => $sanitizedInputData['product_price'], 
            'stock_costprice' => 0,
            'stock_qty' => $sanitizedInputData['product_quantity'], 
            'stock_description' => $sanitizedInputData['product_description'],
            'memo' => json_encode(["created_by" => $created_by, "updated_by" => NULL]),
            "date_created" => date("Y-m-d H:i:s"),
            "date_updated" => date("Y-m-d H:i:s")
        );

        $createStock = $stock->createStock($stockData);
        
        if($createStock) {
            $stockId = $createStock;
            header("Location: " . BASE_URL . "setCostPrice?id=$stockId");
            exit();
        } else {
            if(isset($_SESSION["stock_exists"])) {
                $_SESSION['errorMessage'] = $clientLang['item_exist'];
                unset($_SESSION["stock_exists"]);
                header("Location: ".$_SERVER["HTTP_REFERER"]);
                exit();
            }
            else {
                $_SESSION['errorMessage'] = $clientLang['request_failed'];
                header("Location: ".$_SERVER["HTTP_REFERER"]);
                exit();
            }
        }
    }
}
else if(isset($_REQUEST["deleteStock"])) {

    $stockId = $_REQUEST["id"];

    if($stock->checkStockExists($stockId) === false) {
        $_SESSION['errorMessage'] = $clientLang['item_does_not_exist'];
    }
    else {
        $result = $stock->deleteStock($stockId);
        if($result) {
            $_SESSION['successMessage'] = $clientLang['deleted'];
        }
        else {
            $_SESSION['errorMessage'] = $clientLang['request_failed'];
        }
    }

    header("Location: ".$_SERVER["HTTP_REFERER"]);
    exit();    
}
else if(isset($_POST["updateStock"])) {
    $myFilters = [
        'product_name', 'product_unique_id', 'product_description' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ],
        'category_id', 'product_price', 'product_price' => [
          'sanitization' => 'number|trim',
          'validation' => 'required',
        ]
    ];

    $validator = new Validator($myFilters);
    $validationResults = $validator->run($_POST);
      
    if ($validationResults === FALSE) {
        $validationErrors = $validator->getValidationErrors();
        foreach($validationErrors as $error){
            $_SESSION['errorMessage'][] = $error;
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    } else {
        
        $sanitizedInputData = $validationResults;
        
        if($sanitizedInputData['product_price'] < $sanitizedInputData['costprice']) {
            $_SESSION['errorMessage'] = $clientLang["sp_less_cp"];
        }
        else {

            // Who is updating the stock...
            $adminInfo = $admin->getAdminById($_SESSION["adminId"]);
            $updated_by = $adminInfo->fullname;

            $stockId = $sanitizedInputData["stockId"];

            $getStock = $stock->getStockById($stockId);
            // Trying to get who created the stock initially...
            $memo = json_decode($getStock->memo);
            $created_by = $memo->created_by;

            $stockData = array(
                'stock_name' => $sanitizedInputData['product_name'], 
                'stock_unique_id' => $sanitizedInputData['product_unique_id'], 
                'stock_category_id' => $sanitizedInputData['category_id'], 
                'stock_price' => $sanitizedInputData['product_price'], 
                'stock_description' => $sanitizedInputData['product_description'],
                'memo' => json_encode(["created_by" => $created_by, "updated_by" => $updated_by]),
                "date_updated" => date("Y-m-d H:i:s")
            );

            $stockWhere = ["id" => $stockId];

            $updateStock = $stock->updateStockDetails($stockData, $stockWhere);

            if($updateStock) {
                $_SESSION['successMessage'] = $clientLang['updated'];
            }
            else {
                $_SESSION['errorMessage'] = $clientLang['request_failed'];
            }
        }
    }

    header("Location: ".$_SERVER["HTTP_REFERER"]);
    exit();
    
}
else if(isset($_REQUEST["searchStock"])) {
    
    $myFilters = [
        'stockId' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ]
    ];

    $validator = new Validator($myFilters);
    $validationResults = $validator->run($_GET);
      
    if ($validationResults === FALSE) {
        $validationErrors = $validator->getValidationErrors();
        foreach($validationErrors as $error){
            $response['error'][] = $error;
        }
    } else {
        $sanitizedInputData = $validationResults;

        $getStock = $stock->searchStock($sanitizedInputData["stockId"]);
        
        if($getStock === false) {
            $response['error'][] = "No result found";
        }
        else {
            $response['items'] = (array)$getStock;
            $response['total_count'] = count((array)$getStock);
        }    
    }

    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($response, JSON_PRETTY_PRINT);

}
else if(isset($_POST["updateStockQty"])) {

    $myFilters = [
        'stock_unique_id' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ],
        'product_quantity' => [
            'sanitizations' => 'number|trim',
            'validations' => 'required',
        ]
    ];
    
    $validator = new Validator($myFilters);
    $validationResults = $validator->run($_POST);

    if ($validationResults === FALSE) {
        $validationErrors = $validator->getValidationErrors();
        foreach($validationErrors as $error){
            $_SESSION['errorMessage'][] = $error;
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    } else {
        $sanitizedInputData = $validationResults;
        $quantity = $sanitizedInputData["product_quantity"];
        $stock_unique_id = $sanitizedInputData["stock_unique_id"];
        $updateStock = $stock->updateStockQuantity($quantity , $stock_unique_id);

        if($updateStock) {
            $_SESSION["successMessage"] = $clientLang["updated"];
        }
        else {
            if(isset($_SESSION["stock_not_exists"])) {
                unset($_SESSION["stock_not_exists"]);
                $_SESSION["errorMessage"] = $clientLang["item_does_not_exist"];
            }
            else {
                $_SESSION["errorMessage"] = $clientLang["request_failed"];
            }
        }

        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();

    }
    
}
else if(isset($_POST["updateCostPrice"])) {

    $myFilters = [
        'costprice', 'stock_id' => [
          'sanitization' => 'number|trim',
          'validation' => 'required',
        ]
    ];

    $validator = new Validator($myFilters);
    $validationResults = $validator->run($_POST);
      
    if ($validationResults === FALSE) {
        $validationErrors = $validator->getValidationErrors();
        foreach($validationErrors as $error){
            $_SESSION['errorMessage'][] = $error;
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    } else {
        $sanitizedInputData = $validationResults;

        $getStock = $stock->getStockById($sanitizedInputData["stock_id"]);

        if($getStock === false) {
            $_SESSION['errorMessage'] = $clientLang["item_does_not_exist"];
        }
        else if($getStock->stock_price < $sanitizedInputData['costprice']) {
            $_SESSION['errorMessage'] = $clientLang["sp_less_cp"];
        }
        else {
            
            $costPriceData = ["stock_costprice" => $sanitizedInputData['costprice']];
            $updateWhere = ["id" => $sanitizedInputData['stock_id']];

            $updateCostPrice = $stock->updateCostPrice($costPriceData, $updateWhere);

            if($updateCostPrice) {
                $_SESSION['successMessage'] = $clientLang["updated"];
            }
            else {
                $_SESSION['errorMessage'] = $clientLang["request_failed"];
            }
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    }
}
else if(isset($_POST["cart"])) {
    
    $operation = $_POST["operation"];

    switch($operation) {
        case "add":
            $myFilters = [
                'stock_id: Stock ID' => [
                    'sanitizations' => 'string|trim',
                    'validations' => 'required',
                ]
            ];
            $validator = new Validator($myFilters);
            $validationResults = $validator->run($_POST);

            if ($validationResults === FALSE) {
                $validationErrors = $validator->getValidationErrors();
                foreach ($validationErrors as $error) {
                    $response['error'][] = $error;
                }
            } 
            else {
                $sanitizedInputData = $validationResults;
                
                $theStock = $stock->getStockByStockId($sanitizedInputData['stock_id']);

                if ($theStock !== false) {

                    $quantity = $sanitizedInputData["quantity"];

                    if($theStock->stock_qty >= $quantity) {

                        $unitSellingPrice = $theStock->stock_price;
                        $actualSubTotal = $unitSellingPrice * $quantity;
                        $subTotal = $unitSellingPrice * $quantity;

                        if ($unitSellingPrice != false AND (int)trim($unitSellingPrice) > 0) {
                            if ($unitSellingPrice > 0 AND $theStock->stock_price > $theStock->stock_costprice) {

                                $cartItems = array(
                                    $theStock->id => array(
                                        'stock_name' => $theStock->stock_name,
                                        'stock_id' => $theStock->stock_unique_id,
                                        'quantity' => $quantity,
                                        'unit_price' => $unitSellingPrice,
                                        'sub_total' => $subTotal,
                                    )
                                ); 

                                if (!empty($_SESSION['cartItem']['items'])) {
                                    if (in_array($theStock->id, array_keys($_SESSION['cartItem']['items']))) {

                                        foreach ($cartItems as $stockId => $cartItem) {
                                            if ($theStock->id == $stockId) {
                                                if (empty($_SESSION['cartItem']['items'][$theStock->id]['quantity'])) {
                                                    $_SESSION['cartItem']['items'][$theStock->id]['quantity'] = 0;
                                                }

                                                $_SESSION['cartItem']['items'][$theStock->id]['quantity'] += $quantity;
                                                $_SESSION['cartItem']['items'][$theStock->id]['sub_total'] += ($unitSellingPrice * $quantity);
                                            }
                                        }
                                    }
                                    else {
                                        $_SESSION['cartItem']['items'] = $_SESSION['cartItem']['items'] + $cartItems;
                                    }
                                }
                                else {
                                    $_SESSION['cartItem']['items'] = $cartItems;
                                }
                                                 
            
                                $grandTotal = 0;

                                // Let's get the grand total...
                                foreach ($_SESSION['cartItem']['items'] as $index => $cartItem) {
                                    $grandTotal += $cartItem['sub_total'];
                                }              

                                $_SESSION['cartItem']['grand_total'] = $grandTotal;
                                
                                $response = $_SESSION['cartItem']['items'];

                            }
                            else {
                                $response['error'][] = $clientLang["sp_less_cp"];
                            }
                        }
                        else {
                            $response['error'][] = "No price set for <strong>".$theStock->stock_name."</strong>. Kindly set a selling price";
                        }

                    }
                    else {
                        $response['error'][] = "<strong>".$theStock->stock_name."</strong> is left with $theStock->stock_qty quantities. Kindly Stock in";
                    }

                }
                else {
                    $response['error'][] = $clientLang["item_does_not_exist"];
                }
            }
        break;

        case "update_quantity":
            
            $myFilters = [
                'stock_id' => [
                    'sanitizations' => 'number',
                    'validations' => 'required|numeric',
                ],
                'quantity' => [
                    'sanitizations' => 'number',
                    'validations' => 'required|numeric',
                ]
            ];
            $validator = new Validator($myFilters);
            $validationResults = $validator->run($_POST);

            if ($validationResults === FALSE) {
                $validationErrors = $validator->getValidationErrors();
                foreach ($validationErrors as $error) {
                    $response['error'][] = $error;
                }
            } else {
                $sanitizedInputData = $validationResults;
                $quantity = $sanitizedInputData['quantity'];
                $theStock = $stock->getStockById($sanitizedInputData['stock_id']);

                if($theStock !== false) {
                    if ($theStock->stock_qty >= $quantity) {

                        $unitSellingPrice = $theStock->stock_price;

                        if ($unitSellingPrice != false AND (int)trim($unitSellingPrice) > 0) {
                            if ($unitSellingPrice > 0 AND $theStock->stock_price > $theStock->stock_costprice) {
                                
                                $unitSellingPrice = $theStock->stock_price;
                                $actualSubTotal = $unitSellingPrice * $quantity;
                                $subTotal = $unitSellingPrice * $quantity;

                                $response = $unitSellingPrice;
                                
                                if (!empty($_SESSION["cartItem"]["items"])) {
                                    foreach ($_SESSION["cartItem"]["items"] as $stockId => $cartItem) {
                                        if ($theStock->id == $stockId) {
                                            if (empty($sanitizedInputData['quantity']) OR $sanitizedInputData['quantity'] == 0) {
                                                unset($_SESSION["cartItem"]["items"][$stockId]);
                                                $_SESSION['cartItem']['grand_total'] -= $cartItem['sub_total'];
                                            } else {
                                                $_SESSION['cartItem']['items'][$theStock->id]['unit_price'] = $unitSellingPrice;
                                                $_SESSION['cartItem']['items'][$theStock->id]['quantity'] = $sanitizedInputData['quantity'];
                                                $_SESSION['cartItem']['items'][$theStock->id]['sub_total'] = $subTotal;
                                            }
                                        }
                                    }
                                }

                                if (empty($_SESSION["cartItem"]["items"])) {
                                    unset($_SESSION["cartItem"]);
    
                                    $response = '';
                                } else {
                                    $grandTotal = 0;
                                    $totalDisc = 0;
                
                                    foreach ($_SESSION['cartItem']['items'] as $index => $cartItem) {
                                        $grandTotal += $cartItem['sub_total'];
                                    }
                
                                    $_SESSION['cartItem']['grand_total'] = $grandTotal;
                                    
                                    $response = $_SESSION['cartItem']['items'];
                                }

                            }
                            else {
                                $response['error'][] = $clientLang["sp_less_cp"];
                            }
                        }
                        else {
                            $response['error'][] = "No price set for <strong>".$theStock->stock_name."</strong>. Kindly set a selling price";
                        }
                    }
                    else {
                        $response['error'][] = "Product is left with $theStock->stock_qty quantities. Kindly Stock in";
                    }
                }
                else {
                    $response['error'][] = $clientLang["item_does_not_exist"];
                }
            }
        break;

        case "remove":
            
            $myFilters = [
                'stock_id' => [
                    'sanitizations' => 'number',
                    'validations' => 'required|numeric',
                ],
            ];

            $validator = new Validator($myFilters);
            $validationResults = $validator->run($_POST);

            if ($validationResults === FALSE) {
                $validationErrors = $validator->getValidationErrors();
                foreach ($validationErrors as $error) {
                    $response['error'][] = $error;
                }
            } else {
                $sanitizedInputData = $validationResults;
                $theStock = $stock->getStockById($sanitizedInputData['stock_id']);

                if ($theStock != false) {
                    if (!empty($_SESSION["cartItem"]["items"])) {
                        foreach ($_SESSION["cartItem"]["items"] as $stockId => $cartItem) {
                            if ($theStock->id == $stockId) {
                                unset($_SESSION["cartItem"]["items"][$stockId]);
                                $_SESSION['cartItem']['grand_total'] -= $cartItem['sub_total'];
                            }

                            if (empty($_SESSION["cartItem"]["items"])) {
                                unset($_SESSION["cartItem"]);
                            }
                        }

                        $response = empty($_SESSION['cartItem']['items'])? '':$_SESSION['cartItem']['items'];
                    }
                }
            }
        break;

        case 'empty':
            unset($_SESSION["cartItem"]);
            $response = '';
        break;
    }

    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($response, JSON_PRETTY_PRINT);

}
elseif (isset($_REQUEST['openStock'])) {
    if ($allSettings->stock_status == 'opened') {
        $_SESSION['errorMessage'] = "Stock is opened!";
        header("Location: " . BASE_URL."stockUpdate");
        exit();
    } else {
        $stockUpdate = $stock->doStockDailyUpdate('open');

        if ($stockUpdate) {
            $_SESSION['successMessage'] = "Stock is opened!";
            header("Location: " . BASE_URL."stockUpdate");
            exit();
        } else {
            $_SESSION['errorMessage'] = $clientLang['request_failed'];
            header("Location: " . BASE_URL."stockUpdate");
            exit();
        }
    }
} elseif (isset($_REQUEST['closeStock'])) {
    if ($allSettings->stock_status == 'clossed') {
        $_SESSION['errorMessage'] = "Stock is closed!";
        header("Location: " . BASE_URL."stockUpdate");
        exit();
    } else {
        $stockUpdate = $stock->doStockDailyUpdate('close');

        if ($stockUpdate) {
            $_SESSION['successMessage'] = "Stock is closed!";
            header("Location: " . BASE_URL."stockUpdate");
            exit();
        } else {
            $_SESSION['errorMessage'] = $clientLang['request_failed'];
            header("Location: " . BASE_URL."stockUpdate");
            exit();
        }
    }
}
else {
    header("Location: ".BASE_URL."logout");
    exit(); 
}

?>