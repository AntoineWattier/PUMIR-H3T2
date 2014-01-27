<?php

class UserController extends AppController{

	function login($f3){
		$model = new UserModel();
		$user = $model->login($f3,$f3->get('POST'));
		//Si les data de l'user existent on commence la session
		if($user){						
			$f3->set('user',$user);	
			$f3->set('SESSION.id_user', $user->id_user);
			echo true;
		} 
	}

	function register($f3){	
		switch ($f3->get('VERB')) {
			case 'POST':
				$model = new UserModel();
				$user = $model->register($f3,$f3->get('POST'));

				//Si l'inscription a réussi on log l'user et on le redirige vers l'accueil
				if($user){						
					$f3->set('user',$user);			
					$f3->set('SESSION.id_user', $user->id_user);
					$f3->reroute('/');
				} 
				break;
			
			case 'GET':
				echo View::instance()->render('register.html');
				break;
		}
		
	}

	function checkMail($f3){
		$model = new UserModel();
		$mail = $model->checkMail($f3,$f3->get('POST'));
		echo $mail;
	}

	function getUser($f3){
		$model = new UserModel();
		$f3->set('user',$model->getUser($f3,$f3->get('PARAMS')));
		echo View::instance()->render('user.html');
	}

	function logout($f3){
		$f3->clear('SESSION');
		$f3->reroute('/');
	}
}