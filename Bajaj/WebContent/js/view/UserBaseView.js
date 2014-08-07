var app		=	app	||	{};

(function($)
{	 app.UserBaseView= Backbone.View.extend({
		initialize		: function()
						{
							console.log("UserBaseView Initialize.");
						},
   		collection		: app.UserCollection,
   		el				: "#page-container",
   		events			: {
   								"click #addUser" : "addNewUser"
					   	},
   		render			: function()
   						{
   							console.log("UserBaseView rendered");
   							var _this=this;
   							var template=_.template($('#userTemplate').html(),{});
   							this.$el.html(template);
   							
   						},
		addNewUser	:	function(e)
						{
							console.log(e);
							try
							{
								app.UserFormView = new app.UserFormView();
							}
							catch(e)
							{
								app.UserFormView.render();
							}
						}
   		
   	});
})(jQuery);