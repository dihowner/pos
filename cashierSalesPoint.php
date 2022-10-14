<?php require "components/head.php";

require_once MODEL_DIR.'Category.php';
$category = new Category($db);
$stock = new Stock($db);
?>
<style>
    .btn-success, .btn-success:hover {
        color: #fff;
    }
</style>
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

                                <div class="msg_cell" style="font-size: 18px">
                                    <b style='color: red'>NOTE: </b> Please enter a valid Sales Invoice number
                                </div>
                            
                                <div class="row form-group mb-3 mt-3">
                                    <div class="col-sm-9 col-xs-8 mb-2">
                                        <input type="text" class="form-control form-control-lg invoiceNo" placeholder="Enter Invoice Number: 11325495029" require>  
                                    </div>

                                    <div class="col-sm-3 col-xs-4 mb-2">
                                        <button id="search-item" class="btn btn-primary btn-block searchInvoice" type="button"><i class="fa fa-search"></i> Get Invoice</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="checkout_box d-none">
                        <div class="row">

                            <div class="col-8 sales_cart">
                                <div class="card">
                                    <div class="card-header" style="background: #f9f9f9">
                                        <b>Sales Cart: <span id="invoice_span_id" style='color: blue'></span></b> 
                                    </div>
                                    <div class="card-body sales_body">

                                    </div>
                                </div>
                            </div>

                            <div class="col-4 sales_summary">
                                <div class="card">
                                    <div class="card-header" style="background: #f9f9f9">
                                        <b>Sales Summary</b> 
                                    </div>
                                    <div class="card-body summary_body">

                                    </div>
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

    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->

    <!--**********************************
        Scripts
    ***********************************-->
    <?php include_once COMPONENT_DIR."footer_script.php"; ?>

    <script>
        $(".searchInvoice").on("click", function() {
            var searchBtn = $(".searchInvoice");
            var invoiceNo = $(".invoiceNo").val();
            
            var checkOutResponseBody = $(".checkout_box");// FOr hidding all the box...
            var salesCartResponseBody = $(".sales_cart"); //Col-md-8
            var salesSummaryesponseBody = $(".sales_summary"); //Col-md-4

            if(invoiceNo == undefined || invoiceNo == "") {
                checkOutResponseBody.addClass('d-none');
                swal.fire({
                    icon: "error", 
                    title: "Error",
                    html: "Please enter invoice number"
                });
            }
            else {
                $.ajax({
                    url: "<?php echo BASE_URL ?>controllers/sales.php",
                    type: "post",
                    data: { 'getInvoice': true, 'invoice_number': invoiceNo },
                    beforeSend: function() {
                        var load = "<i class='fa fa-spinner fa-spin'></i> loading"
                        searchBtn.attr('disabled', true);
                        searchBtn.html(load);
                    },
                    complete: function() {
                        var unload = "<i class='fa fa-search'></i> Get Invoice"

                        searchBtn.attr('disabled', false);
                        searchBtn.html(unload);
                    },
                    success: function(response) {
                        console.log(response);

                        if (response.error != undefined) {
                            errors = "";
                            response.error.forEach(error => {
                                errors += "<li>"+error+"</li>"
                            });

                            checkOutResponseBody.addClass('d-none');
                            swal.fire({title: "Error !", html: errors, icon:"error"});
                            
                        } else {
                            
                            // console.log(response.sales_item);
                            
                            tr_sales_data = '';
                            let grandTotal = 0;
                            for(let i = 0; i<response.sales_item.length; i++) {
                                index = i + 1;
                                
                                tr_sales_data += "<tr>"+
                                    "<td>"+index+"</td>"+
                                    "<td>"+response.sales_item[i].stock_name+"<br><b style='color: red'>Stock ID: </b> <em>"+response.sales_item[i].stock_unique_id+"</em></td>" +
                                    "<td>&#8358;"+numberWithCommas(response.sales_item[i].unit_price)+"</td>" +
                                    "<td>"+numberWithCommas(response.sales_item[i].quantity)+"</td>" +
                                    "<td>&#8358;"+numberWithCommas(response.sales_item[i].sub_total)+"</td>" +
                                "</tr>"
                                grandTotal += response.sales_item[i].sub_total;
                            }
                            
                            //Let's prepare col-8 data first...
                            table = '<div class="table-responsive">' +
                                '<table class="table card-table display">' +
                                    '<thead>' +
                                        '<tr>' +
                                            '<th>S/No</th>' +
                                            '<th>Stock Name</th>' +
                                            '<th>Unit Price</th>' +
                                            '<th>Quantity </th>'+
                                            '<th>Total </th>' +
                                        '</tr>' +
                                    '</thead>' +
                                    '<tbody>'+
                                        tr_sales_data +
                                    '</tbody>' +
                                '</table>' +
                            '</div>'
                            
                            checkOutResponseBody.removeClass('d-none');
                            salesCartResponseBody.find("#invoice_span_id").html(invoiceNo);
                            salesCartResponseBody.find(".sales_body").html(table);

                            
                            // Let's prepare col-4 data first...
                            summaryData = '<div class="row mb-3">'+
                                '<div class="col-lg-12" style="border-top: 1px dashed #aaa; border-bottom: 1px dashed #aaa; padding: 15px;display: flex; align-items: center; flex-direction: column;">'+
                                    '<div><h4 class="fs-24 test-gray">Grand Total</h4></div>' +
                                    '<div><h4 class="text-center text-success fs-24 font-w700 mb-0">'+
                                            '&#8358;'+numberWithCommas(grandTotal) +
                                        '</h4>'+
                                    '</div>'+
                                '</div>'+
                            '</div>'
                            
                            if(response.payment_status !== undefined && response.payment_status != 0) {
                                if(response.payment_status == 1 && response.delivery_status == 1) {
                                    summaryData += '<div class="bg-success text-white p-3 text-center">'+
                                        'Item delivered by <br> '+ response.checkout.admin.fullName+
                                    '</div>'
                                }
                                else if(response.payment_status == 1 && response.delivery_status == 1) {
                                    summaryData += '<div class="bg-warning text-white p-3 text-center">'+
                                        'Sales canceled by <br> '+ response.checkout.admin.fullName+
                                    '</div>'
                                }
                                else if(response.payment_status == 1) {
                                    summaryData += '<div class="bg-success text-white p-3 text-center">'+
                                        'Payment received by <br> '+ response.cashier.fullName+
                                    '</div>'
                                }
                            }
                            else {

                                summaryData += '<div class="form-group">'+
                                    '<form method="post" action="<?php echo BASE_URL;?>controllers/sales.php">'+
                                        '<input class="invoiceNumber" name="invoiceNumber" type="hidden" value="'+invoiceNo+'">'+
                                        '<button type="submit" name="submitSales" class="btn btn-success btn-block complete-sales">Complete Sales</button>'+
                                    '</form>'+
                                '</div>'
                            }

                            salesSummaryesponseBody.find('.summary_body').html(summaryData);

                        }
                    }
                });
            }
        })

        function numberWithCommas(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
    </script>

</body>

</html>