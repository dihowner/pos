<?php require "components/head.php";

require_once MODEL_DIR.'Stock.php';
$category = new Category($db);
$stock = new Stock($db);
$admin = new Admin($db);

$stockHistories = $stock->getStockQuantityUpdateHistory();
$getAllCategories = $category->getAllCategories(); 
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
				<div class="d-flex flex-wrap mb-2 align-items-center justify-content-between">
                    <div class="mb-3 mr-3">
						<h6 class="fs-16 text-black font-w600 mb-0">
                            <!-- <?php echo ($productCategories == FALSE) ? 0:count((array)$productCategories)?> Total Categories -->
                        </h6>
					</div>
					<div class="d-flex mb-3">
                        <a href="addStock" class="btn btn-primary"><i class="flaticon-381-plus"></i> Add Stock</a>
                    </div>

				</div>
				<div class="row">
					<div class="col-xl-12">
						<?php echo $utility->displayFormError() ?>
						<?php echo $utility->displayFormSuccess() ?>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table id="example" class="display table table-striped" style="min-width: 845px">
                                        <thead>
                                            <tr>
                                                <th>S/No</th>
                                                <th>Date</th>
                                                <th>Stock Name</th>
                                                <th>Category</th>
                                                <th>Old Quantity</th>
                                                <th>Quantity Added</th>
                                                <th>New Quantity</th>
                                                <th>Updated By</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if ($stockHistories != FALSE) { 
                                                foreach($stockHistories as $index => $stockHistory) { 
                                                    $getStock = $stock->getStockById($stockHistory['stock_id']); 
                                                    
                                                    $category_name =  isset($getStock->category->scalar) ? '':$getStock->category->category_name;
                                                ?>
                                                    <tr>
                                                        <td><?php echo $index + 1; ?></td>
                                                        <td>
                                                            <?php echo $utility->niceDateFormat($stockHistory['date_created']) ?>    
                                                        </td>
                                                        
                                                        <td>
                                                            <?php echo $getStock->stock_name; ?>    
                                                        </td>
                                                        
                                                        <td>
                                                            <?php echo $category_name; ?>    
                                                        </td>
                                                        
                                                        <td>
                                                            <?php echo number_format($stockHistory['old_quantity']); ?>    
                                                        </td>
                                                        
                                                        <td>
                                                            <?php echo number_format($stockHistory['quantity_added']); ?>    
                                                        </td>
                                                        
                                                        <td>
                                                            <?php echo number_format($stockHistory['new_quantity']); ?>    
                                                        </td>
                                                        
                                                        <td>
                                                            <?php echo $admin->getAdminById(1)->fullName; ?> 
                                                        </td>

                                                    </tr>
                                            <?php }
                                        } ?>
                                        </tbody>
                                    </table>
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
    <?php include_once COMPONENT_DIR."footer_script.php"; ?>
</body>

</html>