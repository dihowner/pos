<?php
require_once MODEL_DIR.'Authorization.php';

$auth = new Authorization($db);

if (PAGE_NAME == 'logout') {
    if ($user->isLoggedIn() === false) {
        $referer = (REFERER == '' OR REFERER == NULL) ? BASE_URL.'login' : REFERER;
        header('Location: '.$referer);
        exit();
    }
} else {
    $pageInfo = $auth->getPage(PAGE_NAME);

    if(!isset($_SESSION['adminId']) AND PAGE_NAME !== "login") {
        header('Location: '.BASE_URL.'login');
    }
    else if(isset($_SESSION['adminId']) AND PAGE_NAME === "login") {
        header("location: dashboard");
    }

    if(isset($_SESSION['adminId'])) {
        $adminId = $_SESSION['adminId'];
        $getAdmin = $admin->getAdminById($adminId);
    }
    
}