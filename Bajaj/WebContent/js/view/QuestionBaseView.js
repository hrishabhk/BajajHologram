var app		=	app	||	{};

(function($)
{
	app.QuestionBaseView = Backbone.View.extend({
	initialize			:	function()
							{
								console.log("Question View Inialized");
								this.render();
							}
	,collection			:	null
	,el					:	"#questionContainer"
	,events				:	{
								"click .expand_listBtn"			:	"toggleAnswer",
								'click #add-new-question-btn'	:	"newQuestion"
							}
	,render				:	function(){
								console.log("Question View Rendered");
								var template=_.template($('#question-template').html(),{});
								this.$el.html(template);
								this.renderQAList();
							}
	,renderQAList		:	function()
							{
								try
								{
									app.QuestionListView = new app.QuestionListView();
								}
								catch(e)
								{
									console.log(e);
									app.QuestionListView.render();
								}
								
							}
	,renderQADetail		:	function(model)
							{
								try
								{
									app.QuestionDetailView = new app.QuestionDetailView({model : new app.QAModel(model)});
								}
								catch(e)
								{
									app.QuestionDetailView.model = new app.QAModel(model);
								}
								console.log(app.QuestionDetailView.model);
								app.QuestionDetailView.render();
								
							}
	,newQuestion		:	function(e)
							{
								console.log(e);
								try
								{
									app.QuestionDetailView = new app.QuestionDetailView({model : new app.QAModel()});
								}
								catch(e)
								{
									app.QuestionDetailView.model = new app.QAModel();
								}
								app.QuestionDetailView.editQA()
							}
	,toggleAnswer		:	function(e)
							{
								$("#answer_"+e.currentTarget.id).toggle();
							}
});
})(jQuery);