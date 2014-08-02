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
									console.log()
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
		});
})(jQuery);

app.ApplicationRouter = new app.ApplicationRouter();
Backbone.history.start({pushState: false});