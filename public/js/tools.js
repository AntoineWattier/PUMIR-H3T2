function validMail(email) {
	var reg = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return reg.test($('input[type="email"]'));
}


function showError($message) {
	if($(".error"))
		$(".error").remove();
	$('section#main, section#login').before('<div class="error">'+$message+'<i class="close xl">Close</i></div>');
	$('.error').slideDown().delay('3000').slideUp();
}
function checkMail(input) {
	var datas = { 'mail_user' : input.val() };
	var success = false;
	if($('input[name="id_user"]').length != 0){
		datas.id_user = $('input[name="id_user"]').val();
	}
	
	$.ajax({
		url:'user/checkMail',
		method:'POST',
		async : false,
		data: datas
	})
	.success(function(data){
			if (data.status) {
				success = true;
			}
	});
	return success;
}


function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();

		reader.onload = function (e){ 
				$('form img').attr('src', e.target.result);
		};

		reader.readAsDataURL(input.files[0]);
	}
}