<?php

class UserController extends Controller{

	public function __construct(){
		parent::__construct();
	}

	function login($f3){
		$user = $this->model->login($f3->get('POST'));
		//Si les data de l'user existent on commence la session
		if($user){						
			$f3->set('user',$user);	
			$f3->set('SESSION.id_user', $user->id_user);
			$f3->set('SESSION.firstname_user', $user->firstname_user);
			$f3->set('SESSION.lastname_user', $user->lastname_user);
		} 
		echo json_encode(array('status'=>$user));
	}

	function register($f3){	
		switch ($f3->get('VERB')) {
			case 'POST':
				$user = $this->model->register($f3->get('POST'));

				//Si l'inscription a réussi on log l'user et on le redirige vers l'accueil
				if($user){						
					$f3->set('user',$user);			
					$f3->set('SESSION.id_user', $user->id_user);
					$f3->set('SESSION.firstname_user', $user->firstname_user);
					$f3->set('SESSION.lastname_user', $user->lastname_user);
					$f3->reroute('/');
				} 
				break;			
			case 'GET':
				if($f3->get('SESSION.id_user'))
					$f3->reroute('/');
				echo View::instance()->render('User/register.html');
		}
		
	}

	function checkMail($f3){
		$mail = $this->model->checkMail($f3->get('POST'));
		echo $mail;
	}

	function getUser($f3){
		$f3->set('user',$this->model->getUser($f3->get('PARAMS')));
		$recipe_model = new RecipeModel();
		$f3->set('recipes', $recipe_model->getRecipesByUser($f3->get('PARAMS')));
		$f3->set('favorites',$recipe_model->getFavoritesRecipesByUser($f3->get('PARAMS')));
		echo View::instance()->render('User/user.html');
	}

	function logout($f3){
		$f3->clear('SESSION');
		$f3->reroute('/');
	}

	function like($f3){
		$like = $this->model->like($f3->get('PARAMS'));
		echo json_encode(array('status'=>$like));
	}
}