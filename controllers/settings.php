<?php
require_once '../includes/config.php';
require_once CLASS_DIR.'Validator.php';

$settings = new Settings($db);

if (isset($_POST["updateSettings"])) {
    $myFilters = [
        'site_title', 'office_address_1', 'office_address_2', 'site_phone', 'default_user_password', 'invoice_info', 'receipt_info_1', 'receipt_info_2' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ],
        'site_email' => [
          'sanitization' => 'email|trim',
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
        
        $updateData = [
            "site_title" => $sanitizedInputData['site_title'],
            "site_email" => $sanitizedInputData['site_email'],
            "office_address_1" => $sanitizedInputData['office_address_1'],
            "office_address_2" => $sanitizedInputData['office_address_2'],
            "site_phone" => $sanitizedInputData['site_phone'],
            "default_user_password" => $sanitizedInputData['default_user_password'],
            "invoice_info" => $sanitizedInputData['invoice_info'],
            "receipt_info_1" => $sanitizedInputData['receipt_info_1'],
            "receipt_info_2" => $sanitizedInputData['receipt_info_2'],
            "low_quantity_threshold" => $sanitizedInputData['low_quantity_threshold'],
        ];

        $updateWhere = [ "site_title", "site_email", "office_address_1", "office_address_2", "site_phone", "default_user_password", "invoice_info", "invoice_info", "invoice_info", "low_quantity_threshold" ];
        
        $updateApp = 0;

        for($i = 0; $i<count($updateWhere); $i++) {
            $value = $updateData[$updateWhere[$i]];
            $settings->saveAppInfo($updateWhere[$i], $value, date("Y-m-d H:i:s"));
            $updateApp++;
        }

        if($updateApp > 0) {
            $_SESSION['successMessage'] = $clientLang['updated'];
        }
        else {
            $_SESSION['errorMessage'] = $clientLang['request_failed'];
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    }
}
else {
    header("Location: ".BASE_URL."logout");
    exit(); 
}

?>