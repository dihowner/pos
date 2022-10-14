<?php
require_once '../includes/config.php';
require_once CLASS_DIR.'Validator.php';
require_once MODEL_DIR.'Authorization.php';
require_once MODEL_DIR.'Admin.php';

if (isset($_POST["adminLogin"])) {
    $myFilters = [
        'username' => [
          'sanitizations' => 'string',
          'validations' => 'required',
        ],
        'password' => [
          'sanitization' => 'string',
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
        $username = $sanitizedInputData['username'];
        $password = $sanitizedInputData['password'];

        $userResult = $admin->getAdminById($username);
        $hashPassword = $userResult->password;
        unset($userResult->password);
        
        if($userResult) {
            if (password_verify($password, $hashPassword)) {
                $loggedIn = $admin->processLogin($username);
                if (!$loggedIn) {
                    $_SESSION["errorMessage"] = $clientLang['unexpected_error'];
                    header("Location: ".$_SERVER["HTTP_REFERER"]);
                    exit();
                } else {
                    $utility->redirectToPreviewPage();
                } 
            } else {
                $_SESSION['errorMessage'] = $clientLang['password_not_match'];
                header("Location: ".$_SERVER["HTTP_REFERER"]);
                exit();
            }
        } else {
            $_SESSION['errorMessage'] = $clientLang['username_not_exist'];
            header("Location: ".$_SERVER["HTTP_REFERER"]);
            exit();
        }
    }
}
else if(isset($_POST["createAdmin"])) {
    
    $myFilters = [
        'admin_name', 'admin_username', 'admin_phone_no', 'admin_password' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ],
        'admin_email' => [
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

        $adminData = array(
            'fullname' => $sanitizedInputData['admin_name'], 
            'username' => $sanitizedInputData['admin_username'], 
            'email' => $sanitizedInputData['admin_email'], 
            'mobile' => $sanitizedInputData['admin_phone_no'], 
            'password' => password_hash($sanitizedInputData['admin_password'], PASSWORD_BCRYPT),
            "date_created" => date("Y-m-d H:i:s")
        );

        $createAdmin = $admin->createAdmin($adminData);

        if($createAdmin) {
            $_SESSION['successMessage'] = $clientLang["created"];
        } 
        else {
            if(isset($_SESSION["username_exist"])) {
                $_SESSION["errorMessage"] = $clientLang['username_exist'];
                unset($_SESSION["username_exist"]);
            }
            else {
                $_SESSION['errorMessage'] = $clientLang["request_failed"];
            }
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    }
}
else if(isset($_POST["updateAdmin"])) {    
    
    $myFilters = [
        'admin_name', 'admin_username', 'admin_phone' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ],
        'admin_email' => [
          'sanitization' => 'email|trim',
          'validation' => 'required',
        ],
        'adminId' => [
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

        $updateData = [
            "fullname" => $sanitizedInputData["admin_name"],
            "username" => $sanitizedInputData["admin_username"],
            "email" => $sanitizedInputData["admin_email"],
            "mobile" => $sanitizedInputData["admin_phone"]
        ];

        $updateWhere = ["id" => $sanitizedInputData["adminId"]];

        $updateAdmin = $admin->updateAdmin($updateData, $updateWhere);

        if($updateAdmin) {
            $_SESSION['successMessage'] = $clientLang["updated"];
        }
        else {
            if(isset($_SESSION["username_exist"])) {
                $_SESSION["errorMessage"] = $clientLang['username_exist'];
                unset($_SESSION["username_exist"]);
            }
            else  if(isset($_SESSION["email_exist"])) {
                $_SESSION["errorMessage"] = $clientLang['email_exist'];
                unset($_SESSION["email_exist"]);
            }
            else {
                $_SESSION['errorMessage'] = $clientLang["request_failed"];
            }
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    }
}
else if(isset($_REQUEST["deleteAdmin"])) {

    $myFilters = [
        'id' => [
          'sanitization' => 'number|trim',
          'validation' => 'required',
        ]
    ];

    $validator = new Validator($myFilters);
    $validationResults = $validator->run($_REQUEST);
      
    if ($validationResults === FALSE) {
        $validationErrors = $validator->getValidationErrors();
        foreach($validationErrors as $error){
            $_SESSION['errorMessage'][] = $error;
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    } else {

        $sanitizedInputData = $validationResults;

        $adminId = $sanitizedInputData["id"];
        
        $deleteAdmin = $admin->deleteAdmin($adminId);

        if($deleteAdmin) {
            $_SESSION['successMessage'] = $clientLang["deleted"];
        }
        else {
            $_SESSION['errorMessage'] = $clientLang["request_failed"];
        }
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    }
}
else if(isset($_POST["changeAdminPassword"])) {

    $myFilters = [
        'newPassword', 'confirmPass' => [
          'sanitization' => 'string|trim',
        //   'validation' => 'required|min:4',
          'validation' => 'required',
        ],
        'adminId' => [
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

        if($sanitizedInputData['newPassword'] != $sanitizedInputData['confirmPass']) {
            $_SESSION['errorMessage'] = $clientLang["password_not_match"];
        }
        else {
            $updatePassword = $admin->updatePassword($sanitizedInputData['newPassword'], $sanitizedInputData['adminId']);

            if($updatePassword) {
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
else {
    header("Location: ".BASE_URL."logout");
    exit(); 
}

?>