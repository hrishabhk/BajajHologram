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
								"/admin"	: "admin"
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
	,admin					: function(e)
							{
								console.log(e);
							}
							   
		
		    				 
		});
})(jQuery);

app.ApplicationRouter = new app.ApplicationRouter();
Backbone.history.start({pushState: false});