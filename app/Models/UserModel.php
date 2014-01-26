<?php

class UserModel extends AppModel{

	function login($f3,$params){
		$user = new \DB\SQL\Mapper($this->db, 'USER');
		$auth = new \Auth($user, array('id'=>'mail_user', 'pw'=>'password_user'));
		return $auth->login($params['mail_user'],$params['password_user']);
	}
}