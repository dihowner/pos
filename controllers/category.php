<?php
require_once '../includes/config.php';
require_once CLASS_DIR.'Validator.php';

$category = new Category($db);

if (isset($_POST["createCategory"])) {
    $myFilters = [
        'category_name' => [
          'sanitizations' => 'string|trim',
          'validations' => 'required',
        ],
        'category_description' => [
          'sanitization' => 'string|trim',
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
        $categoryData = array(
            'category_name' => $sanitizedInputData['category_name'], 
            'category_description' => $sanitizedInputData['category_description']
        );
        
        $result = $category->createCategory($categoryData);
        
        if($result) {
            $_SESSION['successMessage'] = $clientLang['created'];
            header("Location: ".$_SERVER["HTTP_REFERER"]);
            exit();
        } else {
            if(isset($_SESSION["category_exists"])) {
                $_SESSION['errorMessage'] = $clientLang['category_exist'];
                unset($_SESSION["category_exists"]);
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
else if(isset($_POST["updateCategory"])) {
    $myFilters = [
        'category_name' => [
          'sanitizations' => 'string',
          'validations' => 'required',
        ],
        'description' => [
          'sanitization' => 'string',
          'validation' => 'required',
        ],
        'categoryId' => [
          'sanitization' => 'number',
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
        $categoryData = array(
            'category_name' => $sanitizedInputData['category_name'], 
            'description' => $sanitizedInputData['description']
        );

        $result = $category->updateCategory($categoryData, $sanitizedInputData['categoryId']);

        if($result) {
            $_SESSION['successMessage'] = $clientLang['updated'];
            header("Location: ".$_SERVER["HTTP_REFERER"]);
            exit();
        } else {
            if(isset($_SESSION["category_exists"])) {
                $_SESSION['errorMessage'] = $clientLang['category_exist'];
                unset($_SESSION["category_exists"]);
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
else if(isset($_REQUEST["deleteCategory"])) {
    $categoryId = $_REQUEST["id"];
    $deleteCategory = $category->deleteCategory(['id' => $categoryId]);
    if($deleteCategory) {
        $_SESSION['successMessage'] = $clientLang['deleted'];
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    } else {
        $_SESSION['errorMessage'] = $clientLang['request_failed'];
        header("Location: ".$_SERVER["HTTP_REFERER"]);
        exit();
    }
}
else {
    header("Location: ".BASE_URL."logout");
    exit(); 
}

?>