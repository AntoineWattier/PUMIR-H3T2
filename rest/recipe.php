<?php

namespace REST; 

class recipe extends api{
	
	public function get($f3){
		$mapper = $this->getMapper('FULLRECIPE');
		$f3->set('recipes',$mapper->find(array('id_recipe ='.$f3->get('PARAMS.id'))));
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