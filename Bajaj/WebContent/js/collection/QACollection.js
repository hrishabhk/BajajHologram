var app		=	app	||	{};

(function($)
{
	app.QACollection = Backbone.Collection.extend({
		url			:	"questionAnswer.do",
		model		:	app.QAModel
	});
})(jQuery);