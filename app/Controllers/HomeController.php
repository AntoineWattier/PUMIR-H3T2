<?php 

class HomeController extends Controller{

	public function __construct(){
		parent::__construct();
	}
		
	function home($f3){
		echo View::instance()->render('home.html');   
	}

	function login($f3){
		echo View::instance()->render('User/login.html');   
	}

}