var app		=	app	||	{};

(function($)
{
	app.QuestionView = Backbone.View.extend({
	initialize			:	function()
							{
			
							}
	,collection			:	null
	,el					:	"#questionContainer"
	,events				:	{
								"click .expand_listBtn"			:	"toggleAnswer"
							}
	,render				:	function(){
								console.log("Question View Rendered");
								var _this = this;
								var template=_.template($('#question-template').html(),{});
								this.$el.html(template);
							}
	,toggleAnswer		:	function(e)
							{
								$("#answer_"+e.currentTarget.id).toggle();
							}
});
})(jQuery);