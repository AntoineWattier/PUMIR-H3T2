$('input[name="login"]').on('click',function(e){
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
			$('#form span').html("success");
			window.location = "/";
		} else {
			$('#form span').html("error");
		}
	})
});

$('a.like').on('click',function(e){
	e.preventDefault();
	var $this=$(this);
	$.ajax({
		dataType: "json",
		url:$this.attr('href'),
		method:'POST'
	})
	.success(function(data){
		console.log(data);
		if(data.status==false){
			$this.removeClass('on');
		}else{
			$this.addClass('on');
		}
	});
});

$('input[name="comment"]').on('click',function(e){
	e.preventDefault();
	
	var $this=$(this);
	var $form=$this.parent('form');
	if($('input[name="content_comment"]').val() != ''){
		$.ajax({
			dataType: "json",
			url:$form.attr('action'),
			method:'POST',
			data: { 'content_comment' : $('input[name="content_comment"]').val() }
		})
		.success(function(data){
			 console.log(data);
			// if(data.status==false){
			// 	$this.removeClass('on');
			// }else{
			// 	$this.addClass('on');
			// }
		});
	}
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

function fb_login(){
	FB.login(function(response) {
		if (response.authResponse) {
			FB.api('/me', function(response) {
				console.log(response);
				$.ajax({
					dataType: "json",
					url:'/user/FBConnect',
					method:'POST',
					data: { 'firstname_user' : response.first_name,
						'lastname_user' : response.last_name,
						'mail_user': response.email,
						'facebookId_user': response.id
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
}
/* End Facebook Connect */