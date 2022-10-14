<?php include "./includes/config.php"; 
require_once INCLUDES_DIR.'session_check.php';

// require_once MODEL_DIR.'Settings.php';
// $settings = new Settings($db);

$pageTitle = !isset($pageInfo->title) ? NULL: $pageInfo->title; 

// print_r($settings->getAllSettings());

?>

<!DOCTYPE html>
<html lang="en" class="h-100">
    
<head>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="keywords" content="admin, dashboard" />
	<meta name="author" content="DexignZone" />
	<meta name="robots" content="index, follow" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="tixia : tixia School Admission Admin  Bootstrap 5 Template" />
	<meta property="og:title" content="tixia : tixia School Admission Admin  Bootstrap 5 Template" />
	<meta property="og:description" content="tixia : tixia School Admission Admin  Bootstrap 5 Template" />
	<meta property="og:image" content="social-image.png" />
	<meta name="format-detection" content="telephone=no">
    <title><?php echo $pageTitle ?> - <?php echo SITE_TITLE;?> </title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
	<link href="<?php echo BASE_URL ?>templatevendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
    <link href="<?php echo BASE_URL ?>templatevendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">
	<link href="<?php echo BASE_URL ?>templatevendor/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
	<link href="<?php echo BASE_URL ?>templatevendor/bootstrap-material-datetimepicker/css/bootstrap-material-datetimepicker.css" rel="stylesheet">
    <link href="<?php echo BASE_URL ?>css/style.css" rel="stylesheet">
    <!-- <script src="https://use.fontawesome.com/3c6c4b12a9.js"></script> -->
	<!-- <script src="https://kit.fontawesome.com/5e8367199a.js" crossorigin="anonymous"></script> -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/fontawesome.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/solid.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/solid.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.0/dist/sweetalert2.all.min.js"></script>

	<style>
		.btn_circle {
			border-radius: 1.25em; 
			margin: 5px;
		}

		.msg_cell {
			border: 1px solid #c4c4c4;
			border-radius: 5px;
			padding: 10px;
		}
		.form-control:disabled, .form-control[readonly] {
			background: #c4c4c4;
			opacity: 1;
		}
		.card {
			margin-bottom: 1.875rem;
			background-color: #fff;
			transition: all .5s ease-in-out;
			position: relative;
			border: 0px solid transparent;
			border-radius: 1.25rem;
			height: auto;
		}
		.btn {
			border-radius: 1.25rem;
		}
		.card-header {
			color: #000;
		}
		label, .form-control, .form-control:hover {
			color: black;
			font-size: 18px;
		}
	</style>


</head>