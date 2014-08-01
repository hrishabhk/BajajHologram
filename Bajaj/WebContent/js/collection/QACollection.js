var app		=	app	||	{};

(function($)
{
	app.QACollection = Backbone.Collection.extend({
		url			:	"questionAnswer",
		model		:	app.QAModel
	});
});