<?php

namespace REST; 

class users extends api{
	
	public function get($f3){
		$mapper = $this->getMapper('USER');
		$f3->set('users',$mapper->find());
		$this->tpl='json/users.json';
	}
	public function post($f3){

	}
	public function put($f3){

	}
	public function delete($f3){

	}

}

?>