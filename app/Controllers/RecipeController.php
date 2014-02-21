<?php 

class RecipeController extends Controller{

	public function __construct(){
		parent::__construct();
	}
	
	function conciergerie($f3){
		$f3->set('ambiances',$this->model->getAmbiances());
		echo View::instance()->render('conciergerie.html');
	}

	function submitRecipe($f3){
		if(!$f3->exists('SESSION.id_user'))
			$f3->reroute('/user/register?e');
		switch ($f3->get('VERB')) {
			case 'POST':
				$params = $f3->get('POST');
				$params['id_user'] = $f3->get('SESSION.id_user');
				$recipe = $this->model->submitRecipe($params);

				//Si l'enregistrement a réussi on redirige l'user vers sa recette
				if($recipe){						
					$f3->reroute('/recipe/getRecipe/'.$recipe->id_recipe);
				} 
				break;
			
			case 'GET':

				$f3->set('ambiances',$this->model->getAmbiances());
				$f3->set('ingredients',$this->model->getAllIngredients());
				echo View::instance()->render('Recipe/submitRecipe.html');
		}
		
	}

	function getRecipe($f3){
		$f3->set('recipe',$this->model->getRecipe($f3->get('PARAMS')));
		$f3->set('steps',$this->model->getSteps($f3->get('PARAMS')));
		$f3->set('ingredients',$this->model->getIngredients($f3->get('PARAMS')));
		$f3->set('ambiance',$this->model->getAmbiance($f3->get('PARAMS')));
		$f3->set('author',$this->model->getAuthor($f3->get('PARAMS')));

		$f3->set('PARAMS.id_user', $f3->get('SESSION.id_user'));
		$f3->set('isFavorite',$this->model->getIsFavorite($f3->get('PARAMS')));
		echo View::instance()->render('Recipe/viewRecipe.html');
	}

	function editRecipe($f3){
		$f3->set('recipe',$this->model->getRecipe($f3->get('PARAMS')));
		$f3->set('steps',$this->model->getSteps($f3->get('PARAMS')));
		$f3->set('ingredients',$this->model->getIngredients($f3->get('PARAMS')));
		$f3->set('ambiance',$this->model->getAmbiance($f3->get('PARAMS')));
		$f3->set('author',$this->model->getAuthor($f3->get('PARAMS')));

		$f3->set('PARAMS.id_user', $f3->get('SESSION.id_user'));
		$f3->set('isFavorite',$this->model->getIsFavorite($f3->get('PARAMS')));
		echo View::instance()->render('Recipe/editRecipe.html');
	}
	function getRecipes($f3){
		$f3->set('recipes',$this->model->getRecipes($f3->get('PARAMS')));
		echo View::instance()->render('Recipe/viewRecipes.html');
	}

	// private function _getRecipesByUser($f3){
	// 	$f3->set('recipes',$this->model->getRecipesByUser($f3->get('PARAMS')));
	// }

	function getRecipesByFilter($f3){
		var_dump($f3->get('PARAMS'));
		$f3->set('recipes',$this->model->getRecipesByFilter($f3->get('PARAMS')));
		echo View::instance()->render('Recipe/viewRecipes.html');
	}	
}