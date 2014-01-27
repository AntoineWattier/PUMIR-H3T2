<?php

class UserModel extends AppModel{

	private $user;

	function __construct(){
		parent::__construct();
		$this->user = new DB\SQL\Mapper($this->db,'USER');
	}

	function login($f3,$params){
		$auth = new \Auth($this->user, array('id'=>'mail_user', 'pw'=>'password_user'));

		//Si le mail et le password sont bons
		if($auth->login($params['mail_user'],$params['password_user'])){
			$this->user->load(array("mail_user = :mail", 'mail'=>$params['mail_user']));
			//On set le last login à now
			$this->user->lastLogin_user = date("Y-m-d H:i:s");
			$this->user->save();
			//On renvoit les data de l'user
			return $this->user;
		} else {
			return false;
		}
	}

	function register($f3,$params){
		$this->user->reset();
		$this->user->firstname_user = $params['firstname_user'];
		$this->user->lastname_user = $params['lastname_user'];
		$this->user->slug_user = strtolower($params['firstname_user']).'_'.strtolower($params['lastname_user']);
		$this->user->mail_user = $params['mail_user'];
		$this->user->password_user = $params['password_user'];
		$this->user->adminLevel_user = 0;
		$this->user->save();
		return $this->user;
	}

	function checkMail($f3,$params){
		$this->user->reset();
		$this->user->load(array("mail_user = :mail", 'mail'=>$params['mail_user']));
		if ($this->user->dry()) {
			return false;
		} else {
			return true;
		}
	}

	function getUser($f3,$params)
	{
		return $this->user->load(array("id_user = :id", ':id' => $params['id']));
	}
}