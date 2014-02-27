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
			console.log(data);
			if(data.status==false){
				$this.removeClass('liked');
			}else{
				$this.addClass('liked');
			}
		});
	}
});

$('a.follow').on('click',function(e){
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
			console.log(data);
			if(data.status==false){
				$this.removeClass('liked');
			}else{
				$this.addClass('liked');
			}
		});
	}
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

$('a.fb').on('click', function(e){
	e.preventDefault();

	FB.login(function(response) {
		if (response.authResponse) {
			FB.api("/me/picture?width=160&height=160",  function(r) {
				var profileImage = r.data.url.split('https://')[1];//remove https to avoid any cert issues
			});
			console.log(profileImage);		
			FB.api('/me', function(response) {

				console.log(response);
				// $.ajax({
				// 	dataType: "json",
				// 	url:'/user/FBConnect',
				// 	method:'POST',
				// 	data: { 'firstname_user' : response.first_name,
				// 		'lastname_user' : response.last_name,
				// 		'mail_user': response.email,
				// 		'facebookId_user': response.id
				// 		'urlImage_user':response.
				// 	}
				// })
				// .success(function(data){
				// 	window.location = "/";
				// });
			});
		} else {
			console.log('cancelled');
		}
	},{scope: 'email'});  
});
/* End Facebook Connect */