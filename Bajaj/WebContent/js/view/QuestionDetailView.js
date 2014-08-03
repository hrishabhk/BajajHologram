var app		=	app	||	{};

(function($)
{
	app.QuestionDetailView = Backbone.View.extend({
	initialize			:	function()
							{
								
							}
	,el					:	"#QAModal"
	,events				:	{
								"click #EditQA"			:	"editQA",
								"click #saveQA"		:	"saveQA"
							}
	,render				:	function()
							{
								console.log("Question Detail View Rendered");
								var _this = this;
								var template=_.template($('#questionDetailTemplate').html(),{model : _this.model});
								this.$el.html(template);
								$('#QADeatailModal').modal('show');
							}
	,editQA				:	function()
							{
								var _this = this;
								var template=_.template($('#questionEditTemplate').html(),{model : _this.model});
								this.$el.html(template);
								$('#QADeatailModal').modal('show');
							}
	,saveQA				:	function(e)
							{
								e.preventDefault();
								var _this = this;
								var model = new app.QAModel();
								model.set({
									question	: $('#question').val().trim(),
									answer		: $('#answer').val().trim(),
									frequent	: $('#qFrequency').val().trim(),
									category	: ""
								});
								if($('#qId').val().trim() !="")
								{
									model.set({id : $('#qId').val().trim()});
									$.ajax({
										url 		: "questionAnswer.do/update.do",
										type		: "post",
										data		: JSON.stringify(model.toJSON()),
										dataType	: "json",
										contentType: "application/json",
										success		: function(data)
													 {
														console.log(data);
													 }
									});
								}
								else
								{
									model.save({},{
										success : function(data)
												{
													console.log(data);
													if(data.get('frequent') == "1")
													{
														app.QuestionListView.collection.add(data);
													}
												}
									})
								}
								
							}
	
});
})(jQuery);