var app		=	app	||	{};

(function($)
{	 app.UserListView	=	Backbone.View.extend({
		collection		:	app.userCollection,
		el				:	'#userListContainer',
		events			:	{
								'click .delete-user': 'deleteUser',
								'click .show-user': 'showUser'
							},
		initialize		:	function()
							{
								var _this = this;
								try
								{
									app.UserCollection = new app.UserCollection();
								}
								catch(e)
								{}
								app.UserCollection.fetch({
										success :	function(data)
												 	{
														console.log(data);
														_this.render();
												 	}
								});
								app.UserCollection.on('add', this.render, this);
								app.UserCollection.on('remove', this.render, this);
							},
		render			:	function()
							{
								var that=this;
								var template=_.template($('#user-list-template').html(),{userList: app.UserCollection.models});
								this.$el.html(template);
							},
		deleteUser		:	function(ev)
							{
								ev.preventDefault();
								var modelID=ev.currentTarget.id;
								var user=app.UserCollection.get(modelID);
								if(user!==undefined)
								{
									user.destroy({success: function(data)
									 {
						   				console.log(data);
						   				app.UserCollection.remove(user);
						   			 }
						   			});
								}
								else
								{
									app.UserCollection.remove(user);
								}
								
							},
		showUser		:	function(ev)
							{
								ev.preventDefault();
								var id=ev.currentTarget.id;
								var user=app.UserCollection.get(id);
								try
								{
									app.UserFormView = new app.UserFormView({model : user})
								}
								catch(e)
								{
									app.UserFormView.model=user;
									console.log("app.UserFormView is already initialized")
								}
								app.UserFormView.render();
								console.log(user.get('docsList'));
							}
   	});
})(jQuery);