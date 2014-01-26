<?php 

class HomeController extends AppController{	
	function home($f3){
		echo View::instance()->render('main.html');   
	}
}