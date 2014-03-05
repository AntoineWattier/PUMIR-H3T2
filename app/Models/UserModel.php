<?php

class UserModel extends Model{

	private $mapper;

	function __construct(){
		parent::__construct();
		$this->mapper = $this->getMapper('USER');
	}

	function login($params){
		$auth = new \Auth($this->mapper, array('id'=>'mail_user', 'pw'=>'password_user'));

		//Si le mail et le password sont bons
		if($auth->login($params['mail_user'],$params['password_user'])){
			$this->mapper->load(array("mail_user = :mail", 'mail'=>$params['mail_user']));
			//On set le last login à now
			$this->mapper->lastLogin_user = date("Y-m-d H:i:s");
			$this->mapper->save();
			//On renvoit les data de l'user
			return $this->mapper;
		} else {
			return false;
		}
	}

	function register($params){
		$this->mapper->reset();		
		$_POST['adminLevel_user'] = 0;
		$_POST['slug_user'] = \Helpers\Tools::instance()->slugify(strtolower($params['firstname_user']).'_'.strtolower($params['lastname_user']));
		$this->mapper->copyfrom('POST',function($val) {
		    return array_intersect_key($val, array_flip(
		    	array('firstname_user','lastname_user','slug_user','mail_user','password_user'))
		    );
		});
		$this->mapper->save();
		return $this->mapper;
	}

	function FBConnect($params){
		$this->mapper->load(array("facebookId_user = :facebookId_user", 'facebookId_user'=>$params['facebookId_user']));

		//Si l'user n'est pas déjà register via FB on l'insert
		if($this->mapper->dry()){
			$this->mapper->reset();		
			$_POST['adminLevel_user'] = 0;
			$_POST['slug_user'] = \Helpers\Tools::instance()->slugify(strtolower($params['firstname_user']).'_'.strtolower($params['lastname_user']));
			$this->mapper->copyfrom('POST',function($val) {
			    return array_intersect_key($val, array_flip(
			    	array('firstname_user','lastname_user','slug_user','mail_user','facebookId_user','urlImage_user'))
			    );
			});
			$this->mapper->save();
		} else {
		//Sinon on le log
			$this->mapper->lastLogin_user = date("Y-m-d H:i:s");
			$this->mapper->save();
		}

		return $this->mapper;
	}

	function checkMail($params){
		$this->mapper->reset();
		$this->mapper->load(array("mail_user = :mail", 'mail'=>$params['mail_user']));
		return !$this->mapper->dry();
	}

	function getUser($params)
	{
		return $this->mapper->load(array("id_user = :id", ':id' => $params['id']));
	}

	function editUser($params){
		$this->mapper->load(array("id_user = :id", ':id' => $params['id_user']));
		// $params['adminLevel_user'] = 0;
		$params['slug_user'] = \Helpers\Tools::instance()->slugify(strtolower($params['firstname_user']).'_'.strtolower($params['lastname_user']));
		if(isset($params['firstname_user']))
			$this->mapper->firstname_user = $params['firstname_user'];
		if(isset($params['lastname_user']))
			$this->mapper->lastname_user = $params['lastname_user'];
		if(isset($params['slug_user']))
			$this->mapper->slug_user = $params['slug_user'];
		if(isset($params['mail_user']))
			$this->mapper->mail_user = $params['mail_user'];
		if(isset($params['password_user']))
			$this->mapper->password_user = $params['password_user'];
		if(isset($params['urlImage_user']))
			$this->mapper->urlImage_user = $params['urlImage_user'];

		$this->mapper->bio_user = $params['bio_user'];
		$this->mapper->save();
		return $this->mapper;
	}	

	function like($params){
		$vote_mapper = $this->getMapper('VOTE');
 		$favorite = $vote_mapper->load(array('id_user = ? and id_recipe = ? ',$params['id_user'],$params['id_recipe']));
 		$vote_mapper->reset();
	 	if (!$favorite) {
	 		$vote_mapper->id_recipe = $params['id_recipe'];
		 	$vote_mapper->id_user = $params['id_user'];
		 	$vote_mapper->save();
		 	return true;
	 	} else {
	 		$favorite->erase();
	 		return false;
	 	}	
	}

	function follow($params){
		$follow_mapper = $this->getMapper('FOLLOW');
 		$follow = $follow_mapper->load(array('id_following = ? and id_follower = ? ',$params['id_following'],$params['id_follower']));
 		$follow_mapper->reset();
	 	if (!$follow) {
	 		$follow_mapper->id_following = $params['id_following'];
		 	$follow_mapper->id_follower = $params['id_follower'];
		 	$follow_mapper->save();
		 	return true;
	 	} else {
	 		$follow->erase();
	 		return false;
	 	}	
	}

	function getIsFollowing($params){
		$follow_mapper = $this->getMapper('FOLLOW');
		$follow_mapper->load(array('id_following = ? and id_follower = ? ',$params['id'],$params['id_follower']));
		return $follow_mapper->dry();
	}

	function getFollowing($params){
		$subscribe_mapper = $this->getMapper('SUBSCRIBE');
		return $subscribe_mapper->find(array('id_follower = ? ',$params['id']));
	}

	function getFollowers($params){
		$subscribe_mapper = $this->getMapper('SUBSCRIBE');
		return $subscribe_mapper->find(array('id_following = ? ',$params['id']));
	}

	function comment($params){
		$comment_mapper = $this->getMapper('COMMENT');

 		$comment_mapper->reset();
 		$comment_mapper->id_step = $params['id_step'];
	 	$comment_mapper->id_user = $params['id_user'];
	 	$comment_mapper->content_comment = $params['content_comment'];
	 	$comment_mapper->save();
	 	return true;
	}

}