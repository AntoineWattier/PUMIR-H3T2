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
	$.getJSON($this.attr('href'))
	.success(function(data){
		console.log(data);
		if(data.status==false){
			$this.removeClass('on');
		}else{
			$this.addClass('on');
		}
	});
});