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
				<div class="d-flex flex-wrap mb-2 align-items-center justify-content-between">
                    <div class="mb-3 mr-3">
						<h6 class="fs-16 text-black font-w600 mb-0">
                            <!-- <?php echo ($productCategories == FALSE) ? 0:count((array)$productCategories)?> Total Categories -->
                        </h6>
					</div>
					<div class="d-flex mb-3">
                        <button type="button" class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target="#newCategory"><i class="flaticon-381-plus"></i> Add Category</button>
                    </div>

                    <!-- Create a new category starts --->
                    <div class="modal fade" id="newCategory" style="display: none;" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <form method="post" action="<?php echo BASE_URL;?>controllers/category.php">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Create Category</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal">
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        
                                        <div class="mb-3">
                                            <label><b>Category Name</b></label>
                                            <input class="form-control form-control-lg" type="text" name="category_name" placeholder="Enter category name" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label><b>Description</b></label>
                                            <textarea class="form-control form-control-lg" placeholder="Enter category description" name="category_description" rows="5" required></textarea>
                                        </div>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger light" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary" name="createCategory">Create Category</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Create a new category ends --->
					
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
                                    <table id="example" class="display" style="min-width: 845px">
                                        <thead>
                                            <tr>
                                                <th>S/No</th>
                                                <th>Category Name</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if ($getAllCategories != FALSE) { 
                                                foreach($getAllCategories as $index => $category) { ?>
                                                    <tr>
                                                        <td><?php echo $index + 1;?></td>
                                                        <td><?php echo $category["category_name"];?></td>
                                                        <td>
                                                            <div class="d-flex">
                                                                <a href="#" class="btn btn-primary shadow btn-xs sharp" data-bs-toggle="modal" data-bs-target="#editCategoryModal<?php echo $category['id'] ?>" style="border-radius: 1.25em; margin: 5px">
                                                                    <i class="fas fa-pencil-alt mt-1"></i>
                                                                </a>
                                                                <a href="<?Php echo BASE_URL;?>controllers/category?deleteCategory&id=<?php echo $category["id"];?>" class="btn btn-danger shadow btn-xs sharp" style="border-radius: 1.25em; margin: 5px">
                                                                    <i class="fa fa-trash mt-1"></i>
                                                                </a>
                                                            </div>
                                                        </td>

                                                        <!-- Edit Category -->
                                                        <div class="modal fade" id="editCategoryModal<?php echo $category['id'] ?>">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title">Update Category</h5>
                                                                        <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <form action="<?php echo BASE_URL ?>controllers/category.php" method="POST">
                                                                        
                                                                            <div class="form-group">
                                                                                <label>Plan Name</label>
                                                                                <input type="text" value="<?php echo $category['category_name'] ?>" name="category_name" class="form-control">
                                                                                <input type="hidden" name="categoryId" value="<?php echo $category['id'] ?>"/>
                                                                            </div>
                                                                            
                                                                            <div class="form-group">
                                                                                <label>Description</label>
                                                                                <textarea class="form-control" rows="5" name="description"><?php echo $category['description'] ?></textarea>
                                                                            </div>

                                                                            <div class="form-group">
                                                                                <button type="submit" name="updateCategory" class="btn btn-primary">Update</button>
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