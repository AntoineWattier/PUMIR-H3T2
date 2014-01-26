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

	function getUser($f3,$params)
	{
		return $this->user->load(array("id_user = :id", ':id' => $params['id']));
	}
}