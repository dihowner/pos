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
                                    <b style='color: red'>NOTE: </b> Please ensure a valid sales reference number
                                </div>
                            
                                <div class="row form-group mb-3 mt-3">
                                    <div class="col-sm-9 col-xs-8 mb-2">
                                        <input type="text" class="form-control form-control-lg invoiceNo" placeholder="Enter sales refence Number: 49501132529" require>  
                                    </div>

                                    <div class="col-sm-3 col-xs-4 mb-2">
                                        <button id="search-item" class="btn btn-primary btn-block previewSales" type="button"><i class="fa fa-search"></i> Preview Sales</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card d-none" id="sales-info-card">
                        <div class="card-header">
                            <h4>Sales Info</h4>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table id="pricePreview" class="table card-table display dataTablesCard">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Sales Data</th>
                                            <th>Waiter</th>
                                            <th>Cashier</th>
                                            <th>Amount</th>
                                            <th>Payment Method</th>
                                            <th>Payment Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        
                                    </tbody>
                                </table>
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
        $(".previewSales").on("click", function() {
            var searchBtn = $(".previewSales");
            var invoiceNo = $(".invoiceNo").val();
            
            var infoCard = $('#sales-info-card');
            
            if(invoiceNo == undefined || invoiceNo == "") {
                infoCard.addClass('d-none');
                swal.fire({
                    icon: "error", 
                    title: "Error",
                    html: "Please enter sales refernece number"
                });
            }
            else {
                $.ajax({
                    url: "<?php echo BASE_URL ?>controllers/sales.php",
                    type: "post",
                    data: { 'getSales': true, 'sales_reference': invoiceNo },
                    beforeSend: function() {
                        var load = "<i class='fa fa-spinner fa-spin'></i> loading"
                        searchBtn.attr('disabled', true);
                        searchBtn.html(load);
                    },
                    complete: function() {
                        var unload = "<i class='fa fa-search'></i> Preview Sales"

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

                            infoCard.addClass('d-none');
                            swal.fire({title: "Error !", html: errors, icon:"error"});
                            
                        } else {
                            
                            infoCard.removeClass('d-none');
                            currency = "&#8358;";

                            if (response.salesItem.payment_status == 1 && response.salesItem.delivery_status == 0) {
                                button = "<button class='btn btn-success deliver-items'>Deliver Now!</button>"
                            } else if (response.salesItem.payment_status == 1 && response.salesItem.delivery_status == 1) {
                                button = response.salesItem.delivery

                                if (response.salesItem.checkout != false && response.salesItem.checkout != undefined) {
                                    button += "<small class='text-primary d-block'>"+ response.salesItem.checkout.admin.fullName +"</small>"
                                    button += "<small class='text-default d-block'>"+ response.salesItem.checkout.date +"</small>"
                                }
                            } else {
                                button = "<button class='btn btn-danger deliver-items' disabled>Not Paid!</button>"
                            }

                            tr = "<tr>" + 
                                "<td>" +
                                    response.salesItem.date +
                                "</td>" +

                                "<td>" +
                                    "<span class='d-block'>" +
                                        "<strong class='text-danger'>Reference: </strong>" +
                                        response.salesItem.reference+
                                    "</span>" +
                                "</td>" +

                                "<td>" +
                                    response.salesItem.waiter.fullname +
                                "</td>" +

                                "<td>" +
                                    response.salesItem.cashier.fullname +
                                "</td>" +

                                "<td>" +
                                    currency+numberWithCommas(response.salesItem.grand_total) +
                                "</td>" +

                                "<td>" +
                                    response.salesItem.payment_method.name +
                                "</td>" +

                                "<td>" +
                                    
                                    response.salesItem.payment +
                                "</td>" +

                                "<td>" + button + "</td>" +

                            "</tr>"

                            infoCard.find('tbody').html(tr);
                            
                        }
                    }
                });
            }
        })

        $(document).on('click', '.deliver-items', function() {
            var deliverItemBtn = $(this);
            var salesRef = $(".invoiceNo").val();
            $.ajax({
                url: "<?php echo BASE_URL ?>controllers/sales.php",
                type: "post",
                data: {
                    'checkout': 1,
                    'sales_reference': salesRef,
                },
                beforeSend: function() {
                    var load = "<i class='fa fa-spinner fa-spin'></i> loading"

                    deliverItemBtn.attr('disabled', true);
                    deliverItemBtn.html(load);
                },
                complete: function() {
                    var unload = "Deliver Now!"

                    deliverItemBtn.attr('disabled', false);
                    deliverItemBtn.html(unload);
                },
                success: function(response) {
                    console.log(response);

                    if (response.error != undefined) {
                        errors = "";
                        response.error.forEach(error => {
                            errors += "<li>"+error+"</li>"
                        });

                        swal.fire({title: "Error !", html: errors, icon: "error"});

                    } else {
                        swal.fire({title: "Success !", html: response.msg, icon: "success"});
                        window.location = '<?php echo BASE_URL.PAGE_NAME?>';
                    }
                }
            });
        });

        function numberWithCommas(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
    </script>

</body>

</html>