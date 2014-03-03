<?php

class UserController extends Controller{

	public function __construct(){
		parent::__construct();
	}

	function login($f3){
		switch ($f3->get('VERB')) {
			case 'POST':
				$user = $this->model->login($f3->get('POST'));
				//Si les data de l'user existent on commence la session
				if($user){						
					$f3->set('user',$user);	
					$f3->set('SESSION.id_user', $user->id_user);
					$f3->set('SESSION.firstname_user', $user->firstname_user);
					$f3->set('SESSION.lastname_user', $user->lastname_user);
					$f3->set('SESSION.urlImage_user', $user->urlImage_user);
				} 
				echo json_encode(array('status'=>$user));
			break;			
			case 'GET':
				echo View::instance()->render('User/login.html');  
		} 
	}

	function logout($f3){
		if($f3->get('VERB') == 'POST')
			$f3->error(405); 

		$f3->clear('SESSION');
		$f3->reroute('/');
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
					$f3->set('SESSION.urlImage_user', $user->urlImage_user);		
					$f3->reroute('/');
				} 
				
				break;			
			case 'GET':
				if($f3->get('SESSION.id_user'))
					$f3->reroute('/');
				echo View::instance()->render('User/register.html');
		}
		
	}


	function FBConnect($f3){	
		if($f3->get('VERB') == 'GET')
			$f3->error(405); 

		$user = $this->model->FBConnect($f3->get('POST'));

		//Si l'inscription a réussi on log l'user et on le redirige vers l'accueil
		if($user){
			$f3->set('user',$user);			
			$f3->set('SESSION.id_user', $user->id_user);
			$f3->set('SESSION.firstname_user', $user->firstname_user);
			$f3->set('SESSION.lastname_user', $user->lastname_user);
			$f3->set('SESSION.urlImage_user', $user->urlImage_user);				
			echo json_encode(array('status'=>true));			
		} 		
	}

	function checkMail($f3){
		if($f3->get('VERB') == 'GET')
			$f3->error(405); 

		$mail = $this->model->checkMail($f3->get('POST'));
		echo json_encode(array('status'=>$mail));
	}

	function getUser($f3){	
		if($f3->get('VERB') == 'POST')
			$f3->error(405);

		$f3->set('user',$this->model->getUser($f3->get('PARAMS')));
		$recipe_model = new RecipeModel();
		$f3->set('recipes', $recipe_model->getRecipesByUser($f3->get('PARAMS')));
		$f3->set('favorites',$recipe_model->getFavoritesRecipesByUser($f3->get('PARAMS')));

		//Gestion du follow
		if($f3->exists('SESSION.id_user')){
			$f3->set('PARAMS.id_follower', $f3->get('SESSION.id_user'));
			$f3->set('isFollowing',$this->model->getIsFollowing($f3->get('PARAMS')));
		}
		$f3->set('followers',$this->model->getFollowers($f3->get('PARAMS')));
		$f3->set('following',$this->model->getFollowing($f3->get('PARAMS')));

		echo View::instance()->render('User/viewUser.html');
	}

	function editUser($f3){	
		switch ($f3->get('VERB')) {
			case 'POST':
				if($f3->get('POST.id_user') != $f3->get('SESSION.id_user'))
					$f3->error(403); 

				$file = $_FILES['urlImage_user'];
				$fileDir = $f3->get('UPLOADS').'user/'.$f3->get('SESSION.id_user').'/';
				$fileName = $file ? $fileDir.$f3->camelcase($file['name']) : null;

				if (!file_exists($fileDir) && !empty($fileName)){
    						mkdir($fileDir, 0777, true);
				}
				if(move_uploaded_file($file['tmp_name'], $fileName) && !empty($fileName)){
					$f3->set('POST.urlImage_user', $fileName);
				}

				$user = $this->model->editUser($f3->get('POST'));
				//Si l'edit a réussi on le redirige vers son profil
				if($user){						
					$f3->set('user',$user);			
					$f3->set('SESSION.firstname_user', $user->firstname_user);
					$f3->set('SESSION.lastname_user', $user->lastname_user);
					$f3->set('SESSION.urlImage_user', $user->urlImage_user);
					$f3->reroute('/user/getUser/'.$f3->get('SESSION.id_user'));
				} 
				break;			
			case 'GET':
				if($f3->get('PARAMS.id') != $f3->get('SESSION.id_user'))
					$f3->error(403); 

				//Gestion du follow
				if($f3->exists('SESSION.id_user')){
					$f3->set('PARAMS.id_follower', $f3->get('SESSION.id_user'));
					$f3->set('isFollowing',$this->model->getIsFollowing($f3->get('PARAMS')));
				}
				$f3->set('followers',$this->model->getFollowers($f3->get('PARAMS')));
				$f3->set('following',$this->model->getFollowing($f3->get('PARAMS')));

				$f3->set('user',$this->model->getUser($f3->get('PARAMS')));
				echo View::instance()->render('User/editUser.html');
		}			
	}

	function like($f3){
		if($f3->get('VERB') == 'GET')
			$f3->error(405); 

		$like = $this->model->like($f3->get('PARAMS'));
		echo json_encode(array('status'=>$like));
	}

	function follow($f3){
		if($f3->get('VERB') == 'GET')
			$f3->error(405); 

		$follow = $this->model->follow($f3->get('PARAMS'));
		echo json_encode(array('status'=>$follow));
	}

	function getFollowing($f3){	
		if($f3->get('VERB') == 'POST')
			$f3->error(405);

		//Gestion du follow
		if($f3->exists('SESSION.id_user')){
			$f3->set('PARAMS.id_follower', $f3->get('SESSION.id_user'));
			$f3->set('isFollowing',$this->model->getIsFollowing($f3->get('PARAMS')));
		}
		$f3->set('followers',$this->model->getFollowers($f3->get('PARAMS')));
		$f3->set('following',$this->model->getFollowing($f3->get('PARAMS')));

		$f3->set('user',$this->model->getUser($f3->get('PARAMS')));
		echo View::instance()->render('User/viewFollowing.html');
	}

	function getFollowers($f3){	
		if($f3->get('VERB') == 'POST')
			$f3->error(405);
		$f3->set('user',$this->model->getUser($f3->get('PARAMS')));

		//Gestion du follow
		if($f3->exists('SESSION.id_user')){
			$f3->set('PARAMS.id_follower', $f3->get('SESSION.id_user'));
			$f3->set('isFollowing',$this->model->getIsFollowing($f3->get('PARAMS')));
		}
		$f3->set('followers',$this->model->getFollowers($f3->get('PARAMS')));
		$f3->set('following',$this->model->getFollowing($f3->get('PARAMS')));

		$f3->set('user',$this->model->getUser($f3->get('PARAMS')));
		echo View::instance()->render('User/viewFollowers.html');
	}

	function comment($f3){
		if($f3->get('VERB') == 'GET')
			$f3->error(405); 

		$f3->set('PARAMS.content_comment',$f3->get('POST.content_comment'));
		$comment = $this->model->comment($f3->get('PARAMS'));
		echo json_encode(array('status'=>$comment));
	}
}