<?php 

class RecipeModel extends Model{

	private $mapper;

	function __construct(){
		parent::__construct();
		$this->mapper = $this->getMapper('RECIPE');
	}

	function submit($params){
		$this->mapper->reset();
		$_POST['slug_recipe'] = strtolower($params['name_recipe']);
		$_POST['id_user'] = $params['id_user'];
		$this->mapper->copyfrom('POST',function($val) {
		    return array_intersect_key($val, array_flip(
		    	array('name_recipe','slug_recipe','numberOfPeople_recipe','id_user'))
		    );
		});
		$this->mapper->save();
		return $this->mapper->id_recipe;
	}

	function getRecipe($params){
		return $this->mapper->load(array("id_recipe = :id", ':id' => $params['id']));
	}

	function getRecipes($params){
		return $this->mapper->find(array("id_user = :id", ':id' => $params['id']));
	}
}
?>