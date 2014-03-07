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
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>What the f*** do i eat tonight?</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="public/styles/main.css">
	</head>
	<body>
		<header id="header">
			<h1>wtfdiet</h1>
			<nav id="nav">
				<ul>
					<li class="active"><a href="">Conciergerie</a></li>
					<li><a href="">Recettes populaires</a></li>
					<li><a href="">Toutes les recettes</a></li>
				</ul>
			</nav>
			<nav id="sign-in">
				<ul>
					<li><a href="">Se connecter</a></li>
					<li><a class="btn" href="">Créer un compte</a></li>
				</ul>
			</nav>
		</header>
	
		<section id="main" class="create-recipe">
			<div class="wrapper">
				<a href="" class="cancel">« Annuler</a>
				<h1>Création de la recette</h1>
				<form>
					<div class="title">
						<input type="text" name="" placeholder="Titre de la recette" />
						<i class="edit"></i>
					</div>
					<section class="step step1">
						<h2>Les ingrédients</h2>
						<p>Ajoutez les ingrédients nécessaires à la préparation de votre recette, et précisez la quantité nécessaire.</p>
						<div class="ingredients suggest">
							<input type="text" name="ingredients" placeholder="Qu'y a-t-il dans votre frigo ?" />
							<i class="zoom"></i>
							<ul class="suggestions">
								<li><i class="checked sm"></i>Pommes</li>
								<li><i class="checked sm"></i>Pommes de terre</li>
							</ul>
						</div>
					</section>
				</form>
			</div>

		</section>
		<section id="popin" class="img">
			<i class="close purple">Close</i>
			<h2>Ajouter une image...</h2>
			<section class="crop">
				<div id="croppic"></div>
				<p>Définissez la région que vous voulez afficher dans votre recette</p>
				<button><i class="checked"></i> Ajouter à ma recette</button>
				<input type="hidden" id="input_return_file" name="image_recette" value="" />
			</section>
			<section class="select">
				<form>
				<?php if(isset($usermedia['data'])): ?>
					<?php foreach ($usermedia['data'] as $key => $media): ?>
					<label class="insta">
						<input type="radio" name="insta" />
						<div>
							<img src="<?= $media['images']['standard_resolution']['url'] ?>" width="120px" height="120px" alt="Repas léger">
							<span class="checked"></span>
						</div>
					</label>
					<?php endforeach ?>
				<?php else: ?>
					Aucune image trouvée sur instagram
				<?php endif; ?>
				</form>
				<div class="clear"></div>
				<button disabled><i class="checked"></i> Ajouter à ma recette</button>
			</section>
			<a href="https://instagram.com/oauth/authorize/?client_id=f3d6c2c63c504f6185ddd60be864464a&redirect_uri=http://wtfdiet.local/instagram.php&response_type=code" class="instagram">Depuis instagram</a>
			<label id="cropContainerHeaderButton">Changer la photo</label>


		</section>

		<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
		<script src="public/js/crop/croppic.js"></script>
		 <link href="public/js/crop/croppic.css" rel="stylesheet">
		   <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script>
		var croppicHeaderOptions = {
				uploadUrl:'img_save_to_file.php',
				cropData:{
					"dummyData":1,
					"dummyData2":"asdas"
				},
				cropUrl:'img_crop_to_file.php',
				customUploadButtonId:'cropContainerHeaderButton',
				outputUrlId: 'input_return_file',
				onBeforeImgUpload: function(){ 
 					if($('.crop').css('display') == 'none'){
						 	$('.crop').css('display', 'block');
						 	$('.select').css('display', 'none');
						}
				 },
				onAfterImgUpload: function(){ console.log('onAfterImgUpload') },
				onImgDrag: function(){ console.log('onImgDrag') },
				onImgZoom: function(){ console.log('onImgZoom') },
				onBeforeImgCrop: function(){ console.log('onBeforeImgCrop') },
				onAfterImgCrop:function(){ console.log('onAfterImgCrop') }
		}	
		var croppic = new Croppic('croppic', croppicHeaderOptions);

			$('form').on('click', 'input[name=insta]', function(e){
				var $this =$(this);
				console.log('true');
				$('.select button').removeAttr('disabled');
			});

		</script>
	</body>
</html>