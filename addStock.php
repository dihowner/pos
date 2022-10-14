<?php require "components/head.php";

require_once MODEL_DIR.'Category.php';
$category = new Category($db);

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
                                        <input class="form-control form-control-lg" type="text" name="product_name" placeholder="Enter product name" required>
                                    </div>
                                    
                                    <div class="row mb-3">                                        
                                        <div class="col-md-6">
                                            <label><b>Product Unique ID</b></label>
                                            <input class="form-control form-control-lg" type="text" name="product_unique_id" placeholder="Enter product unique ID" required>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label><b>Select Category</b></label>
                                            <select class="form-control form-control-lg" type="text" name="category_id" placeholder="Enter category name" required>
                                                <option value="">-- Select --</option>
                                                <?php
                                                if($getAllCategories  != FALSE) {
                                                    foreach($getAllCategories as $index => $category) { ?>
                                                        <option value="<?php echo $category["id"];?>"><?php echo $category["category_name"];?></option>
                                                    <?php }
                                                }
                                                ?>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label><b>Enter Price</b></label>
                                            <input class="form-control form-control-lg" type="text" min="1" name="product_price" placeholder="Enter product unit price" required>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label><b>Enter Quantity</b></label>
                                            <input class="form-control form-control-lg" type="number" min="1" name="product_quantity" placeholder="Enter quantity" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label><b>Product Description</b></label>
                                        <textarea class="form-control form-control-lg" name="product_description" placeholder="Enter product description" rows="5" required></textarea>
                                    </div>
                                    
                                    <div class="text-center">
                                        <button class="btn btn-primary" type="submit" name="createStock">
                                            <b><i class="flaticon-381-plus"></i> Create Stock</b>
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