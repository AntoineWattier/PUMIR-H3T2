<?php 

class RecipeModel extends Model{

	private $mapper;

	function __construct(){
		parent::__construct();
		$this->mapper = $this->getMapper('RECIPE');
	}

	function submit($params){
		$this->mapper->reset();
		$_POST['slug_recipe'] =  Tools::slugify(strtolower($params['name_recipe']));
		$_POST['id_user'] = $params['id_user'];
		$this->mapper->copyfrom('POST',function($val) {
		    return array_intersect_key($val, array_flip(
		    	array('name_recipe','slug_recipe','numberOfPeople_recipe','preparationTime_recipe','id_user','id_ambiance'))
		    );
		});
		$this->mapper->save();
		$step_mapper = $this->getMapper('STEP');
		foreach ($_POST['step_recipe'] as $order => $content) {
			if(!empty($content)){	
				$step_mapper->reset();
				$step_mapper->order_step = $order+1;
				$step_mapper->content_step = $content;
				$step_mapper->id_recipe = $this->mapper->last()->id_recipe;
				$step_mapper->save();
			}
		}
		return $this->mapper;
	}

	function getRecipes(){
		return $this->mapper->find();
	}

	function getRecipe($params){
		return $this->mapper->load(array("id_recipe = :id", ':id' => $params['id']));
	}

	function getRecipeSteps($params){
		$step_mapper = $this->getMapper('STEP');
		return $step_mapper->find(array("id_recipe = :id", ':id' => $params['id']),array('order'=>'order_step'));
	}

	function getRecipesByUser($params){
		return $this->mapper->find(array("id_user = :id", ':id' => $params['id']));
	}

	function getRecipesByFilter($params){

			var_dump($params);
			return $this->mapper->find(
			array("difficulty_recipe = :difficulty AND numberOfPeople_recipe = :number", 
				':difficulty' => $params['difficulty'],
				':number' => $params['number']
			)
		);
	}

	function getAmbiances(){
		$ambiance_mapper = $this->getMapper('AMBIANCE');
		return $ambiance_mapper->find();
	}

	function getAmbiance($params){
		$adapt_mapper = $this->getMapper('ADAPT');
		return $adapt_mapper->load(array("id_recipe = :id", ':id' => $params['id']));
	}

	function getIngredients($params){
		$associate_mapper = $this->getMapper('ASSOCIATE');
		return $associate_mapper->find(array("id_recipe = :id", ':id' => $params['id']));
	}	
}
?>