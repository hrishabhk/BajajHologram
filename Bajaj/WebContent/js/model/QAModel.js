var app		=	app	||	{};

(function($)
{
	app.QAModel = Backbone.Model.extend({
		urlRoot			:	"questionAnswer.do",
		defaults		:	{
	     	   					question	: "",
	     	   					answer		: "",
	     	   					key			: "",
	     	   					frequent	: 0,
							},
		isFetched		:	false,
	});
})(jQuery);
