<?php require "components/head.php";

require_once MODEL_DIR.'Category.php';
$category = new Category($db);
$stock = new Stock($db);

$getAllCategories = $category->getAllCategories(); 

$stock_id = $_REQUEST["id"];
$getStock = $stock->getStockById($stock_id);

if($getStock === false) {
    header("location: dashboard");
    exit;
}
else if($getStock->stock_qty < 1) {
    $_SESSION["errorMessage"] = $clientLang["out_stock"];
    header("location: availableStock");
    exit;
}
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
                        <a href="<?php echo BASE_URL;?>availableStock" class="btn btn-primary mb-2"><i class="fas fa-store"></i> Stock List</a>
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
                                <form method="post" action="<?php echo BASE_URL;?>controllers/stock.php">
                                    
                                    <div class="mb-3">
                                        <label><b>Product Name</b></label>
                                        <input class="form-control form-control-lg" value="<?php echo $getStock->stock_name; ?>" disabled>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label><b>Unit Price</b></label>
                                        <input class="form-control form-control-lg" value="&#8358;<?php echo number_format($getStock->stock_price, 2); ?>" disabled>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label><b>Cost Price</b></label>
                                        <input class="form-control form-control-lg" min="1" type="number" name="costprice" placeholder="Enter product cost price" value="<?php echo $getStock->stock_costprice; ?>" required>
                                        <input class="form-control form-control-lg" name="stock_id" value="<?php echo $stock_id;?>" type="hidden">
                                    </div>
                                    
                                    <div class="text-center">
                                        <button class="btn btn-primary" type="submit" name="updateCostPrice">
                                            <b><i class="fa fa-paper-plane"></i> Update Cost Price</b>
                                        </button>
                                    </div>

                                </form>
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