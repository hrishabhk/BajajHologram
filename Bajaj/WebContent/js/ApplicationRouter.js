var app		=	app	||	{};

(function($)
{
	app.ApplicationRouter = Backbone.Router.extend({
			initialize: function(){
				
			},
		    routes: {
		        ""			: "home",
		        "inbox"		: "inbox",
		        "contacts"	: "contacts",
		        "tasks"		: "tasks",
		        "deals"		: "deals",
		        "accounts"	: "accounts",
		        "templates"	: "templates",
		        "reports"	: "reports"
		    },
		    home: function(){
		    	$.ajax("loggedInData", {
		   		       type: "GET",
		   		       dataType: "json",
		   		       success: function(loginData) {
		   		    	   if(loginData.email!=null){
		   		    		window.location.assign("/#/inbox");
		   		    	   }
		   		    	   else{
		   		    		var sendMailView= new SendMailView();
				   			$('#signIn').modal('show');
			   		         console.log('plaese login');
		   		    	   }
		   		    	
		   		       },
		   		       error: function() {
		   		    	var sendMailView= new SendMailView();
			   			$('#signIn').modal('show');
		   		         console.log('plaese login');
		   		       }
		   		     });
	   			
		    },
		    inbox: function(){
		    	var pageView=new PageView();
		    	pageView.render('#inbox-template');
		    	$('#navgationList').children().removeClass('active');
	 			$('#inbox_tab').addClass('active');
 				$('#joyRideTipContent').joyride({
 					autoStart : true,
 					
 					modal:true,
 					expose: true
 				});
		    },
		    contacts: function(){
		    	var pageView=new PageView();
		    		  pageView.render('#contacts-template');
		 			 $('#navgationList').children().removeClass('active');
		 			 $('#contacts_tab').addClass('active');
			 		 var personView=new PersonsView();
					 personView.render();
		 			 $("#cancel-contact").css("display","none");
		    },
		    deals: function(){
		    	var pageView=new PageView();
		    	pageView.render('#deals-template');
		    },
		    tasks: function(){
		    	var pageView=new PageView();
		    	pageView.render('#tasks-template');
	 			$('#navgationList').children().removeClass('active');
	 			$('#tasks_tab').addClass('active');
		    },
		    accounts: function(){
		    	var pageView=new PageView();
		    	pageView.render('#accounts-template');
		    	$('#navgationList').children().removeClass('active');
		    	$('#accounts_tab').addClass('active');
		 		$("#cancel-contact").css("display","none");
		    },
		    templates: function(){
		    	var pageView=new PageView();
		    	pageView.render('#templates-template');
		    	$('#navgationList').children().removeClass('active');
		    	$('#templates_tab').addClass('active');
		    },
		    reports: function(){
		    	var pageView=new PageView();
		    	pageView.render('#reports-template');
		    	$('#navgationList').children().removeClass('active');
		    	$('#reports_tab').addClass('active');
		    }
		});
})(jQuery);

app.ApplicationRouter = new app.ApplicationRouter();
Backbone.history.start({pushState: false});