var app		=	app	||	{};

(function($)
{
	app.AdminRouter = Backbone.Router.extend({
		initialize			: function()
								{
									app.UserCollection = new app.UserCollection();
								},
		routes				: {
								""			: "admin",
		    				 },
		admin				: function(e)
							  {
			app.UserBaseView = new app.UserBaseView();
									try
									{
										app.UserBaseView = new app.UserBaseView();
									}
									catch(e)
									{
										console.log(app.UserBaseView);
									}
									app.UserBaseView.render();
							   }
		});
})(jQuery);

app.AdminRouter = new app.AdminRouter();
Backbone.history.start({pushState: false});