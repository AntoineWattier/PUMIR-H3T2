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