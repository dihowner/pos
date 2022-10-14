<?php require "components/head.php"; ?>

<body class="vh-100">
    <div class="authincation h-100">
        <div class="container h-100">
            <div class="row justify-content-center h-100 align-items-center">
                <div class="col-md-6">
                    <div class="authincation-content">
                        <div class="row no-gutters">
                            <div class="col-xl-12">
                                <div class="auth-form">
									<div class="text-center mb-3">
										<b style="color: #212eb8; font-size: 28px;"><?php echo SITE_TITLE;?></b>
									</div>
                                    <h4 class="text-center mb-4">Sign in your account</h4>
                                    
                                    <?php echo $utility->displayFormError() ?>

                                    <form action="<?php echo BASE_URL?>controllers/adminAuth.php" method="POST">
                                        <div class="form-group">
                                            <label class="mb-1"><strong>Username</strong></label>
                                            <input type="text" class="form-control" name="username" placeholder="Enter your username">
                                        </div>
                                        <div class="form-group">
                                            <label class="mb-1"><strong>Password</strong></label>
                                            <input type="password" class="form-control" name="password" placeholder="Enter your password">
                                        </div>
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-primary btn-block" name="adminLogin">Sign Me In</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <?php include COMPONENT_DIR."footer_script.php"; ?>

</body>

</html>