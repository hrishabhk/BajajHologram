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
   							try
							{
								app.UserListView = new app.UserListView();
							}
							catch(e)
							{
								
							}
							app.UserListView.render();
   						},
		addNewUser	:	function(e)
						{
							console.log(e);
							try
							{
								app.UserFormView = new app.UserFormView({model : new app.UserModel()});
							}
							catch(e)
							{
								app.UserFormView.model = new app.UserModel();
								app.UserFormView.render();
							}
						}
   		
   	});
})(jQuery);