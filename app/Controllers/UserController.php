<?php

class UserController extends AppController{
	function login($f3){
		$model = new UserModel();
		$user = $model->login($f3,$f3->get('POST'));
		//Si les data de l'user existent on commence la session
		if($user){						
			$f3->set('user',$user);	
			session_start();		
			$_SESSION['id_user'] = $user->id_user;
			echo true;
		} 

	}

	function getUser($f3){
		$model = new UserModel();
		$f3->set('user',$model->getUser($f3,$f3->get('PARAMS')));
		echo View::instance()->render('user.html');
	}

	function logout($f3){
		//TOFIX
		session_start();
		session_destroy();
		header('Location: /');
	}
}