<?php require "components/head.php";
// require_once MODEL_DIR."Stock.php";
$stock = new Stock($db);
$category = new Category($db);
$sales = new Sales($db);

// Today's Sales Record
$todaySales = $sales->getSalesAmount('today_sales')['grand_total'];
$todayDiscount = $sales->getSalesAmount('today_sales')['grand_discount'];
$todayGrandSales = (float) ($todaySales - $todayDiscount);

// This Week Sales Record
$weekSales = $sales->getSalesAmount('this_week')['grand_total'];
$weekDiscount = $sales->getSalesAmount('this_week')['grand_discount'];
$weekGrandSales = (float) ($weekSales - $weekDiscount);

// This Month Sales Record
$thisMonthSales = $sales->getSalesAmount('this_month')['grand_total'];
$thisMonthDiscount = $sales->getSalesAmount('this_month')['grand_discount'];
$thisMonthGrandSales = (float) ($thisMonthSales - $thisMonthDiscount);

$availableStockWorth = $stock->getStock("total_stock_available_worth")['costPrice'];
$unavailableStockWorth = $stock->getStock("total_stock_unavailable_worth")['costPrice'];
// print_r($sales->getSalesAmount('this_week'));

// die;
?>
<body>

    <!--*******************
        Preloader start
    ********************-->
    <?php include_once COMPONENT_DIR."preloader.php";?>
    <!--*******************
        Preloader end
    ********************-->

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">
        
        <?php include COMPONENT_DIR."topnav.php"; ?>
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->

        <!--**********************************
            Sidebar start
        ***********************************-->
        <?php require COMPONENT_DIR."sidebar.php"; ?>
        <!--**********************************
            Sidebar end
        ***********************************-->
		
		<!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
            <!-- row -->
			<div class="container-fluid">
                <div class="row">
                
                    <div class="col-xl-12">
                        <?php if($stock->getLowQuantity_Threshold_Stock() > 0) { ?>
                            <div class="alert alert-info left-icon-big alert-dismissible alert-alt fade show" style="font-size: 20px">
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close"></button>
                            
                                <div class="media">
                                    <div class="alert-left-icon-big">
                                        <span class="">
                                            <!-- <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="mr-2"><polygon points="7.86 2 16.14 2 22 7.86 22 16.14 16.14 22 7.86 22 2 16.14 2 7.86 7.86 2"></polygon><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg> -->
                                            <i class="fa fa-exclamation-circle"></i>
                                        </span>
                                    </div>

                                    <div class="media-body" style="margin-top: 5px">
                                        <strong>Notification:</strong> Some stocks are going out of stock. Kindly stock up 
                                        <a href="<?php echo BASE_URL;?>availableStock" class="btn btn-secondary btn-sm">Visit Store</a> 
                                    </div>
                                </div>
                            </div>
                        <?php } ?>
                    </div>
                    
                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <i class="fa fa-briefcase fa-4x" style="color: #2130b8"></i>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">Total Stock</p>
                                        <h3 class="mb-0 text-black font-w600"><?php echo $stock->getStock('total_stock');?></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div class="card">
                            <a href="<?php echo BASE_URL;?>availableStock">
                                <div class="card-body">
                                    <div class="media align-items-center">
                                        <span class="me-4">
                                            <i class="fa fa-folder-open fa-4x" style="color: #2130b8"></i>
                                        </span>
                                        <div class="media-body ms-1">
                                            <p class="mb-2">Available Stock</p>
                                            <h3 class="mb-0 text-black font-w600"><?php echo $stock->getStock('available_stock');?></h3>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div class="card">
                            <a href="<?php echo BASE_URL;?>unavailableStock">
                                <div class="card-body">
                                    <div class="media align-items-center">
                                        <span class="me-4">
                                            <i class="fa fa-briefcase fa-4x" style="color: #2130b8"></i>
                                        </span>
                                        <div class="media-body ms-1">
                                            <p class="mb-2">Unavailable Stock</p>
                                            <h3 class="mb-0 text-black font-w600"><?php echo $stock->getStock('unavailable_stock');?></h3>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div class="card">
                            <a href="<?php echo BASE_URL;?>category">
                                <div class="card-body">
                                    <div class="media align-items-center">
                                        <span class="me-4">
                                            <svg class="primary-icon" width="50" height="53" viewBox="0 0 50 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <rect width="7.11688" height="52.1905" rx="3" transform="matrix(-1 0 0 1 49.8184 0)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="37.9567" rx="3" transform="matrix(-1 0 0 1 35.585 14.2338)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="16.6061" rx="3" transform="matrix(-1 0 0 1 21.3516 35.5844)" fill="#2130B8"></rect>
                                            <rect width="8.0293" height="32.1172" rx="3" transform="matrix(-1 0 0 1 8.0293 20.0732)" fill="#2130B8"></rect>
                                            </svg>
                                        </span>
                                        <div class="media-body ms-1">
                                            <p class="mb-2">Total Category</p>
                                            <h3 class="mb-0 text-black font-w600"><?php echo $category->countCategories();?></h3>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <svg class="primary-icon" width="50" height="53" viewBox="0 0 50 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect width="7.11688" height="52.1905" rx="3" transform="matrix(-1 0 0 1 49.8184 0)" fill="#2130B8"></rect>
                                        <rect width="7.11688" height="37.9567" rx="3" transform="matrix(-1 0 0 1 35.585 14.2338)" fill="#2130B8"></rect>
                                        <rect width="7.11688" height="16.6061" rx="3" transform="matrix(-1 0 0 1 21.3516 35.5844)" fill="#2130B8"></rect>
                                        <rect width="8.0293" height="32.1172" rx="3" transform="matrix(-1 0 0 1 8.0293 20.0732)" fill="#2130B8"></rect>
                                        </svg>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">Total Stock Net Worth</p>
                                        <h3 class="mb-0 text-black font-w600">&#8358;<?php echo number_format($availableStockWorth, 2);?></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <svg class="primary-icon" width="50" height="53" viewBox="0 0 50 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect width="7.11688" height="52.1905" rx="3" transform="matrix(-1 0 0 1 49.8184 0)" fill="#2130B8"></rect>
                                        <rect width="7.11688" height="37.9567" rx="3" transform="matrix(-1 0 0 1 35.585 14.2338)" fill="#2130B8"></rect>
                                        <rect width="7.11688" height="16.6061" rx="3" transform="matrix(-1 0 0 1 21.3516 35.5844)" fill="#2130B8"></rect>
                                        <rect width="8.0293" height="32.1172" rx="3" transform="matrix(-1 0 0 1 8.0293 20.0732)" fill="#2130B8"></rect>
                                        </svg>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">Unavailable Stock Net Worth</p>
                                        <h3 class="mb-0 text-black font-w600">&#8358;<?php echo number_format($unavailableStockWorth, 2);?></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">

                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <svg class="primary-icon" width="50" height="53" viewBox="0 0 50 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect width="7.11688" height="52.1905" rx="3" transform="matrix(-1 0 0 1 49.8184 0)" fill="#2130B8"></rect>
                                        <rect width="7.11688" height="37.9567" rx="3" transform="matrix(-1 0 0 1 35.585 14.2338)" fill="#2130B8"></rect>
                                        <rect width="7.11688" height="16.6061" rx="3" transform="matrix(-1 0 0 1 21.3516 35.5844)" fill="#2130B8"></rect>
                                        <rect width="8.0293" height="32.1172" rx="3" transform="matrix(-1 0 0 1 8.0293 20.0732)" fill="#2130B8"></rect>
                                        </svg>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">Today's Sales</p>
                                        <h3 class="mb-0 text-black font-w600">&#8358;<?php echo number_format($todaySales, 2);?></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <svg class="primary-icon" width="50" height="53" viewBox="0 0 50 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <rect width="7.11688" height="52.1905" rx="3" transform="matrix(-1 0 0 1 49.8184 0)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="37.9567" rx="3" transform="matrix(-1 0 0 1 35.585 14.2338)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="16.6061" rx="3" transform="matrix(-1 0 0 1 21.3516 35.5844)" fill="#2130B8"></rect>
                                            <rect width="8.0293" height="32.1172" rx="3" transform="matrix(-1 0 0 1 8.0293 20.0732)" fill="#2130B8"></rect>
                                        </svg>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">This Week Sales</p>
                                        <h3 class="mb-0 text-black font-w600">&#8358;<?php echo number_format($weekSales, 2);?></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <svg class="primary-icon" width="50" height="53" viewBox="0 0 50 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <rect width="7.11688" height="52.1905" rx="3" transform="matrix(-1 0 0 1 49.8184 0)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="37.9567" rx="3" transform="matrix(-1 0 0 1 35.585 14.2338)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="16.6061" rx="3" transform="matrix(-1 0 0 1 21.3516 35.5844)" fill="#2130B8"></rect>
                                            <rect width="8.0293" height="32.1172" rx="3" transform="matrix(-1 0 0 1 8.0293 20.0732)" fill="#2130B8"></rect>
                                        </svg>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">This Month Sales</p>
                                        <div class="d-flex align-items-center">
                                            <h3 class="mb-0 me-3 text-black font-w600">&#8358;<?php echo number_format($thisMonthSales, 2);?></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                                        
                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <i class="fa fa-solid fa-badge-percent"></i>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">Today's Discount Sales</p>
                                        <h3 class="mb-0 text-black font-w600">&#8358;<?php echo number_format($todayDiscount, 2);?></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <svg class="primary-icon" width="50" height="53" viewBox="0 0 50 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <rect width="7.11688" height="52.1905" rx="3" transform="matrix(-1 0 0 1 49.8184 0)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="37.9567" rx="3" transform="matrix(-1 0 0 1 35.585 14.2338)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="16.6061" rx="3" transform="matrix(-1 0 0 1 21.3516 35.5844)" fill="#2130B8"></rect>
                                            <rect width="8.0293" height="32.1172" rx="3" transform="matrix(-1 0 0 1 8.0293 20.0732)" fill="#2130B8"></rect>
                                        </svg>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">This Week Discount Sales</p>
                                        <h3 class="mb-0 text-black font-w600">&#8358;<?php echo number_format($weekDiscount, 2);?></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <svg class="primary-icon" width="50" height="53" viewBox="0 0 50 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <rect width="7.11688" height="52.1905" rx="3" transform="matrix(-1 0 0 1 49.8184 0)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="37.9567" rx="3" transform="matrix(-1 0 0 1 35.585 14.2338)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="16.6061" rx="3" transform="matrix(-1 0 0 1 21.3516 35.5844)" fill="#2130B8"></rect>
                                            <rect width="8.0293" height="32.1172" rx="3" transform="matrix(-1 0 0 1 8.0293 20.0732)" fill="#2130B8"></rect>
                                        </svg>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">This Month Discount Sales</p>
                                        <div class="d-flex align-items-center">
                                            <h3 class="mb-0 me-3 text-black font-w600">&#8358;<?php echo number_format($thisMonthDiscount, 2);?></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                                        
                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <i class="fa fa-solid fa-badge-percent"></i>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">Today's Grand Sales</p>
                                        <h3 class="mb-0 text-black font-w600">&#8358;<?php echo number_format($todayGrandSales, 2);?></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <svg class="primary-icon" width="50" height="53" viewBox="0 0 50 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <rect width="7.11688" height="52.1905" rx="3" transform="matrix(-1 0 0 1 49.8184 0)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="37.9567" rx="3" transform="matrix(-1 0 0 1 35.585 14.2338)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="16.6061" rx="3" transform="matrix(-1 0 0 1 21.3516 35.5844)" fill="#2130B8"></rect>
                                            <rect width="8.0293" height="32.1172" rx="3" transform="matrix(-1 0 0 1 8.0293 20.0732)" fill="#2130B8"></rect>
                                        </svg>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">This Week Grand Sales</p>
                                        <h3 class="mb-0 text-black font-w600">&#8358;<?php echo number_format($weekGrandSales, 2);?></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media align-items-center">
                                    <span class="me-4">
                                        <svg class="primary-icon" width="50" height="53" viewBox="0 0 50 53" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <rect width="7.11688" height="52.1905" rx="3" transform="matrix(-1 0 0 1 49.8184 0)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="37.9567" rx="3" transform="matrix(-1 0 0 1 35.585 14.2338)" fill="#2130B8"></rect>
                                            <rect width="7.11688" height="16.6061" rx="3" transform="matrix(-1 0 0 1 21.3516 35.5844)" fill="#2130B8"></rect>
                                            <rect width="8.0293" height="32.1172" rx="3" transform="matrix(-1 0 0 1 8.0293 20.0732)" fill="#2130B8"></rect>
                                        </svg>
                                    </span>
                                    <div class="media-body ms-1">
                                        <p class="mb-2">This Month Grand Sales</p>
                                        <div class="d-flex align-items-center">
                                            <h3 class="mb-0 me-3 text-black font-w600">&#8358;<?php echo number_format($thisMonthGrandSales, 2);?></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!--**********************************
            Content body end
        ***********************************-->

        <?php include_once COMPONENT_DIR."footer.php"; ?>

		<!--**********************************
           Support ticket button start
        ***********************************-->

        <!--**********************************
           Support ticket button end
        ***********************************-->


    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->

    <!--**********************************
        Scripts
    ***********************************-->
    <!-- Required vendors -->
    <script src="templatevendor/global/global.min.js"></script>
	<script src="templatevendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
	<script src="templatevendor/chart.js/Chart.bundle.min.js"></script>
	<script src="templatevendor/bootstrap-datetimepicker/js/moment.js"></script>
	<script src="templatevendor/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
	<!-- Apex Chart -->
	<script src="templatevendor/apexchart/apexchart.js"></script>
	
	<!-- Chart piety plugin files -->
    <script src="templatevendor/peity/jquery.peity.min.js"></script>	
	
	<!-- Dashboard 1 -->
	<script src="js/dashboard/dashboard-1.js"></script>
	
    <script src="js/custom.min.js"></script>
	<script src="js/deznav-init.js"></script>
</body>

</html>