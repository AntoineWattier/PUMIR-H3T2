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
					$f3->reroute('/recipe/getRecipe/'.$recipe);
				} 
				break;
			
			case 'GET':

				echo View::instance()->render('recipe.html');
		}
		
	}

	function getRecipe($f3){
		$f3->set('recipe',$this->model->getRecipe($f3->get('PARAMS')));
		echo View::instance()->render('viewrecipe.html');
	}

	function getRecipes($f3){
		$f3->set('recipes',$this->model->getRecipes($f3->get('PARAMS')));
		echo View::instance()->render('viewrecipes.html');
	}	
}