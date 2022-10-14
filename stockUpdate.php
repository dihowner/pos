<?php require "components/head.php";

require_once MODEL_DIR.'Category.php';
$category = new Category($db);
$stock = new Stock($db);

$allStocks = $stock->getAllStocks();
$stockUpdateRecords = $stock->getStockDailyUpdateRecords();

?>
<style>
    .btn-success, .btn-success:hover {
        color: #fff;
    }
</style>
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
						<?php echo $utility->displayFormError() ?>
						<?php echo $utility->displayFormSuccess() ?>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <b>Stock Status
                                <small class="">
								(<?php echo $utility->niceDateFormat($allSettings->stock_last_opened) ?>
								 - 
								<?php echo ($allSettings->stock_status == 'closed') ? $utility->niceDateFormat($allSettings->stock_last_closed):'NULL' ?>)
							</small></b>
                            </div>
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-md-4">
                                        <?php if ($allSettings->stock_status == 'opened') { ?>
                                            <span class="bg-success text-white text-center d-block p-2">
                                                Opened
                                                <small class="d-block"><?php echo $utility->niceDateFormat($allSettings->stock_last_opened) ?></small>
                                            </span>
                                        <?php } else { ?>
                                            <a href="<?php echo BASE_URL ?>controllers/stock?openStock" class="bg-success text-white text-center d-block p-2">
                                                Open Now!
                                            </a>
                                        <?php } ?>
                                    </div>
                                    <div class="col-md-4">
                                        <?php if ($allSettings->stock_status == 'closed') { ?>
                                            <span class="bg-danger text-white text-center d-block p-2">
                                                Closed
                                                <small class="d-block"><?php echo $utility->niceDateFormat($allSettings->stock_last_closed) ?></small>
                                            </span>
                                        <?php } else { ?>
                                            <a href="<?php echo BASE_URL ?>controllers/stock?closeStock" class="bg-danger text-white text-center d-block p-2">
                                                Close Now!
                                            </a>
                                        <?php } ?>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="row">
                                            <div class="col-md-6 text-center p-2 mb-1" style="border: 1px dashed;">
                                                <h6>
                                                    Grand Sales Amount
                                                </h6>
                                                &#8358;<?php echo number_format($stock->getStockDailyUpdateSalesAmount(), 2)?>
                                            </div>
                                            <div class="col-md-6 text-center p-2 mb-1" style="border: 1px dashed;">
                                                <h6>
                                                    Grand Sales Discount
                                                </h6>
                                                &#8358;<?php echo number_format($stock->getStockDailyUpdateDiscount(), 2)?>
                                            </div>
                                            <div class="col-md-12 text-center p-2 mb-1" style="border: 1px dashed;">
                                                <h6>
                                                    Grand Profit
                                                </h6>
                                                &#8358;<?php echo number_format($stock->getStockDailyUpdateProfit(), 2) ?>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            
                            </div>
                        </div>
                    </div>
                    

                </div>

                <div class="row">
                    <div class="col-xl-12">
                        <div class="table-responsive">
                            <table id="example" class="table card-table display dataTablesCard">
                                <thead>
                                    <tr>
                                        <th>Stock Name / Model ID</th>
                                        <th>Opening Stock</th>
                                        <th>Closing Stock</th>
                                        <th>Difference</th>
                                        <th>Sales Amount </th>
                                        <th>Sales Discount </th>
                                        <th>Profit</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if ($stockUpdateRecords != FALSE) { 
                                        foreach ($stockUpdateRecords as $index => $updateRecordInfo) {
                                            $sales_amount = number_format($updateRecordInfo['sales_amount'] ? $updateRecordInfo['sales_amount'] : 0, 2);
                                            $sales_discount = number_format($updateRecordInfo['sales_discount'] ? $updateRecordInfo['sales_discount'] : 0, 2);
                                            $profit = number_format($updateRecordInfo['profit'] ? $updateRecordInfo['profit'] : 0, 2);
                                            ?>
                                            <tr>
                                                <td>
                                                    <?php echo $stock->getStockByStockId($updateRecordInfo['stock_unique_id'])->stock_name ?><br>
                                                    <span class="text-primary d-block">
                                                        <?php echo $updateRecordInfo['stock_unique_id'] ?>
                                                    </span>
                                                </td>

                                                <td>
                                                    <?php echo number_format($updateRecordInfo['opening_stock'])?>
                                                </td>
                                                
                                                <td>
                                                    <?php echo $updateRecordInfo['closing_stock'] == NULL ? 'NULL':number_format($updateRecordInfo['closing_stock']) ?>
                                                </td>
                                                
                                                <td>
                                                    <span class="d-block text-success mb-2">
                                                        <b>Stock Difference :</b> <?php echo $updateRecordInfo['stock_difference'] == NULL ? 'NULL':number_format($updateRecordInfo['stock_difference']) ?>
                                                    </span>
                                                    <span class="d-block text-danger">
                                                        <b>Pending Order :</b> <?php echo $updateRecordInfo['pending'] == NULL ? 'NULL':number_format($updateRecordInfo['pending']) ?>
                                                    </span>

                                                </td>

                                                <td>
                                                    &#8358;<?php echo $sales_amount?>
                                                </td>

                                                <td>
                                                    &#8358;<?php echo $sales_discount?>
                                                </td>

                                                <td>
                                                    &#8358;<?php echo $profit?>
                                                </td>
                                            </tr>
                                        <?php }
                                    } else { ?>
                                        <tr class="text-center"> 
                                            <td colspan="6">No Stock Update</td>
                                        </tr>
                                    <?php } ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


            </div>
        </div>
        <!--**********************************
            Content body end
        ***********************************-->

        <?php include_once COMPONENT_DIR."footer.php"; ?>

    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->

    <!--**********************************
        Scripts
    ***********************************-->
    <?php include_once COMPONENT_DIR."footer_script.php"; ?>

</body>

</html>