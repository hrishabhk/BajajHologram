var app		=	app	||	{};

(function($)
{
	app.QuestionListView = Backbone.View.extend({
	initialize			:	function()
							{
								var _this = this;
								this.collection = app.QACollection;
								this.collection.fetch({data: $.param({ index: 0 }) ,cache: false,
									success : function(data)
											{
												console.log(data);
												_this.render();
												if(data.length == 10)
												{
													_this.hasMoreQA = true;
													_this.index = 10;
													$('#qustion-table_next').removeClass('disabled');
												}
												else
												{
													_this.hasMoreQA = false;
												}
											}
								});
								this.collection.on("add", this.render(), this);
								this.collection.on("remove", this.render(), this);
							}
	,collection			:	null
	,el					:	"#questionList"
	,events				:	{
								"click .expand_listBtn"			:	"toggleAnswer",
								"click #qustion-table_next"		:	"nextQAData"	
							}
	,render				:	function()
							{
								console.log("Question List View Rendered");
								var _this = this;
								var template=_.template($('#questionListTemplate').html(),{QACollection : _this.collection});
								this.$el.html(template);
								$('#qustion-table').dataTable({
								});
							}
	,nextQAData			:	function(e)
							{
								var _this = this;
								if(this.hasMoreQA)
								{
									$.ajax({
										url 		: "questionAnswer.do?index="+this.index,
										type		: "get",
										dataType	: "json",
										contentType: "application/json",
										success		: function(data)
													 {
														console.log(data);
														_this.collection.add(data);
														_this.render();
														window.abc = data;
														if(data.length == 10)
														{
															_this.hasMoreQA = true;
															_this.index += 10;
															$('#qustion-table_next').removeClass('disabled');
														}
														else
														{
															_this.hasMoreQA = false;
														}
													 }
									})
								}
							}
	
});
})(jQuery);