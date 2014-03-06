<?php 

class HomeController extends Controller{

	public function __construct(){
		parent::__construct();
	}
		
	function home($f3){
		$f3->reroute('/conciergerie');
		// echo View::instance()->render('home.html');   
	}

	function api($f3){
		$this->tpl['sync'] = 'api.html';
	}

	function minify($f3){
		$f3->set('UI','public/'.$f3->get('PARAMS.type').'/'); 
        		echo Web::instance()->minify($_GET['files']);
        		exit();
	}
}