<?php

class UserController extends AppController{
	function login($f3){
		$model = new UserModel();
		echo $model->login($f3,$f3->get('POST'));
	}
}