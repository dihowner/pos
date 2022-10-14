<?php
require_once '../includes/config.php';
require_once CLASS_DIR.'Validator.php';
// require_once MODEL_DIR.'Stock.php';

$stock = new Stock($db);

if (isset($_POST["action"]) ) {
    
    $myFilters = [
        'cart' => [
            'sanitizations' => 'string',
            'validations' => 'notempty',
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
        $salesRef = $utility->genSalesRef();
        $cartInfo = $_SESSION['cartItem'];
        $admin_id = $_SESSION["adminId"];
        
        $generateInvoice = $sales->initiateSales($salesRef, $cartInfo, $admin_id);

        if($generateInvoice) {
            $response['msg'] = "Invoice generated successfully. Kindly proceed to make payment";
            $response['sales_ref'] = $salesRef;
            unset($_SESSION['cartItem']);
        } else {
            $response['msg'][] = $clientLang['request_falied'];
        }
        
    }

    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($response, JSON_PRETTY_PRINT);

}
else if(isset($_POST["getInvoice"])) {

    $myFilters = [
        'invoice_number' => [
            'sanitizations' => 'number|trim',
            'validations' => 'notempty|required|numeric',
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

        $getSales = $sales->getSales($sanitizedInputData['invoice_number']);

        if($getSales !== false AND $getSales !== NULL) {
            $response = $getSales;
        }
        else {
            $response['error'][] = "Sales invoice number does not exists";
        }

    }

    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($response, JSON_PRETTY_PRINT);

}
else if(isset($_POST['submitSales'])) {
    
    $myFilters = [
        'invoiceNumber' => [
            'sanitizations' => 'string',
            'validations' => 'required',
        ]
    ];
    
    $validator = new Validator($myFilters);
    $validationResults = $validator->run($_POST);
    
    if ($validationResults === FALSE) {
        $validationErrors = $validator->getValidationErrors();
        foreach ($validationErrors as $error) {
            $_SESSION['errorMessage'][] = $error;
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    } else {
        $sanitizedInputData = $validationResults;

        // $staffId = $user->currentUser->id;
        $salesRef = $sanitizedInputData['invoiceNumber'];

        $theSales = $sales->getSales($salesRef);

        if($theSales === false) {
            $_SESSION['errorMessage'] = "Sales reference (".$salesRef.") does not exists";
        }
        else if($theSales !== false AND $theSales->payment_status > 0) {
            $_SESSION['errorMessage'] = "Sales already completed or cancelled";
        }
        else {
            $staffId = isset($_SESSION["adminId"]) ? $_SESSION["adminId"]: '';
            if($staffId == '') {
                $_SESSION['errorMessage'] = $clientLang['session_timeout'];
            } else {
                $processSales = $sales->processSales($salesRef, $staffId, 'complete');

                if($processSales) {
                    $_SESSION['successMessage'] = "Sales completed successfully";

                    header("Location: ".BASE_URL."paymentReceipt?reference=".$salesRef);
                    exit();
                }
                else {
                    $_SESSION['errorMessage'] = $clientLang['unexpected_error'];
                    header("Location: ".$_SERVER["HTTP_REFERER"]);
                    exit();
                }
            }
        }
    }
}
else if(isset($_POST['getSales'])) {

    $myFilters = [
        'sales_reference' => [
            'sanitizations' => 'string',
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
    } else {
        $sanitizedInputData = $validationResults;
        
        $theSales = $sales->getSales($sanitizedInputData['sales_reference']);

        if ($theSales != false) {
            $response['salesItem'] = (array)$theSales;
        } else {
            $response['error'][] = $clientLang['item_does_not_exist'];
        }
    }
    
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($response, JSON_PRETTY_PRINT);

}
else if (isset($_POST['checkout'])) {

    $response = array();
    $myFilters = [
        'sales_reference' => [
            'sanitizations' => 'string',
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
    } else {
        $sanitizedInputData = $validationResults;

        $theSales = $sales->getSales($sanitizedInputData['sales_reference']);

        if ($theSales != false) {
            $staffId = isset($_SESSION["adminId"]) ? $_SESSION["adminId"]: '';
            if($staffId == '') {
                $response['error'][] = $clientLang['session_timeout'];
            } else {
                $completeSales = $sales->processSales($sanitizedInputData['sales_reference'], $staffId, 'checkout');

                if ($completeSales) {
                    $response['msg'] = "Items delivered successfully";
                    $_SESSION['successMessage'] = $response['msg'];
                } else {
                    $response['error'][] = $clientLang['request_failed'];
                }
            }
        } else {
            $response['error'][] = $clientLang['item_does_not_exist'];
        }

    }
    
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($response, JSON_PRETTY_PRINT);

}
else if($_POST["cancelSales"]) {
    
    $myFilters = [
        'salesReference' => [
            'sanitizations' => 'string',
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
    } else {
        $sanitizedInputData = $validationResults;

        $theSales = $sales->getSales($sanitizedInputData['salesReference']);

        if ($theSales != false) {
            
            $staffId = isset($_SESSION["adminId"]) ? $_SESSION["adminId"]: '';
            if($staffId == '') {
                $response['error'][] = $clientLang['session_timeout'];
            } 
            else {
                $cancelSales = $sales->processSales($sanitizedInputData['salesReference'], $staffId, 'cancel');
                
                if ($cancelSales) {
                    $response['msg'] = "Sales canceled";
                } else {
                    $response['error'][] = $clientLang['request_failed'];
                }
            }
        } else {
            $response['error'][] = $clientLang['item_does_not_exist'];
        }
    }

    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($response, JSON_PRETTY_PRINT);
}

?>