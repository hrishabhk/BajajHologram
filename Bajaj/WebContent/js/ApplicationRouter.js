var app		=	app	||	{};

(function($)
{
	app.ApplicationRouter = Backbone.Router.extend({
		initialize			: function()
								{
									app.QACollection = new app.QACollection();
								},
		routes				: {
								""			: "home",
		    				 },
		home				: function(e)
							  {
									if(loginModule == null)
									{
								    	try
								    	{
								    		app.QuestionBaseView = new app.QuestionBaseView();
								    		
								    	}
								    	catch(e)
								    	{
								    		console.log(e.stack);
								    		app.QuestionBaseView.render();
								    	}
									}
									else
									{
										$('#signInModal').modal({
											 backdrop: 'static',
											 keyboard: false 
										});
									}
							   }
		});
})(jQuery);

app.ApplicationRouter = new app.ApplicationRouter();
Backbone.history.start({pushState: false});

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
			$( '#searchform input[type="text"]' ).val( ui.item.question);
			
		},
		select: function( event, ui ) {
			$( '#searchform input[type="text"]' ).val( ui.item.question);
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
	if(ui.item.id != "none")
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
});