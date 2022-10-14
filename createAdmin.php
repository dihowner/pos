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

                                <div class="msg_cell mt-3 mb-3" style="font-size: 22px">
                                    <b style="color: red">NOTE : </b> Default password is <i>peaksystem123</i>
                                </div>
                                
                                <form method="post" action="<?php echo BASE_URL;?>controllers/adminAuth.php">

                                    <div class="mb-3">
                                        <label><b>Admin Name</b></label>
                                        <input class="form-control form-control-lg" type="text" name="admin_name" placeholder="Enter admin name" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label><b>Admin Username</b></label>
                                        <input class="form-control form-control-lg" type="text" name="admin_username" placeholder="Enter admin username" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label><b>Admin Email Address</b></label>
                                        <input class="form-control form-control-lg" type="text" name="admin_email" placeholder="Enter admin email address" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label><b>Admin Phone Number</b></label>
                                        <input class="form-control form-control-lg" type="text" name="admin_phone_no" placeholder="Enter admin phone number" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label><b>Admin Password</b></label>
                                        <input class="form-control form-control-lg" type="password" name="admin_password" placeholder="Enter admin password" value="peaksystem123" required>
                                    </div>
                                    
                                    <div class="text-center">
                                        <button class="btn btn-primary" type="submit" name="createAdmin">
                                            <b><i class="flaticon-381-plus"></i> Create Admin</b>
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