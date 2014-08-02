var app		=	app	||	{};

(function($)
{
	app.QuestionDetailView = Backbone.View.extend({
	initialize			:	function()
							{
								
							}
	,el					:	"#QAModal"
	,events				:	{
								"click #EditQA"			:	"editQA"
							}
	,render				:	function()
							{
								console.log("Question Detail View Rendered");
								var _this = this;
								var template=_.template($('#questionDetailTemplate').html(),{model : _this.model});
								this.$el.html(template);
								$('#QADeatailModal').modal('show');
							}
	,editQA				:	function(e)
							{
								console.log(e);
							}
	
});
})(jQuery);