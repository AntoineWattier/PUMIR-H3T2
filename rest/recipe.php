<?php

namespace REST; 

class recipe extends api{
	
	public function get($f3){
		$mapper = $this->getMapper('FULLRECIPE');
		$f3->set('recipe',$mapper->load(array('id_recipe ='.$f3->get('PARAMS.id'))));
		$f3->set('steps',$this->getMapper('STEP')->find( array('id_recipe = '.$f3->get('PARAMS.id')), array('ORDER' => 'order_step')));
		$f3->set('comments',$this->getMapper('POST')->find( array('id_recipe = '.$f3->get('PARAMS.id'))));
		if($mapper->dry())
			$f3->error(404);
		else
			$this->tpl='json/recipe.json';
	}
	public function post($f3){

	}
	public function put($f3){

	}
	public function delete($f3){

	}

}

?>