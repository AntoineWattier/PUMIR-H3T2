$('button[name="login"]').on('click',function(e){
	e.preventDefault();

	var $form = $(this).parent('form');
	$.ajax({
		dataType: "json",
		url:$form.attr('action'),
		method:$form.attr('method'),
		data:$form.serialize()
	})
	.success(function(data){
		if(data.status){
			// $('#form span').html("success");
			window.location = "/";
		} else {
			// $('#form span').html("error");
		}
	})
});

function checkMail(input) {
	$.ajax({
			url:'user/checkMail',
			method:'POST',
			data:{ 'mail_user' : input.value }
	})
	.success(function(data){
			if(data.status) {
				input.setCustomValidity('This mail already exists');
			} else {
				input.setCustomValidity('');
			}
	})	
}

$('a.like').on('click',function(e){
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
		});
	} else {
		$comment.remove();
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

$('.steps').on('click','ul.comments li:last',function(e) {
	e.preventDefault();
	
	var $this=$(this);
	$this.parent().remove();
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