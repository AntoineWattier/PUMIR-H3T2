<?php

namespace REST; 

class user extends api{
	
	public function get($f3){
		$user_mapper = $this->getMapper('USER');
		$f3->set('user',$user_mapper->load( array('id_user = '.$f3->get('PARAMS.id'))));
		$f3->set('comments',$this->getMapper('COMMENT')->find( array('id_user = '.$f3->get('PARAMS.id'))));
		
		if($user_mapper->dry())
			$this->tpl='json/error.json';
		else
			$this->tpl='json/user.json';
	}
	public function post($f3){

	}
	public function put($f3){

	}
	public function delete($f3){

	}

}

?>