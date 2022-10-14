<?php require "components/head.php";
// require MODEL_DIR."Stock.php";
$stock = new Stock($db);

if($allSettings->stock_status == "closed") {
    $_SESSION['errorMessage'] = $clientLang['stock_open'];
    header("location: ".BASE_URL."stockUpdate");
    exit;
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


                    <div class="col-xl-8">
                        
                        <div class="card">
                            <div class="card-header"><b>Search Stock</b></div>
                            <div class="card-body">
                                
                                <div class="row form-group">
                                    <div class="col-sm-9 col-xs-8">
                                        <input type="text" class="form-control form-control-lg stockId" placeholder="Stock ID" require>  
                                    </div>

                                    <div class="col-sm-3">
                                        <button class="btn btn-primary btn-block add_cart_stock" type="button"><b><i class="fa fa-plus"></i> Add Item</b></button>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="card">
                            <div class="card-header"><b>Sales Cart</b></div>
                            <div class="card-body">
                                
                                <?php 
                                // unset($_SESSION['cartItem']); 
                                // print_r($_SESSION['cartItem']); 
                                ?>

                                <div class="table-responsive">
                                    <table id="cart-table" class="table card-table display dataTablesCard">
                                        <thead>
                                            <tr>
                                                <th style="width: 2%;">
                                                    <a href="javascript:void(0)" class="empty-cart" onclick="">
                                                        <i class="fa fa-minus-circle text-danger"></i>
                                                    </a>
                                                </th>
                                                <th style="width: 30%;">Item</th>
                                                <th style="width: 18%;">Unit Price</th>
                                                <th style="width: 15%;">Quantity</th>
                                                <th style="width: 20%;">Total </th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if(!empty($_SESSION['cartItem']['items'])) {
                                                
                                                //Grand total dey fuck up.... abeg set manually...
                                                $grandTotal = 0;

                                                foreach ($_SESSION['cartItem']['items'] as $index => $cartItem) { 
                                                    $stock_id = $cartItem["stock_id"];
                                                    $getStock = $stock->getStockByStockId($stock_id);
                                                    $grandTotal += $cartItem['sub_total'];
                                                ?>
                                                    <tr data-id="<?php echo $index?>">

                                                        <td style="width: 2%;">
                                                            <a href="javascript:void(0)" class="remove-item">
                                                                <i class="fa fa-minus-circle text-warning"></i>
                                                            </a>
                                                        </td>

                                                        <td style="width: 30%;">
                                                            <h5><?php echo $getStock->stock_name;?></h5>
                                                            <i class="fs-14"><?php echo $stock_id; ?></i>
                                                        </td>

                                                        <td style="width: 15%;">
                                                            &#8358;<?php echo number_format($getStock->stock_price, 2);?>
                                                        </td>

                                                        <td style="width: 15%;">
                                                            <input type="number" min="1" value="<?php echo $cartItem['quantity'] ?>" max="<?php echo $getStock->stock_qty ?>" class="form-control edit-quantity">
                                                        </td>
                                                            
                                                        <td style="width: 20%;">
                                                            <span class="fs-20 font-w600 text-success">&#8358;<?php echo number_format($cartItem['sub_total'], 2) ?></span>
                                                        </td>

                                                        <td>
                                                            <i class="fa fa-plus-circle fa-2x text-success updateqty_button" style="color: #0096FF; cursor: pointer"></i>
                                                        </td>

                                                    </tr>
                                                <?php
                                                }
                                                // Manually set Grand total back...
                                                $_SESSION['cartItem']['grand_total'] = $grandTotal;
                                            } ?>

                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                        
                    </div>

                    <div class="col-xl-4">

                        <div class="card">
                            <div class="card-header"><b>Apply Discount</b></div>
                            <div class="card-body">
                                
                                <div class="row form-group">
                                    <input type="text" class="form-control form-control-lg couponCode" placeholder="Enter coupon code" style="text-transform: uppercase" required <?php echo empty($_SESSION['cartItem']) ? "disabled":"";?>>  
                                </div>
                                
                                <div class="text-center">
                                    <div class="form-group">
                                        <button type="button" class="btn btn-primary btn-block applyCoupon" <?php echo empty($_SESSION['cartItem']) ? "disabled":"";?>>
                                            <i class="fa fa-paper-plane"></i> Apply Coupon
                                        </button>
                                    </div>
                                </div>

                            </div>
                            <?php 
                                $couponAmount = $grandTotal = 0;
                            if(isset($_SESSION['cartItem']['coupon'])) {
                                $couponAmount = $_SESSION['cartItem']['coupon']['amount']; ?>
                                <div class="card-footer">
                                    <h4 class="text-center text-danger fs-24 font-w700 mb-0">
                                        Discount: &#8358;<?php echo number_format(!empty($_SESSION['cartItem']['coupon']) ? $couponAmount:0, 2) ?>
                                        <button class="btn btn-primary btn-xr remove_coupon"><i class='fa fa-trash'></i> Remove</button>
                                    </h4>
                                </div>
                            <?php } ?>
                        </div>

                        <div class="card">
                            <div class="card-header"><b>Summary</b></div>
                            <div class="card-body">
                                
                                <div class="row mb-3">
                                    <div class="col-lg-12" style="border-top: 1px dashed #aaa; border-bottom: 1px dashed #aaa; padding: 15px;display: flex; align-items: center; flex-direction: column;">
                                        <div>
                                            <h4 class="fs-24 test-gray">Grand Total</h4>
                                        </div>
                                        <div>
                                        <h4 class="text-center text-success fs-24 font-w700 mb-0">
                                                &#8358;<?php 
                                                if(isset($_SESSION['cartItem'])) {
                                                    $grandTotal = $_SESSION['cartItem']['grand_total'];
                                                }
                                                echo number_format(!empty($_SESSION['cartItem']['items']) ? ($grandTotal - $couponAmount):0, 2) ?></h4>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="text-center">
                                    <div class="form-group">
                                        <button type="button" class="btn btn-warning btn-block generateInvoice" <?php echo empty($_SESSION['cartItem']) ? "disabled":"";?>>
                                            <i class="fa fa-paper-plane"></i> Generate Invoice
                                        </button>
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
        $(".add_cart_stock").on("click", function() {

            var stockId = $(".stockId").val();
            var addToCartBtn = $(this);
            
            if(stockId == undefined || stockId == "") {
                swal.fire({
                    icon: "error", 
                    title: "Error",
                    html: "Please enter Stock ID"
                });
            }
            else {
                var parameters = {
                    "stock_id": stockId,
                    "quantity": 1
                }

                var cartItems = cart('add', parameters, $(this));
                cartItems.done(function (response) {

                    console.log(response);

                    addToCartBtn.attr('disabled', false);
                    addToCartBtn.html("<i class='fa fa-plus'></i> Add Item");

                    if (response != undefined) {
                        if (response.error != undefined) {
                            var errorMsg = "<ul>"
                            response.error.forEach(error => {
                                errorMsg += "<li>"+error+"</li>"
                            });
                            errorMsg += "</li>" 
        
                            swal.fire({ title:"Error!", html: errorMsg, icon:"error" });
                        } else {
                            // swal.fire({ title:"Success !", html: "Stock added to cart successfully", icon: "success"});
                            window.location = "<?php echo BASE_URL.PAGE ?>"
                        }
                    }
                })
            }
        })

        $(".updateqty_button").on('click', function() {
            
            var stockId = $(this).parents('tr').attr('data-id');
            var quantity = $(this).parents("tr").find(".edit-quantity").val();

            var parameters = {
                "stock_id": stockId,
                "quantity":quantity,
            }

            var cartItems = cart('update_quantity', parameters);
            
            console.log(cartItems);

            cartItems.done(function (response) {
                if (response != undefined) {
                    if (response.error != undefined) {
                        var errorMsg = "<ul>"
                        response.error.forEach(error => {
                            errorMsg += "<li>"+error+"</li>"
                        });
                        errorMsg += "</li>" 
    
                        swal.fire({title: "Error!", html: errorMsg, icon: "error" });
                    } else {
                        console.log(response);
                        window.location = "<?php echo BASE_URL.PAGE ?>"
                    }
                }
            })

        });  

        $(".remove-item").on('click', function (params) {
            var removeBtn = $(this);
            var stockId = $(this).parents('tr').attr('data-id');

            var parameters = {
                "stock_id": stockId,
            }

            var cartItems = cart('remove', parameters);
            cartItems.done(function (response) {

                console.log(response);
                
                if (response != undefined) {
                    if (response.error != undefined) {
                        var errorMsg = "<ul>"
                        response.error.forEach(error => {
                            errorMsg += "<li>"+error+"</li>"
                        });
                        errorMsg += "</li>" 
    
                        swal.fire({title:"Error!", html: errorMsg, icon:"error"});
                    } else {
                        window.location = "<?php // echo BASE_URL.PAGE ?>"
                    }
                }
            })

        });

        $(".empty-cart").on('click', function (params) {
            <?php if (!empty($_SESSION['cartItem']['items'])) {?>
                var cartItems = cart('empty');

                cartItems.done(function (response) {
                    if (response != undefined) {
                        if (response.error != undefined) {
                            var errorMsg = "<ul>"
                            response.error.forEach(error => {
                                errorMsg += "<li>"+error+"</li>"
                            });
                            errorMsg += "</li>" 
        
                            swal.fire({title:"Error!", html: errorMsg, icon: "error"});
                        } else {
                            window.location = "<?php echo BASE_URL.PAGE ?>"
                        }
                    }
                })
            <?php } ?>
        });

        function cart(operation, params = '', button = $(this)) {
            return $.ajax({
                url: "<?php echo BASE_URL;?>controllers/stock.php",
                type: "post",
                data: {
                    'cart': 1,
                    'operation': operation,
                    'stock_id': params != '' ? params.stock_id:'',
                    'quantity': params != '' ? params.quantity:''
                },
                beforeSend: function () {
                    if (button != '' && button != undefined) {
                        button.attr('disabled', true);
                        button.html('<i class="fa fa-spinner fa-spin"></i>');
                    }
                }
            });
        }

        $(".applyCoupon").on("click", function() {
            button = $(this);
            var couponCode = $(".couponCode").val();
        
            if(couponCode == undefined || couponCode == "") {
                swal.fire({
                    icon: "error", 
                    title: "Error",
                    html: "Please enter coupon code"
                });
            }
            else {
                $.ajax({
                    url: "<?php echo BASE_URL;?>controllers/coupon.php",
                    data: {"applyCoupon": true, "coupon_code": couponCode },
                    type: "post",
                    beforeSend: function() {
                        if (button != '' && button != undefined) {
                            button.attr('disabled', true);
                            button.html('<i class="fa fa-spinner fa-spin"></i>');
                        }
                    },
                    complete: function() {
                        var unload = "<i class='fa fa-paper-plane'></i> Apply Coupon"

                        button.attr('disabled', false);
                        button.html(unload);
                    },
                    success: function(response) {
                        console.log(response);

                        if (response != undefined) {
                            if (response.error != undefined) {
                                var errorMsg = "<ul>"
                                response.error.forEach(error => {
                                    errorMsg += "<li>"+error+"</li>"
                                });
                                errorMsg += "</li>" 
            
                                swal.fire({ title:"Error!", html: errorMsg, icon:"error" });
                            } else {
                                swal.fire({ title:"Success !", html: "Coupon applied successfully", icon: "success"});
                                window.location = "<?php echo BASE_URL;?>makePurchase"
                            }
                        }
                    }
                });
            }

        });

        $(".remove_coupon").on("click", function() {
            button = $(this);
            $.ajax({
                url: "<?php echo BASE_URL;?>controllers/coupon.php",
                data: {"removeCouponCart": true},
                type: "post",
                beforeSend: function() {
                    if (button != '' && button != undefined) {
                        button.attr('disabled', true);
                        button.html('<i class="fa fa-spinner fa-spin"></i>');
                    }
                },
                complete: function() {
                    var unload = "<i class='fa fa-paper-plane'></i> Apply Coupon"

                    button.attr('disabled', false);
                    button.html(unload);
                },
                success: function(response) {
                    console.log(response);

                    if (response != undefined) {
                        if (response.error != undefined) {
                            var errorMsg = "<ul>"
                            response.error.forEach(error => {
                                errorMsg += "<li>"+error+"</li>"
                            });
                            errorMsg += "</li>" 
        
                            swal.fire({ title:"Error!", html: errorMsg, icon:"error" });
                        } else {
                            swal.fire({ title:"Success !", html: "Coupon removed successfully", icon: "success"});
                            window.location = "<?php echo BASE_URL;?>makePurchase"
                        }
                    }
                }
            });
        });

        $(".generateInvoice").on("click", function() {
            var button = $(this);

            var generateInvoice = processSales('generateInvoice', button);
            // console.log(generateInvoice);

            generateInvoice.done(function (response) {
                console.log(response);

                button.attr('disabled', false);
                button.html("<i class='fa fa-paper-plane'></i> Generate Invoice");

                if (response != undefined) {
                    if (response.error != undefined) {
                        var errorMsg = "<ul>"
                        response.error.forEach(error => {
                            errorMsg += "<li>"+error+"</li>"
                        });
                        errorMsg += "</li>" 
    
                        swal("Error!", errorMsg, "error");
                    } else {
                        swal.fire({title: "Success !", html: response.msg, icon: "success"});
                        window.location = "<?php echo BASE_URL.'generateInvoice?reference=' ?>"+response.sales_ref+""
                    }
                }
            })

        })

        function processSales(action, button) {
            return $.ajax({
                url: "<?php echo BASE_URL ?>controllers/sales.php",
                type: "post",
                data: {
                    'action' : action,
                    'cart': '<?php echo isset($_SESSION['cartItem']) ? json_encode($_SESSION['cartItem']):'' ?>'
                },
                beforeSend: function () {
                    if (button != '' && button != undefined) {
                        button.attr('disabled', true);
                        button.html('<i class="fa fa-spinner fa-spin"></i>');
                    }
                }
            });
        }

    </script>
</body>

</html>