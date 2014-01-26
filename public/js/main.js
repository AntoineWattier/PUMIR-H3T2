$('#login').on('click',function(e){
	e.preventDefault();

	var $form = $(this).parent('form');
	$.ajax({
		url:$form.attr('action'),
		method:$form.attr('method'),
		data:$form.serialize()
	})
	.success(function(data){
		if(data){
			$('#form span').html("success");
			window.location.reload();
		} else {
			$('#form span').html("error");
		}
	})
});