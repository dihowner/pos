<?php
require "includes/config.php";
session_destroy();

// It will redirect to login cos of session_checker...

header("location: login");
?>