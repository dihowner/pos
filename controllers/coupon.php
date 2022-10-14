<?php
require_once '../includes/config.php';
require_once CLASS_DIR.'Validator.php';

require_once MODEL_DIR."Coupon.php";
$coupon = new Coupon($db);

if(isset($_POST["applyCoupon"])) {
    
    $myFilters = [
        'coupon_code' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ]
    ];

    // Current time
    $currentTime = strtotime(date("Y-m-d H:i:s"));

    $validator = new Validator($myFilters);
    $validationResults = $validator->run($_POST);

    if ($validationResults === FALSE) {
        $validationErrors = $validator->getValidationErrors();
        foreach($validationErrors as $error){
            $response['error'][] = $error;
        }
    } else {
        $sanitizedInputData = $validationResults;

        $getCoupon = $coupon->getCouponByCode($sanitizedInputData["coupon_code"]);

        if($getCoupon !== false) {
            // When is coupon meant to expire
            $coupon_expiration_time = $getCoupon->date_expired;
            $convertExpire = strtotime($coupon_expiration_time);

            // What's the status of this coupn
            $coupon_status = $getCoupon->coupon_status;

            if($convertExpire > $currentTime) {
                
                if($coupon_status == 1) {
                    
                    if(isset($_SESSION["cartItem"])) {

                        if((int)trim($_SESSION['cartItem']["grand_total"]) > 0) {

                            $coupon_amount = (float)($getCoupon->amount);

                            // How much dey my cart before...
                            $grand_total = (float)($_SESSION['cartItem']["grand_total"]);

                            if($coupon_amount > $grand_total) {
                                $response['error'][] = "Coupon code not be applied. Your cart  grand total is less than ₦".number_format($coupon_amount, 2);
                            }
                            else {
                                $coupon_array = ["coupon_code" => $sanitizedInputData["coupon_code"], "amount" => $coupon_amount ];
                                $_SESSION['cartItem']['coupon'] = $coupon_array;
                                    
                                $response = $_SESSION['cartItem']['coupon'];
                            }
                        }
                        else {
                            $response['error'][] = "Cart Grand total cannot be zero";
                        }
                    }
                    else {
                        $response['error'][] = "Your cart is currently empty. Add Item to your cart list";
                    }

                }
                else {
                    $response['error'][] = "Coupon code (".strtoupper($sanitizedInputData['coupon_code']).") is currently inactive";
                }

            }
            else {
                $response['error'][] = "Coupon code (".strtoupper($sanitizedInputData['coupon_code']).") expired";
            }
        }
        else {
            $response['error'][] = "Coupon code (".strtoupper($sanitizedInputData['coupon_code']).") not found";
        }

    }

    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($response, JSON_PRETTY_PRINT);

}
else if(isset($_POST["removeCouponCart"])) {
    if(isset($_SESSION['cartItem']['coupon'])) {
        unset($_SESSION['cartItem']['coupon']);
    }
}
else if(isset($_POST["covertDateTime"])) {
    echo $utility->niceDateFormat($_POST['datetime']);
}
else if(isset($_POST["createCoupon"])) {
    $myFilters = [
        'coupon_code' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ],
        'coupon_amount' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ],
        'date_expiry: Expiring date' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ]
    ];

    // Current time
    $currentDate = strtotime(date("Y-m-d 00:00"));

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
    
        $dateExpiry = $sanitizedInputData["date_expiry"]. ' 00:00';

        if($currentDate > strtotime($dateExpiry)) {
            $_SESSION['errorMessage'] = "Expiry date (".$utility->niceDateFormat($dateExpiry).")is not a valid date";
        }
        else {
            $couponData = [
                "coupon_code" => strtoupper($sanitizedInputData["coupon_code"]),
                "amount" => (float)($sanitizedInputData["coupon_amount"]),
                "coupon_status" => 0,
                "date_expired" => $dateExpiry,
                "date_created" => date("Y-m-d H:i:s")
            ];
            
            $createCoupon = $coupon->createCoupon($couponData);

            if($createCoupon) {
                $_SESSION['successMessage'] = "Coupon created successfully";
                header("Location: " . $_SERVER["HTTP_REFERER"]);
                exit();
            } else {
                if(isset($_SESSION["coupon_exists"])) {
                    $_SESSION['errorMessage'] = $clientLang['coupon_exists'];
                    unset($_SESSION["coupon_exists"]);
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
}
else if(isset($_POST['updateCoupon'])) {
    
    $myFilters = [
        'coupon_code' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ],
        'coupon_amount' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ],
        'couponId: Expiring date' => [
          'sanitizations' => 'number|trim',
          'validations' => 'numeric',
        ],
    ];

    // Current time
    $currentDate = strtotime(date("Y-m-d 00:00"));

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
        
        if(!empty($sanitizedInputData["date_expiry"])) {
            $updateData = [
                "coupon_code" => $sanitizedInputData['coupon_code'],
                "amount" => $sanitizedInputData['coupon_amount'],
                "date_expired" => $sanitizedInputData['date_expiry']." 00:00"
            ];
        }
        else {
            $updateData = [
                "coupon_code" => $sanitizedInputData['coupon_code'],
                "amount" => $sanitizedInputData['coupon_amount']
            ];
        }
        
        $updateWhere= [
            "id" => $sanitizedInputData['couponId']
        ];

        $updateCoupon = $coupon->updateCoupon($updateData, $updateWhere);

        if($updateCoupon) {
            $_SESSION['successMessage'] = "Coupon updated successfully";
        }
        else {
            if(isset($_SESSION["coupon_exists"])) {
                $_SESSION['errorMessage'] = $clientLang['coupon_exists'];
                unset($_SESSION["coupon_exists"]);
            }
            else {
                $_SESSION['errorMessage'] = $clientLang['request_failed'];
            }
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    }
}
else if(isset($_REQUEST['deleteCoupon'])) {
    $couponId = $_REQUEST["id"];

    $result = $coupon->deleteCoupon($couponId);
    if($result) {
        $_SESSION['successMessage'] = $clientLang['deleted'];
    }
    else {
        $_SESSION['errorMessage'] = $clientLang['request_failed'];
    }

    header("Location: ".$_SERVER["HTTP_REFERER"]);
    exit();    
}
else {
    header("Location: ".BASE_URL."logout");
    exit(); 
}

?>