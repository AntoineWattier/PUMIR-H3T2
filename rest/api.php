<?php

namespace REST;

abstract class api{

	protected $tpl;
	protected $dB;

	abstract function get($f3);
	abstract function post($f3);
	abstract function put($f3);
	abstract function delete($f3);

	function beforeroute($f3){
		$this->dB=new \DB\SQL('mysql:host='.$f3->get('db_host').';port=3306;dbname='.$f3->get('db_server'),$f3->get('db_login'),$f3->get('db_password'));

		$f3->set('ONERROR',function($f3){
			$this->tpl='json/users.json';
			echo \View::instance()->render($this->tpl,'application/json');
		});
	}

	function afterroute(){
		echo \View::instance()->render($this->tpl,'application/json');
	}

	protected function getMapper($table){
		return new \DB\SQL\Mapper($this->dB,$table);
	}
}