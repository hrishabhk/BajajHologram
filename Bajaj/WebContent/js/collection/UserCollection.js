var app		=	app	||	{};

(function($)
{
	app.UserCollection = Backbone.Collection.extend({
		url			: "user.do",
		model		: app.UserModel
	});
})(jQuery);

