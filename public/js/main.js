$( document ).ready(function(){
	
$('form[name="login"]').submit(function(e){
	e.preventDefault();
	var $form = $(this),
		$error = '';
	if(!$form.find('input[type="email"]').val()) {
		$form.find('input[type="email"]').focus();
		$error += "L'email est vide. ";
	}
	if(!$form.find('input[name="password_user"]').val()) {
		if(!$error) $form.find('input[name="password_user"]').focus();
		$error += "Le mot de passe est vide.";
	}
	if(!$error) {

		$.ajax({
			dataType: "json",
			url:$form.attr('action'),
			method:$form.attr('method'),
			data:$form.serialize()
		})
		.success(function(data){
			if(data.status){
				window.location = "/";
			} else {
				showError('L\'email ou le mot de passe est incorrect.');
				$form.find('input[type="email"]').focus();
			}
		});
	} else {
		showError($error);
		return false;
	}
	return false;
});



$('form[name="register"]').submit( function(e) {
	e.preventDefault();
	var $form = $(this),
		$error = '';
	if(!$form.find('input[name="firstname_user"]').val()) {
		$error += "Le prénom est obligatoire. ";
		$form.find('input[name="firstname_user"]').focus();
	}
	if(!$form.find('input[name="lastname_user"]').val()) {
		if(!$error) $form.find('input[name="lastname_user"]').focus();
		$error += "Le nom est obligatoire. ";
	}
	if(!$form.find('input[type="email"]').val()) {
		if(!$error) $form.find('input[type="email"]').focus();
		$error += "L'email est obligatoire. ";
	}
	if($form.find('input[type="email"]').val() && validMail($form.find('input[type="email"]').val())) {
		if(!$error) $form.find('input[type="email"]').focus();
		$error += "L'email est invalide. ";
	}
	else if (!checkMail($form.find('input[type="email"]'))) {
			if(!$error) $form.find('input[type="email"]').focus();
			$error += "L'email existe déjà. ";
	}
	if(!$form.find('input[name="password_user"]').val()) {
		if(!$error) $form.find('input[name="password_user"]').focus();
		$error += "Le mot de passe est obligatoire.";
	}
	if(!$error) {
		$.ajax({
			dataType: "json",
			url:$form.attr('action'),
			method:$form.attr('method'),
			data:$form.serialize()
		})
		.success(function(data){
			if(data.status){
				window.location = "/";
			} else {
				showError('Une erreur est survenue.');
			}
		});
	} else {
		showError($error);
		return false;
	}
	return false;
});



$('a.advanced-search').on('click', function(e){
	e.preventDefault();
	$('section.advanced-search').slideToggle();
});


$('input[name="id_preparationTime"],input[name="id_difficulty"],input[name="id_type"]').on('click',getRecipes);
$('select[name="id_ambiance"]').on('change',getRecipes);



function getRecipes(e){
	var $this = $(this);

	var str = "/recipe/getRecipesByFilter/vote/"
	+$('select[name="id_ambiance"] option:checked').val()
	+'/'+$('input[name="id_preparationTime"]:checked').val()
	+'/'+$('input[name="id_difficulty"]:checked').val()
	+'/'+$('input[name="id_type"]:checked').val();

	if( $('input[name="ingredients"]').val() != '' ){
		var parseVal = JSON.parse( $('input[name="ingredients"]').val() );

		for (var i = 0; i < parseVal.length; i++) {
			str = str+"/"+parseVal[i].value;
		}
	}
	$.ajax({
		dataType: "html",
		url:str,
		method:'POST'
	})
	.success(function(data){
		$('.recipes article, .no-result').remove();
		$('.recipes').append(data);
	});
}





$('.recipes, .recipe').on('click','a.like',function(e){
	e.preventDefault();
	var $this=$(this);
	if($this.attr('href') == '/user/register'){
		window.location = $this.attr('href');
	} else {
		$.ajax({
			dataType: "json",
			url:$this.attr('href'),
			method:'POST'
		})
		.success(function(data){
			$count = parseInt($this.children('span').html());
			if(data.status==false){
				$this.removeClass('liked');
				$this.children('span').html($count - 1);
			}else{
				$this.addClass('liked');
				$this.children('span').html($count + 1);
			}
		});
	}
});

$('button.follow').on('click',function(e){
	e.preventDefault();
	var $this=$(this);
	if($this.attr('href') == '/user/register'){
		window.location = $this.attr('href');
	} else {
		$.ajax({
			dataType: "json",
			url:$this.attr('href'),
			method:'POST'
		})
		.success(function(data){
			$span = $this.siblings('ul').children('li:last').children('a').children('span');
			$count = parseInt($span.html());
			if(data.status==false){
				$span.html($count - 1);
				$this.children('.msg').html('Suivre');
			}else{
				$span.html($count + 1);
				$this.children('.msg').html('Ne plus suivrer');
			}
		});
	}
});

$('div.step a').on('click', function(e){
	e.preventDefault();

	var $this = $(this);
	var $comment = $this.parent().siblings('.comments');
	if($comment.length == 0){
		$.ajax({
			dataType: "html",
			url:$this.attr('href'),
			method:'POST'
		})
		.success(function(data){
			$this.parent().parent().append(data);
			$('.comments').delay(200).slideDown();
		});
	} else {
		$comment.slideUp('400', function(){
			$(this).remove();
		});
	}
});

$('.steps').on('submit','.comments form',function(e){
	e.preventDefault();
	
	var $this=$(this);
	var $content = $this.children('input[name="content_comment"]');

	if($content.val() != ''){
		$.ajax({
			dataType: "json",
			url:$this.attr('action'),
			method:'POST',
			data: { 'content_comment' : $content.val() }
		})
		.success(function(data){
			console.log(data);
			if(data.status==false){
				console.log('ERROR');
			} else {
				$content.val('');
				$comment = $this.parent().parent();
				$li = $comment.parent();
				$a= $comment.parent().children('.step').children('a');

				$comment.remove();

				$.ajax({
					dataType: "html",
					url:$a.attr('href'),
					method:'POST'
				})
				.success(function(data){
					$li.append(data);
					$a.removeClass('no-comment');
					$count = parseInt($a.children('span').html());
					if(isNaN($count))
						$a.children('span').html(' 1');
					else 
						$a.children('span').html(' '+($count + 1));
				});
			}
		});
	}
});

$('.steps').on('click','.comments li:last-of-type',function(e){
	$(this).parent().slideUp('400', function(){
		$(this).remove();
	});
});

/* Facebook Connect */
window.fbAsyncInit = function() {
	FB.init({
		appId: '638197152884786',
		cookie: true,
		xfbml: true,
		oauth: true
	});
};

(function() {
	var e = document.createElement('script'); e.async = true;
	e.src = document.location.protocol +
		'//connect.facebook.net/en_US/all.js';
	document.getElementById('fb-root').appendChild(e);
}());

$('a.fb').on('click', function(e){
	e.preventDefault();
	
	FB.login(function(response) {
		if (response.authResponse) {	
			FB.api('/me', function(response) {

				console.log('https://graph.facebook.com/'+response.id+'/picture?type=large');
				$.ajax({
					dataType: "json",
					url:'/user/FBConnect',
					method:'POST',
					data: { 'firstname_user' : response.first_name,
						'lastname_user' : response.last_name,
						'mail_user': response.email,
						'facebookId_user': response.id,
						'urlImage_user': 'https://graph.facebook.com/'+response.id+'/picture?type=large'
					}
				})
				.success(function(data){
					window.location = "/";
				});
			});
		} else {
			console.log('cancelled');
		}
	},{scope: 'email'});  
});
/* End Facebook Connect */

});