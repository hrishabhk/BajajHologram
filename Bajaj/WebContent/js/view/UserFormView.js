var app		=	app	||	{};

(function($)
{	 app.UserFormView= Backbone.View.extend({
		initialize		: function()
						{
							console.log("UserFormView Initialize.");
							this.render();
						},
   		model			: new app.UserModel(),
   		el				: "#userInfo",
   		events			: 
   						{
					   		"submit #user-form"		:	"saveUser"
   						},
   		render			: function()
   						{
   							console.log("UserFormView rendered");
   							var _this=this;
   							var template=_.template($('#userFormTemplate').html(),{});
   							console.log("template")
   							this.$el.html(template);
   							
   						},
		saveUser		: function(e)
						{
							console.log(e);
							e.preventDefault();
							$.ajax({
								url				:	"saveUser.do",
								type			:	"post",
								dataType		:	"json",
								contentType		:	"application/json",
								data			:	JSON.stringify($("#user-form").serializeObject()),
								success			:	function(data)
													{
														console.log(data);
													}
							});
						}
   	});
})(jQuery);