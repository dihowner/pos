<?php
// ini settings
ini_set("display_errors", 1);
ini_set("display_startup_errors", 1);

ini_set("memory_limit", "1024M");
ini_set('post_max_size', '20M');
ini_set('max_execution_time', 600);
ini_set('session.gc_maxlifetime', 24*60*40);

ob_start();
session_start();
error_reporting(E_ALL);
// error_reporting(0);
if(session_id() === NULL) {
    session_set_cookie_params(3600);
}

// Sever constants
define('SERVER', $_SERVER['SERVER_NAME']);
define ('PAGE', pathinfo(basename($_SERVER['PHP_SELF']), PATHINFO_FILENAME));
define('ROOT', $_SERVER['DOCUMENT_ROOT']);
define('SCHEME', $_SERVER['REQUEST_SCHEME']);
define('PORT', $_SERVER['SERVER_PORT']);
define('REQUEST_URI', $_SERVER['REQUEST_URI']);
define('SCRIPT_NAME', $_SERVER['SCRIPT_NAME']);
define('REFERER', in_array('HTTP_REFERER', array_keys($_SERVER)) ? $_SERVER['HTTP_REFERER']:'');

// SQL database parameters
if (SERVER != 'localhost' AND SERVER != '127.0.0.1' ) {
    define('BASE_PATH', '/');
    define('DB_NAME', 'devicext_deviceXtra');
    define('DB_USER', 'devicext_deviceXtra');
    define('DB_PASSWORD', 'nK%RP.!zU(6}');
    define('DB_HOST', 'localhost');
}else{
    define('BASE_PATH', '/2022/value_sales/');
    define('DB_NAME', 'valuesales');
    define('DB_USER', 'root');
    define('DB_PASSWORD', '');
    define('DB_HOST', 'localhost');
}

// Application constants
define('BASE_URL', SCHEME.'://'.SERVER.BASE_PATH);
define('MODEL_DIR', ROOT.BASE_PATH.'models/');
define('CONTROLLER_DIR', ROOT.BASE_PATH.'controllers/');
define('INCLUDES_DIR', ROOT.BASE_PATH.'includes/');
define('VENDOR_DIR', ROOT.BASE_PATH.'vendor/');
define('CLASS_DIR', ROOT.BASE_PATH.'classes/');
define('COMPONENT_DIR', ROOT.BASE_PATH.'components/');

define('UPLOADS_DIR', 'uploads/');
define('UPLOADS_PATH',  ROOT.BASE_PATH.UPLOADS_DIR);
define('PRODUCTS_UPLOADS_DIR', 'products/');
define('PROFILE_UPLOADS_DIR', 'profiles/');
define('LOGO_UPLOADS_DIR', 'logos/');


// Page name constant
$page = explode('.', PAGE);
define('PAGE_NAME', $page['0']);

// Requirements
require_once(VENDOR_DIR.'autoload.php');
require_once('Database.php');
require_once("mysql.session.php");

// Database Coonection
$dsn = "mysql:dbname=" . DB_NAME . ";host=" . DB_HOST . "";
$pdo = "";
try {
    $pdo = new PDO($dsn, DB_USER, DB_PASSWORD);
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
    die;
}
$db = new Database($pdo);

// Includes
include 'language.php';

// Initialize Models
include_once MODEL_DIR.'Utility.php';
$utility = new Utility($db);

require_once MODEL_DIR.'Settings.php';
$settings = new Settings($db);

require_once MODEL_DIR.'Authorization.php';
$auth = new Authorization($db);

require_once MODEL_DIR.'Admin.php';
$admin = new Admin($db);

require_once MODEL_DIR.'Category.php';
$category = new Category($db);

require_once MODEL_DIR.'Stock.php';
$category = new Stock($db);

require_once MODEL_DIR.'Sales.php';
$sales = new Sales($db);

$allSettings = $settings->getAllSettings();
define("SITE_TITLE", $allSettings->site_title);
define("SITE_EMAIL", $allSettings->site_email);
define("SITE_PHONE", $allSettings->office_phone);

// Default Time zone
date_default_timezone_set("Africa/Lagos");
