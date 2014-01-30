<?php 

class HomeController extends Controller{

	public function __construct(){
		parent::__construct();
	}	
	function home($f3){
		echo View::instance()->render('main.html');   
	}
}