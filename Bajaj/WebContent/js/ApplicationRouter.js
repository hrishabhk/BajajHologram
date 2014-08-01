var app		=	app	||	{};

(function($)
{
	app.ApplicationRouter = Backbone.Router.extend({
			initialize: function(){
				
			},
		    routes: {
		        ""			: "home",
		    },
		    home: function()
		    {
		    	try
		    	{
		    		app.QuestionView = new app.QuestionView();
		    		app.QuestionView.render();
		    	}
		    	catch(e)
		    	{
		    		app.QuestionView.render();
		    	}
		    	$('#inbox-table').dataTable();
		   }
		});
})(jQuery);

app.ApplicationRouter = new app.ApplicationRouter();
Backbone.history.start({pushState: false});