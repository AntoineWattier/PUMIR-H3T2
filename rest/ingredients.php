<?php

namespace REST; 

class ingredients extends api{
	
	public function get($f3){
		$mapper = $this->getMapper('INGREDIENT');
		$f3->set('ingredients',$mapper->find());
		$this->tpl='json/ingredients.json';
	}
	public function post($f3){

	}
	public function put($f3){

	}
	public function delete($f3){

	}

}

?>