<?php 

class HomeController extends Controller{

	public function __construct(){
		parent::__construct();
	}
		
	function home($f3){
		$f3->reroute('/conciergerie');
		// echo View::instance()->render('home.html');   
	}
}