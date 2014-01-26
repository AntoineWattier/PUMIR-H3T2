<?php

// Retrieve instance of the framework
$f3=require('lib/base.php');

// Initialize configs
$f3->config('config/config.ini');

// Define routes
$f3->config('config/routes.ini');

// Execute application
$f3->run();

?>