<?php

namespace REST; 

class recipes extends api{
	
	public function get($f3){
		$mapper = $this->getMapper('FULLRECIPE');
		$f3->set('recipes',$mapper->find(array(), array('order'=>'id_recipe')));
		$this->tpl='json/recipes.json';
	}
	public function post($f3){

	}
	public function put($f3){

	}
	public function delete($f3){

	}

}

?>