<?php require "components/head.php";

require_once MODEL_DIR.'Category.php';
$category = new Category($db);
$stock = new Stock($db);


if($allSettings->stock_status == "opened") {
    $_SESSION['errorMessage'] = $clientLang['stock_closed'];
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
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">

                                <div class="msg_cell" style="font-size: 18px">
                                    <b style='color: red'>NOTE: </b> Please ensure to search for stock using their Stock Unique ID or Stock Name before updating stock
                                </div>

                                <form method="post" action="<?php echo BASE_URL;?>controllers/stock.php">
                                    
                                    <div class="row form-group mb-3 mt-3">
                                        <div class="col-sm-9 col-xs-8 mb-2">
                                            <input type="text" name="stockText" class="form-control form-control-lg stockId" placeholder="Stock Name / Product ID" require>  
                                        </div>

                                        <div class="col-sm-3 col-xs-4 mb-2">
                                            <button id="search-item" class="btn btn-primary btn-block searchStock" type="button"><i class="fa fa-search"></i> Search Item</button>
                                        </div>
                                    </div>

                                    <div class='stock_search_result'></div>
                                    
                                    <div class="mt-3 mb-3">
                                        <label><b>Enter Quantity</b></label>
                                        <input class="form-control form-control-lg" type="number" min="1" name="product_quantity" placeholder="Enter quantity" value="1" required>
                                    </div>
                                    
                                    <div class="text-center">
                                        <button class="btn btn-primary" type="submit" name="updateStockQty">
                                            <b><i class="fa fa-edit"></i> Update Stock Quantity</b>
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
        $(".searchStock").on("click", function() {
            var searchBtn = $(".searchStock");
            var stockId = $(".stockId").val();
            
            var searchresult = $(".stock_search_result");

            if(stockId == undefined || stockId == "") {
                swal.fire({
                    icon: "error", 
                    title: "Error",
                    html: "Please enter search criteria"
                });
            }
            else {
                $.ajax({
                    url: "<?php echo BASE_URL ?>controllers/stock.php",
                    type: "get",
                    data: { 'searchStock': true, 'stockId': stockId },
                    beforeSend: function() {
                        var load = "<i class='fa fa-spinner fa-spin'></i> loading"
                        searchBtn.attr('disabled', true);
                        searchBtn.html(load);
                    },
                    complete: function() {
                        var unload = "<i class='fa fa-search'></i> Search Item"

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

                            searchresult.addClass('d-none').html("");
                            swal.fire({title: "Error !", html: errors, icon:"error"});
                            
                        } else {

                            dataResult = "<h4><b>Search Result</b></h4>";
                            for (let i = 0; i < response.items.length; i++) {
                                dataResult += "<div class='row col-md-12'><label><div class='msg_cell mb-2'><input class='form-check-input' type='radio' name='stock_unique_id' value='"+response.items[i].stock_unique_id+"' required>"
                                + "<p class='mr-1'><b style='color: red'>Stock Name : </b>" + response.items[i].stock_name + "<br>"
                                +"<b style='color: red'>Available Quantity : </b>"+response.items[i].stock_qty + "<br>"
                                +"<b style='color: red'>Stock ID : </b>"+response.items[i].stock_unique_id
                                dataResult +="</p></div></label></div>"
                            }

                            searchresult.removeClass('d-none').html(dataResult);
                        }

                    }
                    
                });
            }
        })
    </script>

</body>

</html>