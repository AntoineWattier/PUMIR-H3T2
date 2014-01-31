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
		$_POST['slug_user'] = Tools::slugify(strtolower($params['firstname_user']).'_'.strtolower($params['lastname_user']));
		$this->mapper->copyfrom('POST',function($val) {
		    return array_intersect_key($val, array_flip(
		    	array('firstname_user','lastname_user','slug_user','mail_user','password_user'))
		    );
		});
		$this->mapper->save();
		return $this->mapper;
	}

	function checkMail($params){
		$this->mapper->reset();
		$this->mapper->load(array("mail_user = :mail", 'mail'=>$params['mail_user']));
		if ($this->mapper->dry()) {
			return false;
		} else {
			return true;
		}
	}

	function getUser($params)
	{
		return $this->mapper->load(array("id_user = :id", ':id' => $params['id']));
	}


}