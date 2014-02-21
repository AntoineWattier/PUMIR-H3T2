<?php
// require_once('app/Helpers/tools.php');

class Controller{
	protected $model;

	protected function __construct(){

		$modelName=substr(get_class($this),0,strpos(get_class($this),'C')).'Model';
		
		if(class_exists($modelName)){
			$this->model=new $modelName();
		} 
	}
}