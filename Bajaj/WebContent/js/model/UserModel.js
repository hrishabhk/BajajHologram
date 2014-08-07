var app		=	app	||	{};

(function($)
{
	app.UserModel = Backbone.Model.extend({
		urlRoot			:	"user.do",
		defaults		:	{
								firstName	: "",
								lastName	: "",
								userId		: "",
								password	: "",
								userType	: "",
							},
		isFetched		:	false,
	});
})(jQuery);

