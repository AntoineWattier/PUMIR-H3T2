<?php 

class RecipeController extends Controller{

	public function __construct(){
		parent::__construct();
	}

	function submit($f3){

		switch ($f3->get('VERB')) {
			case 'POST':
				$params = $f3->get('POST');
				$params['id_user'] = $f3->get('SESSION.id_user');
				$recipe = $this->model->submit($params);

				//Si l'enregistrement a réussi on redirige l'user vers sa recette
				if($recipe){						
					$f3->reroute('/recipe/getRecipe/'.$recipe->id_recipe);
				} 
				break;
			
			case 'GET':
				// if(isset($_GET['e']) && isset($_GET['id']) && $_GET['id'] == $f3->get('SESSION.id_user')){
				// 	$f3->set('recipe',$this->model->getRecipe(array('id'=>$_GET['e'])));
				// }
				if(!$f3->get('SESSION.id_user'))
					$f3->reroute('/user/register');
				echo View::instance()->render('Recipe/submitRecipe.html');
		}
		
	}

	function getRecipe($f3){
		$f3->set('recipe',$this->model->getRecipe($f3->get('PARAMS')));
		$f3->set('steps',$this->model->getRecipeSteps($f3->get('PARAMS')));
		echo View::instance()->render('Recipe/viewRecipe.html');
	}

	function getRecipes($f3){
		$f3->set('recipes',$this->model->getRecipes($f3->get('PARAMS')));
		echo View::instance()->render('Recipe/viewRecipes.html');
	}

	function getRecipesByUser($f3){
		$f3->set('recipes',$this->model->getRecipesByUser($f3->get('PARAMS')));
	}

	function getRecipesByFilter($f3){
		$f3->set('recipes',$this->model->getRecipesByFilter($f3->get('PARAMS')));
		echo View::instance()->render('Recipe/viewRecipes.html');
	}	
}