<?php 

class RecipeModel extends Model{

	private $mapper;

	function __construct(){
		parent::__construct();
		$this->mapper = $this->getMapper('RECIPE');
	}

	function submitRecipe($params){
		$this->mapper->reset();
		$_POST['slug_recipe'] =  \Helpers\Tools::instance()->slugify(strtolower($params['name_recipe']));
		$_POST['id_user'] = $params['id_user'];
		$this->mapper->copyfrom('POST',function($val) {
		    return array_intersect_key($val, array_flip(
		    	array('name_recipe','slug_recipe','numberOfPeople_recipe','id_preparationTime','id_user','id_ambiance'))
		    );
		});
		$this->mapper->save();
		$step_mapper = $this->getMapper('STEP');
		foreach ($params['step_recipe'] as $order => $content) {
			if(!empty($content)){	
				$step_mapper->reset();
				$step_mapper->order_step = $order+1;
				$step_mapper->content_step = $content;
				$step_mapper->id_recipe = $this->mapper->last()->id_recipe;
				$step_mapper->save();
			}
		}
		$compose_mapper = $this->getMapper('COMPOSE');
		foreach ($params['ingredient_recipe'] as $order => $content) {
			if(!empty($content) && $content != -1 ){	
				$compose_mapper->reset();
				$compose_mapper->id_ingredient= $content;
				$compose_mapper->id_recipe = $this->mapper->last()->id_recipe;
				$compose_mapper->save();
			}
		}
		return $this->mapper;

	}

	function editRecipe($params){
		$this->mapper->load(array("id_recipe = :id", ':id' => $params['id_recipe']));
		$params['slug_recipe'] =  \Helpers\Tools::instance()->slugify(strtolower($params['name_recipe']));
		// $params['id_user'];
		$this->mapper->name_recipe = $params['name_recipe'];
		$this->mapper->slug_recipe = $params['slug_recipe'];
		$this->mapper->numberOfPeople_recipe = $params['numberOfPeople_recipe'];
		$this->mapper->id_preparationTime= $params['id_preparationTime'];
		//$this->mapper->id_user= $params[''];
		$this->mapper->id_ambiance= $params['id_ambiance'];
		$this->mapper->dateUpdate_recipe = date("Y-m-d H:i:s");
		$this->mapper->save();

		/**
		*	Mise à jour des étapes :
		*	- On parcourt le tableau des étapes :
		*		- Si l'étape existe déjà on update
		*			- Si le contenu de l'étape est vide on la delete
		*			- Sinon on met à jour les champs. 
		*		- Sinon on insert
		*
		*	ATTENTION : l'order_step n'est plus forcément l'index du tableau ( si le contenu d'une étape précédente était vide ),
		*	on utilise donc un compteur indépendant.
		*/
		$step_mapper = $this->getMapper('STEP');
		$index = 1;
		foreach ($params['step_recipe'] as $order => $content) {	
			$filter = array("id_recipe = :id AND order_step = :order_step", ':id' => $params['id_recipe'], ':order_step' => $order+1);
			$step_mapper->load($filter);

			//if record exists : update
			if(!$step_mapper->dry()){
				if(!empty($content)){				
					$step_mapper->order_step = $index;
					$step_mapper->content_step = $content;
					$step_mapper->id_recipe = $params['id_recipe'];
					$step_mapper->save();
					$index++;	
				} else {
					$step_mapper->erase($filter);
				}
			//else : insert
			} else {
				if(!empty($content)){	
					$step_mapper->reset();			
					$step_mapper->order_step = $index;
					$step_mapper->content_step = $content;
					$step_mapper->id_recipe = $params['id_recipe'];
					$step_mapper->save();
					$index++;	
				}
			}
		}

		/**
		*	Mise à jour des ingrédients :
		*	On supprime tous les ingrédients de la recette
		*	et on rajoute les nouveaux
		*/
		$compose_mapper = $this->getMapper('COMPOSE');
		$compose_mapper->erase(array("id_recipe = :id", ':id' => $params['id_recipe']));
		foreach ($params['ingredient_recipe'] as $order => $content) {
			if(!empty($content) && $content != -1 ){	
				$compose_mapper->reset();
				$compose_mapper->id_ingredient= $content;
				$compose_mapper->id_recipe = $params['id_recipe'];
				$compose_mapper->save();
			}
		}

		return $this->mapper;
	}

	function getRecipes($params){

		$req = array('order'=>'name_recipe');
		if(isset($params['filter'] )){
			if($params['filter'] == 'date'){
				$req = array('order'=>'dateAdd_recipe DESC');
			} else if($params['filter'] == 'votes'){
				$req = array('order'=>'votes_recipe DESC');
			}
		}

		$fullrecipe_mapper = $this->getMapper('fullrecipe');

		return $fullrecipe_mapper->find(array(),$req);
	}

	function getRecipe($params){
		$fullrecipe_mapper = $this->getMapper('fullrecipe');
		var_dump( $fullrecipe_mapper->load(array("id_recipe = :id", ':id' => $params['id'])) );
	}

	function getRecipesByUser($params){
		$fullrecipe_mapper = $this->getMapper('fullrecipe');
		return $fullrecipe_mapper->find(array("id_user = :id", ':id' => $params['id']));
	}
	function getRecipesByFilter($params){

		$filter = array();

		/**
		*	Si on fait une recherche avancée, on utilise tous les critères.
		* 	Le nombre d'ingrédients par recette n'étant pas limité, on ne peut pas faire une simple requête via le mapper sur une vue de la BDD
		*	On construit donc une requête personnalisée et les résultats de celle-ci seront passés au mapper
		*/
		if(isset($params['id_ambiance']) && isset($params['id_preparationTime']) && isset($params['id_difficulty']) && isset($params['id_type'])){

			//On construit la requête de recherche avancée de base.
			$query = "SELECT DISTINCT r.id_recipe
						FROM COMPOSE a
						LEFT OUTER JOIN COMPOSE b ON a.id_recipe = b.id_recipe 
						LEFT OUTER JOIN COMPOSE c ON a.id_recipe = c.id_recipe
						join RECIPE r ON a.id_recipe = r.id_recipe
						WHERE  r.id_ambiance = :id_ambiance
						AND r.id_preparationTime= :id_preparationTime
						AND r.id_difficulty= :id_difficulty
						AND r.id_type= :id_type";
			$query_p = array(':id_ambiance' => $params['id_ambiance'], ':id_preparationTime' => $params['id_preparationTime'], ':id_difficulty' => $params['id_difficulty'], ':id_type' => $params['id_type']);

			//Si des ingrédients sont spécifiés on les rajoute à la requête
			if(isset($params['id_ingredient1'])){
				$query .=" AND a.id_ingredient = :id_ingredient1";
				$query_p[':id_ingredient1'] =  $params['id_ingredient1'];
			}	
			if(isset($params['id_ingredient2'])){
				$query .=" AND b.id_ingredient = :id_ingredient2";
				$query_p[':id_ingredient2'] =  $params['id_ingredient2'];
			}	
			if(isset($params['id_ingredient3'])){
				$query .=" AND c.id_ingredient = :id_ingredient3";
				$query_p[':id_ingredient3'] =  $params['id_ingredient3'];
			}			

			$result = $this->dB->exec($query, $query_p);

			//On récupère le résultat de la recherche 
			if(count($result) > 0 ){
				// Si il y a des valeurs on construit le filtre pour le mapper
				$filter = "id_recipe IN (";
				foreach ($result as $key => $value) {
					if($key == count($result) -1 )
						$filter .= $value['id_recipe'];
					else
						$filter .= $value['id_recipe'].",";			
				}
				$filter .= ")";
			} else { 
				//Sinon on met un filtre abérant pour ne pas avoir de résultat retourné -- TOFIX
				$filter = "1 = 2";
			}			
		} else if(isset($params['id_ambiance'])){
		//Sinon on tri seulement par ambiance
			$filter = array("id_ambiance = :id_ambiance", ':id_ambiance' => $params['id_ambiance']);
		} 

		if($params['filter'] == 'date'){
			$req = array('order'=>'dateAdd_recipe DESC');
		} else if($params['filter'] == 'votes'){
			$req = array('order'=>'votes_recipe DESC');
		}
		
		$fullrecipe_mapper = $this->getMapper('fullrecipe');
		return $fullrecipe_mapper->find($filter,array('order'=>'votes_recipe DESC'));	
	}

	function getFavoritesRecipesByUser($params){
		$favorite_mapper = $this->getMapper('favorite');
		return $favorite_mapper->find(array("id_user = :id", ':id' => $params['id']));
	}

	function getIsFavorite($params){
		$favorite_mapper = $this->getMapper('favorite');
		$favorite_mapper->load(array("id_user = :id_user AND id_recipe = :id_recipe", ':id_user' => $params['id_user'],  ':id_recipe' => $params['id']));
		return $favorite_mapper->dry();
	}

	function getAmbiances(){
		$ambiance_mapper = $this->getMapper('AMBIANCE');
		return $ambiance_mapper->find();
	}

	function getPreparationTimes(){
		$preparationTime_mapper = $this->getMapper('PREPARATIONTIME');
		return $preparationTime_mapper->find();
	}

	function getDifficulties(){
		$difficulty_mapper = $this->getMapper('DIFFICULTY');
		return $difficulty_mapper->find();
	}

	function getTypes(){
		$type_mapper = $this->getMapper('TYPE');
		return $type_mapper->find();
	}

	function getAmbiance($params){
		$adapt_mapper = $this->getMapper('adapt');
		return $adapt_mapper->load(array("id_recipe = :id", ':id' => $params['id']));
	}

	function getAuthor($params){
		$submit_mapper = $this->getMapper('SUBMIT');
		return $submit_mapper->load(array("id_recipe = :id", ':id' => $params['id']));
	}

	function getSteps($params){
		$step_mapper = $this->getMapper('STEP');
		return $step_mapper->find(array("id_recipe = :id", ':id' => $params['id']),array('order'=>'order_step'));
	}

	function getComments($params){
		$post_mapper = $this->getMapper('post');
		return $post_mapper->find(array("id_step = :id_step AND id_recipe = :id_recipe", ':id_step' => $params['id_step'], ':id_recipe' => $params['id_recipe']),array('order'=>'dateAdd_comment'));
	}

	function getVotes($params){
		$vote_mapper = $this->getMapper('VOTE');
		return $vote_mapper->find(array("id_recipe = :id", ':id' => $params['id']));
	}	

	function getIngredients($params){
		$associate_mapper = $this->getMapper('associate');
		return $associate_mapper->find(array("id_recipe = :id", ':id' => $params['id']));
	}

	function getAllIngredients(){
		$ingredients_mapper = $this->getMapper('INGREDIENT');
		return $ingredients_mapper->find();
	}	
}
?>