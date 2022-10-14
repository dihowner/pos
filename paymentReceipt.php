<?php require "components/head.php";
$stock = new Stock($db);

$reference = isset($_REQUEST['reference']) ? $_REQUEST['reference'] : '';
if($reference == '') {
    header("location: ".BASE_URL."makePurchase");
    exit;
}
else {
    $getSales = $sales->getSales($reference);

    if($getSales->payment_status == 0) {
        header("location: ".BASE_URL."checkout");
        exit;
    }
    $salesItems = $getSales->sales_item;
    
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
                    <div class="col-12">

                        <div class="card" id="printInvoiceArea">
                            <div class="card-header" style="font-size: 20px">  <strong>Receipt No <br> #<?php echo $reference;?></strong> <span class="float-right">
                                <strong style="color: red">Status:</strong> <?php echo $getSales->payment; ?></span>
                            </div>
                            <div class="card-body">
                                
                                <div class="row mb-5">
                                    <div class="mt-4 col-xl-3 col-lg-3 col-md-6 col-sm-6">
                                        <h6>Shopping Address:</h6>
                                        <div> <strong><?php echo SITE_TITLE;?></strong> </div>
                                        <div><?php echo $allSettings->office_address_1;?></div>
                                        <div><?php echo $allSettings->office_address_2;?></div>
                                        <div>Email: <a href="mailto:<?php echo SITE_EMAIL;?>"><?php echo SITE_EMAIL;?></a></div>
                                        <div>Phone: <?php echo SITE_PHONE;?></div>
                                    </div>
                                </div>

                                <div class="table-responsive">
                                    <table class="table ">
                                        <thead>
                                            <tr>
                                                <th class="center">#</th>
                                                <th>Item</th>
                                                <th class="right">Unit Cost</th>
                                                <th class="center">Quantity</th>
                                                <th class="right">Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php
                                            if(!empty($salesItems)) {
                                                $grandTotal = 0;
                                                foreach($salesItems as $index => $salesItem) {
                                                    $theStock = $stock->getStockByStockId($salesItem['stock_unique_id']);
                                                    $subTotal = $salesItem['sub_total'];
                                                    $grandTotal += $subTotal;
                                                    ?>
                                                    
                                                    <tr>
                                                        <td class="center"><?php echo $index + 1; ?></td>
                                                        <td class="left strong">
                                                            <p>
                                                                <?php echo $theStock->stock_name?> <br/>
                                                                
                                                                <small class='mt-3'>
                                                                    <b class='text-danger'>Stock ID :</b>
                                                                    <em><?php echo $salesItem['stock_unique_id']; ?></em>
                                                                </small>
                                                            </p>
                                                        </td>
                                                        <td class="right">&#8358;<?php echo number_format($salesItem['unit_price'], 2); ?></td>
                                                        <td class="center"><?php echo $salesItem['quantity']; ?></td>
                                                        <td class="right">&#8358;<?php echo number_format($subTotal, 2); ?></td>
                                                    </tr>

                                                <?php }
                                            }
                                            ?>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="row">
                                    <div class="col-lg-5 col-sm-5"> </div>
                                    <div class="col-lg-5 col-sm-5 ms-auto">
                                        <table class="table table-clear">
                                            <tbody style="font-size: 22px">
                                                <tr>
                                                    <td class="left"><strong>Subtotal</strong></td>
                                                    <td class="right">&#8358;<?php echo number_format($grandTotal, 2);?></td>
                                                </tr>
                                                <tr>
                                                    <td class="left"><strong>Discount </strong></td>
                                                    <td class="right">&#8358;<?php echo number_format($salesItem['discount'], 2);?></td>
                                                </tr>
                                                <tr>
                                                    <td class="left"><strong>Amount Paid</strong></td>
                                                    <td class="right"><strong>&#8358;<?php echo number_format(($grandTotal - $salesItem['discount']), 2);?></strong></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                
                                <div class="col-lg-12 text-center" style="border-top: 1px dashed #aaa; border-bottom: 1px dashed #aaa; padding: 15px;display: flex; align-items: center; flex-direction: column;">
                                    <?php echo $allSettings->receipt_info_1;?>
                                    <br/> <?php echo $allSettings->receipt_info_2;?>
                                </div>

                            </div>
                        </div>

                        <div class="text-center">
                            <button onclick="printDiv('printInvoiceArea')" class="btn btn-primary"><b><i class='fa fa-print'></i> Print Receipt</b></button>
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