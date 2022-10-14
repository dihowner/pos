<?php require "components/head.php";

require_once MODEL_DIR.'Sales.php';
$sales = new Sales($db);

$allSales = $sales->getCompletedSales($adminId);

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
                                <div class="table-responsive">
                                    <table id="example" class="display table table-striped" style="min-width: 845px">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Amount Paid</th>
                                                <th>Payment Status</th>
                                                <th>Delivery Status</th>
                                                <th>Date</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php 
                                            if ($allSales != FALSE) { $i = 1;
                                                foreach ($allSales as $salesInfo) { ?>
                                                    <td><?php echo $i; ?></td>
                                                    <td>
                                                        &#8358;<?php echo number_format($salesInfo['grandTotal'], 2); ?> <br/>
                                                        <strong style="color: red">Reference: </strong> <?php echo $salesInfo['reference']; ?>
                                                    </td>
                                                    <td><?php echo $salesInfo['paymentStatus']; ?></td>
                                                    <td><?php echo $salesInfo['deliveryStatus']; ?></td>
                                                    <td><?php echo $utility->niceDateFormat($salesInfo['date']); ?></td>
                                                    <td>
                                                        <div class="d-flex">
                                                            <?php if($salesInfo['payment_status'] == 0) { ?>
                                                                <a href="generateInvoice.php?reference=<?php echo $salesInfo['reference']; ?>" class="btn btn-primary shadow btn-xs sharp mr-1" target="__blank"><i class='fa fa-print'></i></a>
                                                                <a href="#" data-ref="<?php echo $salesInfo['reference']; ?>" class="cancel-sales btn btn-danger shadow btn-xs sharp mr-1"><i class='fa fa-times'></i></a>
                                                            <?php } else { ?>
                                                                <a href="paymentReceipt.php?reference=<?php echo $salesInfo['reference']; ?>" class="btn btn-primary shadow btn-xs sharp mr-1" target="__blank"><i class='fa fa-print'></i></a>
                                                            <?php } ?>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <?php $i++; }
                                            } else { ?>
                                                <tr class="text-center"> 
                                                    <td colspan="6">No Sales yet</td>
                                                </tr>
                                            <?php } 
                                            ?>
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
        $(document).on('click', '.cancel-sales', function() {
            cancelBtn = $(this);
            salesRef = cancelBtn.attr('data-ref');

            console.log(salesRef);
            
            Swal.fire({
				icon: 'question',
				html: 'You are about to cancel this sales. Action is irreversible',
				showCancelButton: true,
				confirmButtonText: "Proceed",
				cancelButtonText: "Cancel!",
				allowOutsideClick: false,
			}).then(function (result) {
				//Form method submit won't work, so AJAX needed...
				if (result.value) {
					data = {
						"cancelSales" : true,
						"salesReference": salesRef,
					}

					$.ajax({
						url: "<?php echo BASE_URL."controllers/sales.php";?>",
						type: "post",
						data: data,
						beforeSend: function(){
							cancelBtn.html("<i class='fa fa-spinner fa-pulse'></i>");
							cancelBtn.prop('disabled', true);
						},
                        complete: function(){
							cancelBtn.html("<i class='fa fa-times'></i>");
							cancelBtn.prop('disabled', false);
						},
						success: function(result) {
							console.log(result);

							if (result.error != undefined) {
                                errors = "";
                                result.error.forEach(error => {
                                    errors += "<li>"+error+"</li>"
                                });

                                swal.fire({title: "Error !", html: errors, icon: "error"});

                            } else {
                                swal.fire({title: "Success !", html: result.msg, icon:"success"});
                                window.location = '<?php echo BASE_URL.PAGE_NAME?>';
                            }
						}

					})
				}
			});

        });
    </script>
</body>

</html>