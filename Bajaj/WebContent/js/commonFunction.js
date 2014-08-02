$.fn.serializeObject=function(){
	var o={};
	var a=this.serializeArray();
	$.each(a, function(){
		if(o[this.name]!== undefined){
			if(!o[this.name].push){
				o[this.name]=[o[this.name]];
			}
			o[this.name].push(this.value||'');
		}
		else{
			o[this.name]=this.value||'';
		}
	});
	return o;
};	
	  
//jQuery($('#searchform input[type="text"]')).liveSearch({url: 'searchQuestion.do?query='});

var zip;
$(function(){
	$('#searchform input[type="text"]').autocomplete({
		minLength: 3,
		source: function (request, response) {
			zip=null;
            var dataString= $.ui.autocomplete.escapeRegex(request.term);
            
            dataString=JSON.stringify(dataString);
            $.ajax({
				url: "searchQuestion.do?query="+dataString,
				type: "get",
				dataType: "json",
				contentType: "application/json",
				data: null,
				async: true,
				cache: true,
				processData:false,
				success: function(data){
					$('#searchform input[type="text"]').removeClass("ui-autocomplete-loading");
					console.log(data);
			          response( $.grep( data, function( item ){
			              return item;
			          }) );
				},
            	error: function(data){
//            		console.clear();
            		console.log(data);
            		$('#searchform input[type="text"]').removeClass("ui-autocomplete-loading");
            	}
            })
		},
		focus: function( event, ui ) {
			$( '#searchform input[type="text"]' ).val( ui.item.city);
			zip= ui.item.zipCode;
			event.preventDefault();
		},
		select: function( event, ui ) {
			$( '#searchform input[type="text"]' ).val( ui.item.city);
			zip= ui.item.zipCode;
			event.preventDefault();
		}
	})
    .data( "ui-autocomplete" )._renderItem = function( ul, item ) 
    {
      return $( "<li>" )
        .append( "<a>"+item.question+"</a></li>" )
        .appendTo( ul );
    };
});
$('#searchform input[type="text"]').on('autocompletefocus',function(event, ui){
	$('#cityName').keyup(function(event){
		if(event.which==27){
			$( "#cityName" ).val(ui.item.city);
			zip= ui.item.zipCode;
			event.preventDefault();
		}
	});		
});
//Search using City name.
$('#searchform input[type="text"]').on( "autocompleteselect", function( event, ui ) {
	console.log(ui.item);
	if(ui.item.id == "none")
	{
		try
		{
			app.QuestionBaseView = new app.QuestionBaseView()
		}
		catch(e)
		{
//			console.log(e.stack);
		}
		app.QuestionBaseView.renderQADetail(ui.item);
	}
	
});

//search city submit action.
$('#searchform').submit(function(event){
	event.preventDefault();
	$('#searchByCity').attr('disabled', true);
	if(zip!=null&&zip!=''&&($('#cityName').val()!='')&&($('#cityName').val()!=null))
	{
		$('#cityNameSpan').empty();
		var place={
				zipCode: zip
				};
		var dataString={
				"key": $('#keyString').val(),
				"place": place
			};
		dataString={
			"required":"timezoneData",
			"data": dataString
		};
		dataString=JSON.stringify(dataString);
		getTimezoneData(dataString);
	}
	else
	{
		$('#cityNameSpan').html('please select place').css('color','red');
	}
	$('#searchByCity').attr('disabled', false);
});
if (!$('#timezone').hasClass('active')) 
{
		$('#timezone').addClass('active');
	}