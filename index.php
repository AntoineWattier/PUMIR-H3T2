<?php

// Retrieve instance of the framework
$f3=require('lib/base.php');

// Initialize configs
$f3->config('config/config.ini');

// Define routes
$f3->config('config/routes.ini');

//Handle errors
$f3->set('ONERROR',function($f3){
    echo \View::instance()->render('error.html');
});

// Execute application
$f3->run();

?>