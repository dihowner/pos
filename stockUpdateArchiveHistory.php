<?php require "components/head.php";

require_once MODEL_DIR.'Category.php';
$category = new Category($db);
$stock = new Stock($db);

$allStockUpdateArchiveHistory = $stock->getAllStockUpdateArchiveHistory();

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
                    

                </div>

                <div class="row">
                    <div class="col-xl-12">
                        <div class="table-responsive">
                            <table id="example" class="table card-table display dataTablesCard">
                            <thead>
                                <tr>
                                    <th>Date Stock Opened</th>
                                    <th>Date Stock Closed</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if ($allStockUpdateArchiveHistory != FALSE) { 
                                    foreach ($allStockUpdateArchiveHistory as $index => $record) { ?>
                                        <tr>
                                            <td>
                                                <?php echo $utility->niceDateFormat($record['date_opened']) ?><br>
                                            </td>

                                            <td>
                                                <?php echo $utility->niceDateFormat($record['date_closed']) ?>
                                            </td>
                                            
                                            <td>
                                                <div class="d-flex">
                                                    <a target="__blank" href="<?php echo BASE_URL.$record['file_path'] ?>" class="btn btn-primary shadow btn-xs sharp mr-1"><i class="fa fa-download"></i></a>
                                                </div>
                                            </td>

                                        </tr>
                                    <?php }
                                } else { ?>
                                    <tr class="text-center"> 
                                        <td colspan="6">No Available Products</td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                            </table>
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

</body>

</html>