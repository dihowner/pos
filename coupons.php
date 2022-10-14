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
				<div class="d-flex flex-wrap mb-2 align-items-center justify-content-between">
                    <div class="mb-3 mr-3">
						<h6 class="fs-16 text-black font-w600 mb-0">
                            <!-- <?php echo ($productCategories == FALSE) ? 0:count((array)$productCategories)?> Total Categories -->
                        </h6>
					</div>
					<div class="d-flex mb-3">
                        <button type="button" class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target="#newCoupon"><i class="flaticon-381-plus"></i> Create Coupon</button>
                    </div>

                    <!-- Create a new coupon starts --->
                    <div class="modal fade" id="newCoupon" style="display: none;" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <form method="post" action="<?php echo BASE_URL;?>controllers/coupon.php">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Create Coupon</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal">
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        
                                        <div class="mb-3">
                                            <label><b>Coupon Code</b></label>
                                            <input class="form-control form-control-lg" type="text" name="coupon_code" placeholder="Enter coupon code" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label><b>Coupon Amount</b></label>
                                            <input class="form-control form-control-lg" type="text" name="coupon_amount" placeholder="Enter coupon amount" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label><b>Expiry Date</b></label>
                                            <input class="form-control form-control-lg date_expiry" type="date" name="date_expiry" placeholder="Select expiry date" required>
                                            <div class="date_result mt-3"></div>
                                        </div>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger light" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary" name="createCoupon">Create Coupon</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Create a new coupon ends --->
					
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
                                                <th>Coupon Code</th>
                                                <th>Coupon Amount</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if ($getAllCoupons != FALSE) { 
                                                foreach($getAllCoupons as $index => $coupons) { ?>
                                                    <tr>
                                                        <td><?php echo $index + 1;?></td>
                                                        <td><?php echo $coupons["coupon_code"];?></td>
                                                        <td>&#8358;<?php echo number_format($coupons["amount"], 2);?></td>
                                                        <td>
                                                            <div class="d-flex">
                                                                <a href="#" class="btn btn-primary shadow btn-xs sharp" data-bs-toggle="modal" data-bs-target="#editCouponModal<?php echo $coupons['id'] ?>" style="border-radius: 1.25em; margin: 5px">
                                                                    <i class="fas fa-pencil-alt mt-1"></i>
                                                                </a>
                                                                <a href="<?Php echo BASE_URL;?>controllers/coupon?deleteCoupon&id=<?php echo $coupons["id"];?>" class="btn btn-danger shadow btn-xs sharp" style="border-radius: 1.25em; margin: 5px">
                                                                    <i class="fa fa-trash mt-1"></i>
                                                                </a>
                                                            </div>
                                                        </td>

                                                        <!-- Edit Coupon -->
                                                        <div class="modal fade" id="editCouponModal<?php echo $coupons['id'] ?>">
                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title">Update Coupon</h5>
                                                                        <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <form action="<?php echo BASE_URL ?>controllers/coupon.php" method="POST">
                                                                        
                                                                            <div class="form-group">
                                                                                <label>Coupon Code</label>
                                                                                <input type="text" value="<?php echo $coupons['coupon_code'] ?>" name="coupon_code" class="form-control">
                                                                                <input type="hidden" name="couponId" value="<?php echo $coupons['id'] ?>"/>
                                                                            </div>
                                                                        
                                                                            <div class="form-group">
                                                                                <label>Coupon Amount</label>
                                                                                <input type="text" value="<?php echo $coupons['amount'] ?>" name="coupon_amount" class="form-control">
                                                                            </div>
                                                                            
                                                                            <div class="mb-3">
                                                                                <label><b>Current Expiry Date</b></label>
                                                                                <input class="form-control form-control-lg" value="<?php echo $coupons['date_expired'] ?>" disabled>
                                                                            </div>
                                                                            
                                                                            <div class="mb-3">
                                                                                <label><b>New Expiry Date </b><br/><i>(Leave empty if you are not changing)</i></label>
                                                                                <input class="form-control form-control-lg date_expiry" type="date" name="date_expiry">
                                                                                <div class="date_result mt-3"></div>
                                                                            </div>

                                                                            <div class="form-group">
                                                                                <button type="submit" name="updateCoupon" class="btn btn-primary">Update</button>
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