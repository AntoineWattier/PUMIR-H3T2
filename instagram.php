<?php

require_once 'App/Helpers/Instagram.php';

/**
 * Configuration params, make sure to write exactly the ones
 * instagram provide you at http://instagr.am/developer/
 */
$config = array(
        'client_id' => 'f3d6c2c63c504f6185ddd60be864464a',
        'client_secret' => 'fc210aa17c2a47f2b4e05fb7dd751fa0',
        'grant_type' => 'authorization_code',
        'redirect_uri' => 'http://wtfdiet.local/instagram.php',
     );

// Instantiate the API handler object
$instagram = new Instagram($config);
$accessToken = $instagram->getAccessToken();

$instagram->setAccessToken($accessToken);
$userid = $instagram->getCurrentUser()->id;
$usermedia = $instagram->getUserFeed();

// After getting the response, let's iterate the payload
$usermedia = json_decode($usermedia, true);

// var_dump($usermedia['data'][0]['images']["standard_resolution"]['url']);
?>

<html>
<?php foreach ($usermedia['data'] as $key => $media): ?>
	<img src="<?= $media['images']['thumbnail']['url'] ?>" /><br>
<?php endforeach ?>

<a href="https://instagram.com/oauth/authorize/?client_id=f3d6c2c63c504f6185ddd60be864464a&redirect_uri=http://wtfdiet.local/instagram.php&response_type=code">Instagram</a>