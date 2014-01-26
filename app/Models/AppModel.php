<?php

class AppModel{

	protected $db;

	function __construct(){
		$db = new \DB\SQL("mysql:host=localhost;port=3306;dbname=WTFDIET", 'root', '');
		$this->db = $db;
	}
}