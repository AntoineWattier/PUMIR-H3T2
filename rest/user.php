<?php

namespace REST; 

class user extends api{
	
	public function get($f3){
		$user_mapper = $this->getMapper('USER');
		$f3->set('user',$user_mapper->load( array('id_user = '.$f3->get('PARAMS.id'))));
		$f3->set('comments',$this->getMapper('COMMENT')->find( array('id_user = '.$f3->get('PARAMS.id'))));
		$f3->set('posted_recipes',$this->getMapper('SUBMIT')->find( array('id_user = '.$f3->get('PARAMS.id'))));
		$f3->set('favorite_recipes',$this->getMapper('FAVORITE')->find( array('id_user = '.$f3->get('PARAMS.id'))));
		$f3->set('followings',$this->getMapper('SUBSCRIBE')->find( array('id_follower= '.$f3->get('PARAMS.id'))));
		$f3->set('followers',$this->getMapper('SUBSCRIBE')->find( array('id_following= '.$f3->get('PARAMS.id'))));

		if($user_mapper->dry())
			$f3->error(404);
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