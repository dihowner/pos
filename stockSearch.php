<?php require "components/head.php";

require_once MODEL_DIR.'Category.php';
$category = new Category($db);
$stock = new Stock($db);
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
                            <div class="card-header">
                                <b>Stock Search</b>
                            </div>
                            <div class="card-body">

                                <div class="msg_cell" style="font-size: 18px">
                                    <b style='color: red'>NOTE: </b> Please ensure to search for stock using their Stock Unique ID or Stock Name
                                </div>
                            
                                <div class="row form-group mb-3 mt-3">
                                    <div class="col-sm-9 col-xs-8 mb-2">
                                        <input type="text" name="stockText" class="form-control form-control-lg stockId" placeholder="Stock Name / Product ID" require>  
                                    </div>

                                    <div class="col-sm-3 col-xs-4 mb-2">
                                        <button id="search-item" class="btn btn-primary btn-block searchStock" type="button"><i class="fa fa-search"></i> Search Item</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-12 response_body d-none">
                        <div class="card">
                            <div class="card-header" style="background: #f9f9f9">
                                <b>Search Result : </b> 
                            </div>
                            <div class="card-body">

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
            
            var responseBody = $(".response_body");

            if(stockId == undefined || stockId == "") {
                responseBody.addClass('d-none').html("");
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

                            responseBody.addClass('d-none').html("");
                            swal.fire({title: "Error !", html: errors, icon:"error"});
                            
                        } else {

                            tr_data = "";
                            
                            for (let i = 0; i < response.items.length; i++) {
                                let index =  i + 1;
                                let category_name = (response.items[i].category.category_name == undefined) ? "":response.items[i].category.category_name;
                                tr_data += "<tr>" + 
                                    "<td>"+
                                       index +
                                    "</td>" + 
                                    "<td>"+
                                        response.items[i].stock_name+
                                    "</td>" + 
                                    "<td>"+
                                        response.items[i].stock_unique_id+
                                    "</td>" + 
                                    "<td>"+
                                        response.items[i].stock_qty+
                                    "</td>" + 
                                    "<td>"+
                                        category_name+
                                    "</td>" + 
                                "</tr>"
                            }

                            table = '<div class="table-responsive">' +
                                '<table class="table card-table display">' +
                                    '<thead>' +
                                        '<tr>' +
                                            '<th>S/No</th>' +
                                            '<th>Stock Name</th>' +
                                            '<th>Stock ID</th>' +
                                            '<th>Qty Available </th>'+
                                            '<th>Category </th>' +
                                        '</tr>' +
                                    '</thead>' +
                                    '<tbody>'+
                                        tr_data +
                                    '</tbody>' +
                                '</table>' +
                            '</div>'

                            

                            responseBody.removeClass('d-none').find(".card-body").html(table);
                            var table = $('table').DataTable();

                        }

                    }
                    
                });
            }
        })
    </script>

</body>

</html>