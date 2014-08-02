var app		=	app	||	{};

(function($)
{
	app.QuestionListView = Backbone.View.extend({
	initialize			:	function()
							{
								var _this = this;
								this.collection = app.QACollection;
								console.log(this.collection);
								this.collection.fetch({
									success : function(data)
											{
												_this.render();
											}
								});
								this.collection.on("add", this.render(), this);
								this.collection.on("remove", this.render(), this);
							}
	,collection			:	null
	,el					:	"#questionList"
	,events				:	{
								"click .expand_listBtn"			:	"toggleAnswer"
							}
	,render				:	function()
							{
								console.log("Question List View Rendered");
								var _this = this;
								var template=_.template($('#questionListTemplate').html(),{QACollection : _this.collection});
								this.$el.html(template);
								$('#inbox-table').dataTable();
							}
	
});
})(jQuery);