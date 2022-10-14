<?php require "components/head.php";

require_once MODEL_DIR.'Coupon.php';
$coupon = new Coupon($db);

$getAllCoupons = $coupon->getAllCoupons(); 
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

                                <h4><b>Site Settings</b></h4>
                                
                                <form method="post" action="<?Php echo BASE_URL;?>controllers/settings.php">

                                    <div class="row mb-4 mt-4">
                                        <div class="col-md-6">
                                            <label>Site Name</label>
                                            <input class="form-control input-lg" placeholder="Enter SITE NAME" value="<?php echo SITE_TITLE;?>" type="text" name="site_title" required>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label>Email Address</label>
                                            <input class="form-control input-lg" placeholder="Enter SITE EMAIL" value="<?php echo SITE_EMAIL;?>" type="email" name="site_email" required>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label>Office Address 1</label>
                                            <input class="form-control input-lg" value="<?php echo $allSettings->office_address_1;?>" type="text" name="office_address_1" required>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label>Office Address 1</label>
                                            <input class="form-control input-lg" value="<?php echo $allSettings->office_address_2;?>" type="text" name="office_address_2" required>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label>Official Mobile Number</label>
                                            <input class="form-control input-lg" value="<?php echo SITE_PHONE;?>" type="text" name="site_phone" required>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label>Default Password</label>
                                            <input class="form-control input-lg" value="<?php echo $allSettings->default_user_password;?>" type="text" name="default_user_password" required>
                                        </div>
                                    </div>
                                    
                                    <h4 class="row mb-4"><b>Sales Settings</b></h4>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-12">
                                            <label>Invoice Info</label>
                                            <input class="form-control input-lg" value="<?php echo $allSettings->invoice_info;?>" type="text" name="invoice_info" required>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label>Receipt Info 1</label>
                                            <input class="form-control input-lg" value="<?php echo $allSettings->receipt_info_1;?>" type="text" name="receipt_info_1" required>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label>Receipt Info 2</label>
                                            <input class="form-control input-lg" value="<?php echo $allSettings->receipt_info_2;?>" type="text" name="receipt_info_2" required>
                                        </div>
                                    </div>
                                    
                                    <h4 class="row mb-4"><b>Stock Settings</b></h4>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-12">
                                            <label>Low Quantity Threshold</label>
                                            <input class="form-control input-lg" value="<?php echo $allSettings->low_quantity_threshold;?>" type="text" name="low_quantity_threshold" required>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-4">
                                        <button class="btn btn-primary" type="submit" name="updateSettings">
                                            <i class="fa fa-edit"></i> Modify Settings
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
    <script>
        $(".date_expiry").on("change", function() {

            var date_expiry = $(this).val();
            var time_expiry = '00:00';
            date_expiry = date_expiry+' '+time_expiry;
            
            var dateResult = $(".date_result");

            $.ajax({
                url: "<?php echo BASE_URL;?>controllers/coupon.php",
                data: {"covertDateTime": true, "datetime": date_expiry},
                type: "post",
                success: function(dateResponse) {
                    dateResult.html("Expires On : " + dateResponse).addClass("alert alert-info");
                }
            })

        });
        
    </script>
</body>

</html>