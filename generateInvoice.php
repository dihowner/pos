<?php require "components/head.php";
$stock = new Stock($db);

$reference = isset($_REQUEST['reference']) ? $_REQUEST['reference'] : '';
if($reference == '') {
    header("location: ".BASE_URL."makePurchase");
    exit;
}
else {
    $getSales = $sales->getSales($reference);

    if($getSales->payment_status == 1) {
        $_SESSION['errorMessage'] = $clientLang['sales_completed'];
        header("location: ".BASE_URL."makePurchase");
        exit;
    }
    else if($getSales->payment_status == 2) {
        $_SESSION['errorMessage'] = $clientLang['sales_cancel'];
        header("location: ".BASE_URL."makePurchase");
        exit;
    }
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
				
                <div class="row">
					<div class="col-xl-12">
						<?php echo $utility->displayFormError() ?>
						<?php echo $utility->displayFormSuccess() ?>
                    </div>

                    <!-- <div class="text-center"> -->

                    <div class="col-md-3"></div>
                        <div class="col-md-6">
                            
                            <div class="card" id="printInvoiceArea">
                                <div class="card-body">
                                    <div class="row mb-5">
                                        <div class="mt-4 col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                            <h5>Shopping Address:</h5>
                                            <div> <strong><?php echo SITE_TITLE;?></strong> </div>
                                            <div><?php echo $allSettings->office_address_1;?></div>
                                            <div><?php echo $allSettings->office_address_2;?></div>
                                            <div>Email: <a href="mailto:<?php echo SITE_EMAIL;?>"><?php echo SITE_EMAIL;?></a></div>
                                            <div>Phone: <?php echo SITE_PHONE;?></div>
                                        </div>
                                        
                                        <div class="mt-4 col-xl-1 col-lg-1 col-md-6 col-sm-6"></div>

                                        <div class="mt-4 col-xl-4 col-lg-4 col-md-6 col-sm-6 align-items-right">
                                            <h5>Invoice Number:</h5>
                                            <strong>
                                                <h2 class="text-danger"><?php echo $_REQUEST["reference"]; ?></h2>
                                            </strong>
                                        </div>
                                    </div>

                                    <div class="col-lg-12" style="border-top: 1px dashed #aaa; border-bottom: 1px dashed #aaa; padding: 15px;display: flex; align-items: center; flex-direction: column;">
                                        <div><h4 class="fs-24 test-gray">Grand Total</h4></div>
                                        <div><h4 class="text-center text-success fs-24 font-w700 mb-0">
                                            &#8358;<?php echo number_format(($getSales->grand_total - $getSales->total_discount), 2);?>
                                        </h4></div>
                                    </div>
                                    
                                    <div class="text-center" style="font-size: 18px">
                                        <p>
                                            <?php echo $allSettings->invoice_info;?>
                                            <br/> <?php echo $allSettings->receipt_info_2;?>
                                        </p>
                                    </div>

                                </div>
                            </div>


                            <div class="text-center">
                                <button onclick="printDiv('printInvoiceArea')" class="btn btn-primary"><b><i class='fa fa-print'></i> Print Invoice</b></button>
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
        function printDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>

</body>

</html>