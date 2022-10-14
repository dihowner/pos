<?php require "components/head.php";

require_once MODEL_DIR.'Stock.php';
$category = new Category($db);
$stock = new Stock($db);

$availableStocks = $stock->getAvailableStocks();
$getAllCategories = $category->getAllCategories(); 
// print_r($availableStocks);
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
                                                <th>Stock Name</th>
                                                <th>Cost Price</th>
                                                <th>Qty Available</th>
                                                <th>Threshold</th>
                                                <th>Unit Price</th>
                                                <th>Category</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if ($availableStocks != FALSE) { 
                                                foreach($availableStocks as $index => $stockInfo) { 
                                                    $category_name =  isset($stockInfo->category->scalar) ? '':$stockInfo->category->category_name;
                                                    $stock_name = $stockInfo->stock_name;
                                                    $stockId = $stockInfo->id;
                                                ?>
                                                    <tr>
                                                        <td><?php echo $index + 1;?></td>
                                                        <td>
                                                            <b>
                                                            <?php echo $stock_name;?> <br/>
                                                                <em class="text-danger">Stock ID: </em><?php echo $stockInfo->stock_unique_id;?>
                                                            </b>
                                                        </td>
                                                        <td>&#8358;<?php echo number_format($stockInfo->stock_costprice, 2);?></td>
                                                        <td><?php echo number_format($stockInfo->stock_qty);?></td>
                                                        <td>
                                                            <?php echo $stockInfo->threshold;?>
                                                        </td>
                                                        <td>&#8358;<?php echo number_format($stockInfo->stock_price, 2);?></td>
                                                        <td><?php echo $category_name;?></td>
                                                        <td>
                                                            <div class="d-flex">
                                                                <a href="#" class="btn btn-primary shadow btn-xs btn_circle sharp" data-bs-toggle="modal" data-bs-target="#editStockModal<?php echo $stockId?>" title="Modify Stock">
                                                                    <i class="fas fa-pencil-alt mt-1"></i>
                                                                </a>
                                                                <a href="<?php echo BASE_URL;?>setCostPrice?id=<?php echo $stockId;?>" class="btn btn-success shadow btn-xs btn_circle sharp" title="Edit Cost Price">
                                                                    <i class="fas fa-paper-plane mt-1" style="color: #fff"></i>
                                                                </a>
                                                                <a href="<?Php echo BASE_URL;?>controllers/stock?deleteStock&id=<?php echo $stockId;?>" class="btn btn-danger shadow btn-xs btn_circle sharp" onclick="return confirm('Delete Stock (<?php echo $stock_name;?>) \n Action is irreversible')" title="Delete Stock">
                                                                    <i class="fa fa-trash mt-1"></i>
                                                                </a>
                                                            </div>
                                                        </td>
                                                        
                                                        
                                                        <div class="modal fade" id="editStockModal<?php echo $stockId ?>">
                                                            <div class="modal-dialog modal-lg" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title">Update Stock</h5>
                                                                        <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <form action="<?php echo BASE_URL ?>controllers/stock.php" method="POST">
                                                                        
                                                                            <div class="mb-3">
                                                                                <label><b>Product Name</b></label>
                                                                                <input class="form-control form-control-lg" type="text" name="product_name" placeholder="Enter product name" value="<?php echo $stockInfo->stock_name;?>" required>
                                                                            </div>
                                    
                                                                            <div class="mb-3">
                                                                                <label><b>Product Unique ID</b></label>
                                                                                <input class="form-control form-control-lg" type="text" name="product_unique_id" placeholder="Enter product unique ID" value="<?php echo $stockInfo->stock_unique_id;?>" required>
                                                                            </div>
                                    
                                                                            <div class="mb-3"> 
                                                                                <label><b>Select Category</b></label>
                                                                                <select class="form-control form-control-lg" type="text" name="category_id" placeholder="Enter category name" required>
                                                                                    <option value="">-- Select --</option>
                                                                                    <?php
                                                                                    if($getAllCategories  != FALSE) {
                                                                                        foreach($getAllCategories as $index => $category) { ?>
                                                                                            <option value="<?php echo $category["id"];?>"<?php echo ($category["id"] == $stockInfo->stock_category_id) ? "selected":"";?>>
                                                                                                <?php echo $category["category_name"];?>
                                                                                            </option>
                                                                                        <?php }
                                                                                    }
                                                                                    ?>
                                                                                </select>
                                                                            </div>
                                    
                                                                            <div class="mb-3">
                                                                                <label><b>Enter Price</b></label>
                                                                                <input class="form-control form-control-lg" type="text" min="1" name="product_price" placeholder="Enter product unit price" value="<?php echo $stockInfo->stock_price;?>" required>
                                                                                <input name="stockId" type="hidden" value="<?php echo $stockId;?>">
                                                                            </div>

                                                                            <div class="mb-3">
                                                                                <label><b>Product Description</b></label>
                                                                                <textarea class="form-control form-control-lg" name="product_description" placeholder="Enter product description" rows="5" required><?php echo $stockInfo->stock_description;?></textarea>
                                                                            </div>

                                                                            <div class="form-group">
                                                                                <button type="submit" name="updateStock" class="btn btn-primary">Update</button>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

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