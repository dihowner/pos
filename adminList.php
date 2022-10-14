<?php require "components/head.php";

$adminLists = $admin->getAllAdmin();

// print_r($adminLists); die;

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
                        <a href="<?php echo BASE_URL;?>createAdmin" class="btn btn-primary mb-2"><b><i class="flaticon-381-plus"></i> CREATE NEW ADMIN</b></a>
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
                                    <table id="example" class="display" style="min-width: 845px">
                                        <thead>
                                            <tr>
                                                <th>S/No</th>
                                                <th>Admin Name / Email</th>
                                                <th>Admin Username</th>
                                                <th>Admin Phone</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if ($adminLists != FALSE) { 
                                                // $unDeleteAble = ["07032060088", "09033024846", "dihowner", "valuemax", "dihowner", "oluwatayoadeyemi@yahoo.com"];
                                                $unDeleteAble = ["", "09033024846", "dihowner", "oluwatayoadeyemi@yahoo.com"];

                                                foreach($adminLists as $index => $adminList) { ?>
                                                    <tr>
                                                        <td><?php echo $index + 1;?></td>
                                                        <td>
                                                            <div class="d-flex align-items-center mb-6">
                                                                <div class="symbol symbol-40 flex-shrink-0" style="margin: 10px">
                                                                    <div class="symbol-label img-thumbnail" style="font-size: 29px"><?php echo $adminList["initial"]?></div>
                                                                </div>
                                                                <div class="ml-2">
                                                                    <?php echo $adminList["fullname"]?> <br/>
                                                                    <b style="color: red">Email : </b><?php echo $adminList["email"]?>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <?php echo $adminList["username"]?>
                                                        </td>
                                                        <td>
                                                            <?php echo $adminList["mobile"]?>
                                                        </td>
                                                        <td>
                                                            <?php if(in_array($adminList["mobile"], $unDeleteAble) OR in_array($adminList["email"], $unDeleteAble) OR in_array($adminList["username"], $unDeleteAble)) { ?>
                                                            
                                                            <?php } else { ?>
                                                                <div class="d-flex">
                                                                    <a href="#" class="btn btn-primary shadow btn-xs sharp" data-bs-toggle="modal" data-bs-target="#editAdminModal<?php echo $adminList['id'] ?>" style="border-radius: 1.25em; margin: 5px">
                                                                        <i class="fas fa-pencil-alt mt-1"></i>
                                                                    </a>
                                                                    <a href="#" class="btn btn-primary shadow btn-xs sharp" data-bs-toggle="modal" data-bs-target="#changePassModal<?php echo $adminList['id'] ?>" style="border-radius: 1.25em; margin: 5px">
                                                                        <i class="fas fa-lock mt-1"></i>
                                                                    </a>
                                                                    <a href="<?Php echo BASE_URL;?>controllers/adminAuth?deleteAdmin&id=<?php echo $adminList["id"];?>" class="btn btn-danger shadow btn-xs sharp" style="border-radius: 1.25em; margin: 5px">
                                                                        <i class="fa fa-trash mt-1"></i>
                                                                    </a>
                                                                </div>
                                                            <?php } ?>
                                                        </td>

                                                        <!-- Edit ADMIN Starts -->

                                                        <div class="modal fade" id="editAdminModal<?php echo $adminList['id'] ?>">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title">Modify Admin</h5>
                                                                        <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <form action="<?php echo BASE_URL ?>controllers/adminAuth.php" method="POST">
                                                                        
                                                                            <div class="form-group">
                                                                                <label>Admin Name</label>
                                                                                <input type="text" value="<?php echo $adminList['fullname'] ?>" name="admin_name" class="form-control" required>
                                                                                <input type="hidden" name="adminId" value="<?php echo $adminList['id'] ?>"/>
                                                                            </div>
                                                                        
                                                                            <div class="form-group">
                                                                                <label>Admin Username</label>
                                                                                <input type="text" value="<?php echo $adminList['username'] ?>" name="admin_username" class="form-control" required>
                                                                            </div>
                                                                        
                                                                            <div class="form-group">
                                                                                <label>Admin Email</label>
                                                                                <input type="email" value="<?php echo $adminList['email'] ?>" name="admin_email" class="form-control" required>
                                                                            </div>
                                                                        
                                                                            <div class="form-group">
                                                                                <label>Admin Phone Number</label>
                                                                                <input type="text" value="<?php echo $adminList['mobile'] ?>" name="admin_phone" class="form-control" required>
                                                                            </div>

                                                                            <div class="form-group">
                                                                                <button type="submit" name="updateAdmin" class="btn btn-primary">Update</button>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- Edit ADMIN Stops -->

                                                        <!-- Change Password Starts -->

                                                        <div class="modal fade" id="changePassModal<?php echo $adminList['id'] ?>">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title">Modify Password</h5>
                                                                        <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <form action="<?php echo BASE_URL ?>controllers/adminAuth.php" method="POST">
                                                                        
                                                                            <div class="form-group">
                                                                                <label>New Password</label>
                                                                                <input type="password" name="newPassword" placeholder="Enter new password" class="form-control" required>
                                                                                <input type="hidden" name="adminId" value="<?php echo $adminList['id'] ?>"/>
                                                                            </div>
                                                                        
                                                                            <div class="form-group">
                                                                                <label>Re-type Password</label>
                                                                                <input type="password" name="confirmPass" placeholder="Re-type password" class="form-control" required>
                                                                            </div>

                                                                            <div class="form-group">
                                                                                <button type="submit" name="changeAdminPassword" class="btn btn-primary">Modify</button>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- Change Password Stops -->

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