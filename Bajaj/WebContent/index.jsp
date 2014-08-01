<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
 String loginModule = (String)session.getAttribute("loginModule");
 %>
<!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<link href="lib/css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" type="text/stylesheet" href="lib/css/jquery.dataTables.css">
<link rel="stylesheet" type="text/stylesheet" href="css/reset.css">
<link rel="stylesheet" type="text/stylesheet" href="css/style.css">
<link rel="stylesheet" type="text/stylesheet" href="css/styles.css">
<script type="text/javascript">
var loginModule = <%=loginModule%>;
</script>
<title>Home</title>
</head>
<body>
	<!-------------------- Nav Bar ------------->

	<div class="navbar navbar-inverse navbar-static-top"> 
	    <div class="container">
		    <button class="navbar-toggle" data-toggle="collapse" data-target=".navHeaderCollapse">
			    <span class="icon-bar"></span>
			    <span class="icon-bar"></span>
			    <span class="icon-bar"></span>
		    </button>
		  
		    <a href="/" class="navbar-brand">Spring By Hrishabh</a>
		    
		    <div class="collapse navbar-collapse navHeaderCollapse">
			    <ul class="nav navbar-nav navbar-right" id="links">
			    	<li><a href="#">Welcome
		    <%if(session.getAttribute("user")==null){ %>
		    	Guest
		    <%}else{ %>
		    	${user}
		    <%} %></a></li>
			    	<li id="home"><a href="./">Home</a></li>
			    	<%if(session.getAttribute("user")==null){ %><li id="signin"><a href="#signIn" data-toggle="modal">SignIn</a></li><%} %>
			    	<%if(session.getAttribute("user")==null){ %><li ><a href="#register" data-toggle="modal">Register</a></li><%} %>
				    <%if(session.getAttribute("user")!=null){ %><li id="profile"><a href="./detail" id="profile">Profile</a></li><%} %>
				   <%if(session.getAttribute("user")!=null){ %> <li id=friend><a href="./friend">Search</a></li><%} %>
				    <%if(session.getAttribute("user")!=null){ %> <li id=image><a href="./image">Images</a></li><%} %>
				    <%if(session.getAttribute("user")!=null){ %> <li id=video><a href="./video">Video</a></li><%} %>
				   <%if(session.getAttribute("user")!=null){ %> <li id=logout><a href="./logout">Logout</a></li><%} %>
			    </ul>
	    	</div>
	    </div>
    </div>
    <div class="navbar  navbar-default" id="theme-header"> 
	    <div class="container">
		  
		    <a href="/" class="navbar-brand">Spring By Hrishabh</a>
	    </div>
    </div>
    <div id="live-search">
    <div class="container">
    <div id="search-wrap">
      <form role="search" method="get" id="searchform" class="clearfix" action="#" autocomplete="off">
        <input type="text" onfocus="if (this.value == &#39;Have a question? Ask or enter a search term.&#39;) {this.value = &#39;&#39;;}" onblur="if (this.value == &#39;&#39;)  {this.value = &#39;Have a question? Ask or enter a search term.&#39;;}" value="Have a question? Ask or enter a search term." name="s" id="s" autocomplete="off">
        <input type="submit" id="searchsubmit" value="Search">
      </form>
      </div>
    </div>
    </div>
	<!-- Body Part -->
	<div class="container" id="questionContainer"></div>
	<!-- Login -->

	<!-- <div class="modal fade" id="signIn" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1>Sign In</h1>
				</div>
				<div class="modal-body">
					If you are already registered please enter:
					<form action="login.htm" method="POST" class="form" role=form
						id=loginForm>
						<div class="form-group">
							<label for="username">User Name:</label> <input type="text"
								placeholder="Email" class="form-control" name="username"
								id="username"> <span id="userNameSpan"
								class="help-block"></span>
						</div>
						<label for="password">Password:</label>
						<div class="form-group">
							<input type="password" placeholder="Password"
								class="form-control" name="password" id="password"> <span
								id="logInPassSpan" class="help-block"></span>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-success">Sign in</button>
							<button type="reset" class="btn btn-default">Reset</button>
						</div>
					</form>
					
					Or Login with:
					<div class="form-group">
						<a type="button" class="btn btn-danger "
							href="https://accounts.google.com/o/oauth2/auth?redirect_uri=http://distributed-source.appspot.com/oauth2callback
											&response_type=code&client_id=267273999336.apps.googleusercontent.com
											&scope=https://www.googleapis.com/auth/drive+https@3A@2F@2Fwww.googleapis.com@2Fauth@2Fuserinfo.email+https@3A@2F@2Fwww.googleapis.com@2Fauth@2Fuserinfo.profile&approval_prompt=auto&access_type=online">Google</a>
						<p class="help-block">
							If You don't have these then <a href="#register"
								data-dismiss="modal" data-toggle="modal" data-target="#register">Register
								Here</a>
						</p>
					</div>
				</div>
				<div class="modal-footer">
				<div id="haveMessagesEnabled" class="slider_holder sliderdone"><input type="hidden" class="sliderVal" value="yes"><span class="slider_off sliders"> OFF </span><span class="slider_on sliders"> ON </span><span class="slider_switch"></span></div>
					<a class="btn btn-info" data-dismiss="modal">Close</a>
				</div>
			</div>
		</div>
	</div> -->

	<!----------------        Inbox      ------------------>
	<script type="text/template" id='question-template'>
		  <div class=container id="inbox_div" >
		 
		  	<div id="inbox_header" class="navbar"style="padding-right:10px;">
	        	<ul class="nav nav-pills navbar-left input_element">
		        	<li><a class="btn btn-default btn-sm" data-toggle="modal" data-target="#new-leads" id="add-new-lead-btn">+ New Question</a></li>
	        	</ul>
        	</div>
        	<div class="container tab-body" id="inbox_body">
        		<table class="table table-stripped" id=inbox-table>
        			<thead>
        				<tr>
        					<th>QuestionList</th>
        				</tr>
        			</thead>
        			<tbody id="questionList">
        					
        			</tbody>
        		</table>
        	</div>
		  </div>
		  </script>
	<!-----------        QuestionList       ------------>
<script type="text/template" id="questionListTemplate">
<tr>
  	<td>
		<ul>
			<span class="col-sm-1"><button id="<@=QAModel.id@>" class="expand_listBtn"><i class="glyphicon glyphicon-plus"></i></button></span>
			<span class="col-sm-11">
			<li class="question"><@=QAModel.question@></li>
			<li id="answer_<@=QAModel.id@>" class="answer" style="display:none"><@=QAModel.answer@></li>
			</span>
		</ul>
	</td>
</tr>

</script>
	<!-----------        Contacts       ------------>
	<script type="text/template" id='contacts-template'> 
		  <div class="container"id="contacts_div" >
		  	<div id="contacts_header" class="navbar"style="padding-right:10px;">
	        	<ul class="nav nav-pills navbar-left input_element">
		        	<li><a class="btn btn-default btn-sm" id="add-new-person">+ New Person</a></li>
		        	<li ><a data-toggle="modal" data-target="#import-lead-modal" id=import-contact-button> Import Contacts</a><li>
		        	<li ><a data-toggle="modal" data-target="#alert-content" id=export-all-button> Export All</a><li>
		        	<li ><a data-toggle="modal" data-target="#alert-content" id=delete-all-button> Delete All</a><li>
		        	<li class="pull-right  col-sm-3">
						<div class="input-group input_element">
						  	<input type="text" class="  form-control" placeholder="Search">
						  	<span class="input-group-addon btn"><span class="glyphicon glyphicon-search"></span></span>
						</div>
		        	</li>
	        	</ul>
        	</div>
        	<div class="container tab-body" id="contact_body">
        	<div class="row" style=" height: 100@; ">
	        	<div class="col-sm-3 contact-container">
        			<div class="navbar navbar-default nav-contact-panel" role="navigation" >
        				<ul class="nav nav-pills">
	        				<li><a class="btn btn-default btn-sm give-margin" id=people>People</a></li> 
	        				<li><a class="btn btn-default btn-sm give-margin " id=companies>Companies</a></li>
        				</ul>
        			</div> 
        			<div class="navbar navbar-default nav-contact-panel" role="navigation" >
        				<div class="checkbox give-margin">
        					<input type="checkbox" name="header_chkbox">
        					<span class="pull-right give-margin">Delete Selected</span>
        				</div>
        			</div> 	
					<div class="navbar navbar-default nav-contact-panel" role="navigation" id="cancel-contact" style="display: none;">
						<label>New Contact</label>
						<a class="btn btn-default btn-sm pull-right give-margin" id=cancel-contact-button>X Cancel</a>
					</div>
					<div class="nav-contact-panel" role="navigation" id="person-listContainer">
						<div class="navbar navbar-default contact-panel3-nav" role="navigation" >
						</div>
					</div>
	        	</div>
	        	<div class="contact-container col-sm-4 " id="customer_info">
	        		<img style="position:absolute;top:50@;right:25@;display:block;" src="img/empty_contact.png">
	        	</div>
	        	<div class="col-sm-5 " id='person_col3_holder'>
	        		
        		
        		</div>
		  	</div>
	      </div>
	     </div>
        	</script>
		  
	<!-----------------        Task          ------------>
	<script type="text/template" id='tasks-template'>
		  <div class=container id="tasks_div" ">
		  	<div id="tasks_header" class="navbar"style="padding-right:10px;">
	        	<ul class="nav nav-pills navbar-left input_element">
		        	<li class="pull-right  col-sm-3">
						<div class="input-group input_element">
						  	<input type="text" class="  form-control" placeholder="Search">
						  	<span class="input-group-addon btn"><span class="glyphicon glyphicon-search"></span></span>
						</div>
		        	</li>
	        	</ul>
        	</div>
        	<div class="container tab-body" id="task_body">
        		<div class="panael panel-default">
        			<div class=panel-heading>
        			<div class="navbar" style="margin-bottom: -4px;border-bottom-width: 0px;">
						<ul class="nav navbar-nav navbar-left">
        					<li><select  id="tasks-bulk-selector" data-placeholder="safff"style="width: 150px; margin-top: 10px;">
								  <option data-value="0" class="select-placeholder">Bulk Options...</option>
								  <option data-value="glyphicon glyphicon-ok"> Mark Complete</option>
								  <option data-value="glyphicon glyphicon-calendar"> Reschedule</option>
								  <option data-value="glyphicon glyphicon-repeat"> Reassign</option>
								  <option data-value="glyphicon glyphicon-trash"> Delete</option>
							</select>
							</li>
        					<li><a href="#">Tomorrow</a></li>
        					<li><a href="#">Today</a></li>
        					<li><a href="#">Late</a></li>
        				</ul>  
        				<ul class="nav navbar-nav navbar-right">
        					<li class="navbar-text"style="margin-top: 20px;">Select rows:</li>
        					<li>
        						<select class="form-control" data-name="selectbox1" style="max-width: 80px; margin-top: 10px;">
								  <option>10</option>
								  <option>25</option>
								  <option>50</option>
								  <option>75</option>
								  <option>100</option>
								</select>
							</li>
        					<li class="navbar-text"style="margin-top: 20px;">
        						<span>1</span>
        						<span>-</span>
        						<span>0</span>
        						<span>of</span>
        						<span>0</span>
        						
        					</li>
        					<li style="margin-right: 15px;">
        						<ul class="pagination" style="margin-bottom: 0px;margin-top: 10px;">
        						<li><a href="#"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
        						<li><a href="#"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
        						</ul>
        					</li>
        					<li style="margin-top: 10px; margin-right: 15px;">
							    <div class="input-group input_element" style="max-width: 350px">
							      <input type="text" class="form-control ">
							      <div class="input-group-btn">
							      <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-calendar"></span></button>
							        <select  class="btn btn-default" style="padding-bottom: 5px;">
							        	<option selected="selected" >Late and Today</option>
							          	<option >Late</option>
								        <option>Today</option>
								        <option>Tomorrow</option>
								        <option>This Week</option>
								        <option>Last 7 days</option>
								        <option>This Month</option>
								        <option>Last Month</option>
								        <option>All</option>
							        </select>
							      </div>
							    </div>
        					</li>
        				</ul>  
        				</div>      				
        			</div>
        			<div class="panel-body">
        				<table class="table table-stripped" id=tasks-table>
        					<thead>
		        				<tr>
		        					<th><input type="checkbox"></th>
		        					<th> Details</th>
		        					<th>Added By</th>
		        					<th>Rating</th>
		        					<th>Due</th>
		        					<th>Tags</th>
		        					<th>Created</th>
		        					<th>Local Time</th>
		        				</tr>
		        			</thead>
		        			<tbody>
		        				<tr>
		        					<td colspan="8" class="history-empty"></td>
		        					
		        				</tr>	
		        			</tbody>
		        		</table>
        			</div>
        		</div>
        	</div>
		  </div>
		  </script>
	<!-----------------        Deals          ------------>
	<script type="text/template" id='deals-template'>
		  <div class=container id="deals_div" >
		  	<div id="tasks_header" class="navbar"style="padding-right:10px;" >
	        	<ul class="nav nav-pills navbar-left input_element">
	        		<li><a class="btn btn-default btn-sm" data-toggle="modal" data-target="#new-deals">+ New Deal</a></li>
		        	<li class="pull-right  col-sm-3">
						<div class="input-group input_element">
						  	<input type="text" class="  form-control" placeholder="Search">
						  	<span class="input-group-addon btn"><span class="glyphicon glyphicon-search"></span></span>
						</div>
		        	</li>
	        	</ul>
        	</div>
        	<div class="container tab-body" id="deals_body">
        		<div class="panael panel-default">
        			<div class=panel-heading>
        			<div class="navbar" style="margin-bottom: -4px;border-bottom-width: 0px;">
						<ul class="nav navbar-nav navbar-left">
        					<li><select  id="deals-bulk-selector" style="width: 150px; margin-top: 10px;">
								  <option data-value="0" class="select-placeholder">Bulk Options...</option>
								  <option data-value="glyphicon glyphicon-trash"> Archive</option>
							</select>
							</li>
        					<li>
        						<select id="deals-selector" style="width: 100px; margin-left:10px; margin-top: 10px;">
        							<option selected="selected">My Deals</option>
        							<option>All Deals</option>
        							<option>Archive</option>
        						</select>
        					</li>
        				</ul>  
        				<ul class="nav navbar-nav navbar-right">
        					<li class="navbar-text"style="margin-top: 20px;">Select rows:</li>
        					<li>
        						<select class="form-control" data-name="selectbox1" style="max-width: 80px; margin-top: 10px;">
								  <option>10</option>
								  <option>25</option>
								  <option>50</option>
								  <option>75</option>
								  <option>100</option>
								</select>
							</li>
        					<li class="navbar-text"style="margin-top: 20px;">
        						<span>1</span>
        						<span>-</span>
        						<span>0</span>
        						<span>of</span>
        						<span>0</span>
        					</li>
        					<li style="margin-right: 15px;">
        						<ul class="pagination" style="margin-bottom: 0px;margin-top: 10px;">
        						<li><a href="#"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
        						<li><a href="#"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
        						</ul>
        					</li>
        					<li style="margin-top: 10px; margin-right: 15px;">
							    <div class="input-group input_element" style="max-width: 350px">
							      <input type="text" class="form-control ">
							      <div class="input-group-btn">
							      <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-calendar"></span></button>
							        <select  class="btn btn-default" style="padding-bottom: 5px;">
							        	 <option selected="selected">All</option>
							        	 <option>Today</option>
							        	 <option>This Week</option>
							        	 <option>Last 7 days</option>
								        <option>This Month</option>
								        <option>Last Month</option>
							        </select>
							      </div>
							    </div>
        					</li>
        				</ul>  
        				</div>      				
        			</div>
        			<div class="panel-body">
        				<table class="table table-stripped" id=deals-table>
        					<thead>
		        				<tr>
		        					<th><input type="checkbox"></th>
		        					<th> Deal Name</th>
		        					<th>Value</th>
		        					<th>Rating</th>
		        					<th>Updated</th>
		        					<th>Created</th>
		        				</tr>
		        			</thead>
		        			<tbody>
		        				<tr>
		        					<td colspan="8" class="deal-empty"></td>
		        					
		        				</tr>	
		        			</tbody>
		        		</table>
        			</div>
        		</div>
        	</div>
		  </div>
		</script>
	<!------------- Accounts div -------------->
	<script type="text/template" id='accounts-template'>
		  <div class=container id="accounts_div">
		  	<div id="tasks_header" class="navbar"style="padding-right:10px;">
	        	<ul class="nav nav-pills navbar-left input_element">
	        		<li><a class="btn btn-default btn-sm " data-toggle="modal" data-target="#new-account" id=add-new-account-btn>+ New Account</a></li>
		        	<li class="pull-right  col-sm-3">
						<div class="input-group input_element">
						  	<input type="text" class="  form-control" placeholder="Search">
						  	<span class="input-group-addon btn"><span class="glyphicon glyphicon-search"></span></span>
						</div>
		        	</li>
	        	</ul>
        	</div>
        	<div class="container tab-body" id="accounts_body">
        		<div class="panael panel-default">
        			<div class=panel-heading>
        			<div class="navbar" style="margin-bottom: -4px;border-bottom-width: 0px;">
						<ul class="nav navbar-nav navbar-left">
        					<li><select  id="accounts-bulk-selector" style="width: 150px; margin-top: 10px;">
								  <option data-value="0" class="select-placeholder">Bulk Options...</option>
								  <option data-value="glyphicon glyphicon-trash"> Archive</option>
							</select>
							</li>
        					<li>
        						<select id="accounts-selector" style="width: 100px; margin-left:10px; margin-top: 10px;">
        							<option selected="selected">My Accounts</option>
        							<option>All Accounts</option>
        							<option>Archives</option>
        						</select>
        					</li>
        				</ul>  
        				<ul class="nav navbar-nav navbar-right">
        					<li style="margin-right: 15px;">
        						<ul class="pagination" style="margin-bottom: 0px;margin-top: 10px;">
        						<li><a href="#"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
        						<li><a href="#"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
        						</ul>
        					</li>
        				</ul>  
        				</div>      				
        			</div>
        			<div class="panel-body">
        			<ul>
        				<li>
        					<div class = card-holder>
        						<div class ="col-md-2 ">Image</div>
								<div class ="col-md-10 card-body">
									<div class = "row author"><h5>Author</h5></div>
									<div class = "row card-header"><h3>Card Header</h3></div>
									<div class = "card-description"><p>Description goes here</p></div>
								</div>
        					</div>
		        			<ul>
		        				<li>
		        					<div class = reply-holder>
		        						<div class ="col-md-2 ">Image</div>
										<div class ="col-md-10 reply-body">
											<div class = "row author"><h5>Author</h5></div>
											<div class = "row reply-message"><p>Reply Messages goes here</p></div>
										</div>
		        					</div>
		        				</li>
		        				<li>
		        					<div class = reply-holder>
		        						<div class ="col-md-2 ">Image</div>
										<div class ="col-md-10 reply-body">
											<div class = "row author"><h5>Author</h5></div>
											<div class = "reply-message"><p>Reply Messages goes here</p></div>
										</div>
		        					</div>
		        				</li>
		        			</ul>
		        		</li>
		        	</ul>
        			
        			
        			
        			</div>
        		</div>
        	</div>
		  </div>
		  </script>

	<!-----------------Reports Div -------------->
	<script type="text/template" id='reports-template'>
		  <div class=container id="reports_div" ">
		  	<div id="tasks_header" class="navbar"style="padding-right:10px;" >
	        	<ul class="nav nav-pills navbar-left input_element">
	        		<li>
	        			<select  class="btn btn-default" style="padding-bottom: 5px;">
				        	 <option selected="selected">Registrations</option>
				        	 <option>Archived Leads</option>
				        	 <option>Tasks</option>
				        </select>
	        		</li>
	        		<li><a href="#" data-toggle="modal" data-target="#alert-content" id="report-download-link">Download</a></li>
		        	<li class="pull-right  col-sm-3">
						<div class="input-group input_element">
						  	<input type="text" class="  form-control" placeholder="Search">
						  	<span class="input-group-addon btn"><span class="glyphicon glyphicon-search"></span></span>
						</div>
		        	</li>
	        	</ul>
        	</div>
        	<div class="container " id="report_body" style="background-color: #FFFFFF;">
        		<div class="panael panel-default ">
        			<div class=panel-heading>
        			<div class="navbar" style="margin-bottom: -4px;border-bottom-width: 0px;">
						<ul class="nav navbar-nav navbar-left">
        					<li><span><input type="checkbox"></span> Visual Report</li>
        				</ul>  
        				<ul class="nav navbar-nav navbar-right">
        					<li style="margin-top: 10px; margin-right: 15px;">
							    <div class="input-group input_element" style="max-width: 350px">
							      <input type="text" class="form-control ">
							      <div class="input-group-btn">
							      <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-calendar"></span></button>
							        <select  class="btn btn-default" style="padding-bottom: 5px;">
							        	 <option >All</option>
							        	 <option selected="selected">Today</option>
							        	 <option>This Week</option>
							        	 <option>Last 7 days</option>
								        <option>This Month</option>
								        <option>Last Month</option>
							        </select>
							      </div>
							    </div>
        					</li>
        				</ul>  
        				</div>      				
        			</div>
        			<div class="panel-body " >
        				<table class="table table-stripped" id=deals-table>
        					<thead>
		        				<tr>
		        					<th>Name</th>
		        					<th>Company Name</th>
		        					<th>ID</th>
		        					<th>Created</th>
		        					<th>Source</th>
		        					<th>Next Call Back</th>
		        					<th>User Name</th>
		        					<th>Bad Lead</th>
		        				</tr>
		        			</thead>
		        			<tbody>
		        			</tbody>
		        		</table>
        			</div>
        			<div class=panel-footer >
        				<h3> 
        					<b> Total Leads : 0 </b> 
        					<b> Bad Leads : 0 </b> 
        				</h3>
        			</div>
        		</div>
        	</div>
		  </div>
	   </script>
	<!------------------- New Lead Modal---------------->

	<div class="modal fade" id="new-leads" role="dialog">
		<div class="modal-dialog modal-vertical-centered">
			<div class="modal-content">
				<div class="modal-header">
					<span class="glyphicon glyphicon-remove pull-right"
						data-dismiss="modal"></span>
					<h4 class="modal-title">Create a new lead</h4>
				</div>
				<div class="modal-body">
					<form class="form" role=form id=create_lead_popup>
						<div class="form-group">
							<input type="text" placeholder="Name *" class="form-control"
								id="lead_name">
						</div>
						<div class="form-group" id=lead_add_company_div>
							<a id="lead_add_company">Add Company</a>
							<div class="input-group" id=lead_add_company_input
								style="display: none;">
								<input type="text" placeholder="Company Name"
									id="lead_company_name" class="form-control"> <span
									class="input-group-addon" id="delete_lead_Company"> <span
									class="glyphicon glyphicon-trash"></span>
								</span>
							</div>
						</div>
						<div class="form-group">
							<input type="text" placeholder="Lead Source" id="lead-source"
								class="form-control">
						</div>
						<div class="form-group">
							<input type="text" placeholder="Phone" id="lead_phone_field"
								class="form-control">
						</div>
						<div class="form-group">
							<input type="text" placeholder="Email" id="lead_email_field"
								class="form-control">
						</div>
						<div class="form-group">
							<textarea placeholder="Notes/Additional Info"
								id="lead_notes_field" class="form-control"></textarea>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-default">+ Create
								this lead</button>
						</div>
					</form>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>

	<!-- ------------Modal for Import -------- -->

	<script type="text/template" id=import-Modal>
				<div class="modal-header">
					<span class="glyphicon glyphicon-remove pull-right"
						data-dismiss="modal"></span>
					<h4 class="modal-title">Please choose an import option.</h4>
					<span class="divider"></span>
				</div>
				<div class="modal-body">

					<div class="panel  panel-default" id=idImportGoogle-docs style="cursor:pointer;">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-2">
									<img alt="" src="img/gmail-ac.png" class="img-responsive">
								</div>
								<div class="col-sm-10">
									<p class=text-justify>Maximum Contacts: 10000. Contacts can
										have name, email, phone & structured postal address fields
										which includes address,city,state & zip etc.</p>
								</div>
							</div>
						</div>
					</div>
					<div class="panel  panel-default" id=importCSVContacts style="cursor:pointer;">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-2">
									<img alt="" src="img/csv_icon.png" class="img-responsive">
								</div>
								<div class="col-sm-10">
									<p class=text-justify>Maximum file size allowed: 1024kb.
										File should include a header, or first line, that defines the
										fields (ex: name, email address, etc.). Spreadsheet programs
										like Google Spreadsheets and Microsoft Excel make it easy to
										create and edit CSV files.</p>
								</div>
							</div>
						</div>
					</div>
					<div class="panel  panel-default" id=idImportXLSContacts style="cursor:pointer;">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-2">
									<img alt="" src="img/xls_icon.png" class="img-responsive">
								</div>
								<div class="col-sm-10">
									<p class=text-justify>Maximum file size allowed: 1024kb.
										File should include a header, or first line, that defines the
										fields (ex: name, email address, etc.). Spreadsheet programs
										like OpenOffice Spreadsheets and Microsoft Excel make it easy
										to create and edit XLS files.</p>
								</div>
							</div>
						</div>
					</div>
					<div class="panel  panel-default" id=idImportXLSXContacts style="cursor:pointer;">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-2">
									<img alt="" src="img/xlsx_icon.png" class="img-responsive">
								</div>
								<div class="col-sm-10">
									<p class="text-justify">Maximum file size allowed: 1024kb.
										File should include a header, or first line, that defines the
										fields (ex: name, email address, etc.). Spreadsheet programs
										like Google Spreadsheets and Microsoft Excel make it easy to
										create and edit XLSX files.</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer"></div>
			</script>

	<!-- Customer Info form -->

	<script type="text/template" id="person-detailForm-template">
    		<form class="form" style="margin-top: 15px;" id="person-form">
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<img alt="" src="img/customer_photo.png">
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group">
	    					<input class="form-control" placeholder="Name" name="name" id="person-name">
	    					<input class="form-control" placeholder="Job Title" name="jobTitle" id="person-jobTitle">
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>Company</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group">
	    					<input class="form-control" placeholder="Company" name="company" id=person-company>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>Source</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group">
	    					<input class="form-control" placeholder="Source" name="source" id="person-source">
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
    					<select class="form-control"  id=person-phoneType>
    						<option selected="selected">Phone</option>
    						<option>Mobile Phone</option>
    						<option>Work Phone</option>
    						<option>Home Phone</option>
    						<option>Main Phone</option>
    						<option>Custom</option>
    					</select>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group">
	    					<input class="form-control" placeholder="Phone" name="phone"id=person-phoneNumber>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
    					<select class="form-control" id=person-emaiType>
    						<option selected="selected">Email</option>
    						<option>Personal Email</option>
    						<option>Work Email</option>
    						<option>Custom</option>
    					</select>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group">
	    					<input class="form-control" placeholder="Email"  name=email id=person-email>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
    					<select class="form-control" id=person-socialType>
    						<option selected="selected">Social</option>
    						<option>Facebook</option>
    						<option>Twitter</option>
    						<option>LinkedIn</option>
    						<option>Google Plus</option>
    						<option>Custom</option>
    					</select>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group">
	    					<input class="form-control" placeholder="Social"  name="social" id=person-socialID>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>Website</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group">
	    					<input class="form-control" placeholder="Website"  name="website" id=person-website>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
    					<select class="form-control" id=person-addressType>
    						<option selected="selected">Address</option>
    						<option>Home Address</option>
    						<option>Office Address</option>
    						<option>Custom</option>
    					</select>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group">
	    					<input class="form-control" placeholder="Address"  name="street" id=person-street>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>City</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group" >
	    					<input class="form-control" placeholder="City"  name="city" id=person-city>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>State</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group">
	    					<input class="form-control" placeholder="State" name="state" id=person-state>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>Country</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group">
	    					<input class="form-control" placeholder="Country" name="country" id=person-country>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>Zip</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group">
	    					<input class="form-control" placeholder="Zip"  name=zip id=person-zip>
	    				</div>
	    			</div>
				</div>
	    			<div class="row">
						<div class="col-sm-4 ">
							<button type="submit" class="btn btn-success" id="person-submit">
							Submit
							</button>
						</div>	    			
	    			</div>
	    		</div>
    		</form>
    	</script>
	<!-- Modal For Alert -->
	<div class="modal fade" id="alert-content" role="dialog">
		<div class="modal-dialog modal-vertical-centered">
			<div class="modal-content">
				<div class="modal-header"></div>
				<div class="modal-body">
					<div id="exportAll-alert">
						<p class="text-justify" style="font-size: 14px;">Are you sure
							you want to export the contacts? If you press OK, Contacts will
							be exported and you will receive email notification on
							completion.</p>
					</div>
					<div id="deleteAll-alert" style="font-size: 14px;">
						<p class="text-justify">Are you sure you want to delete ALL
							People and Company contacts? If you press Ok, All information
							associated with ALL contacts will be permanently deleted. There
							is no undo.</p>
					</div>
					<div id="reportDownload-alert" style="font-size: 14px;">
						<p class="text-justify">Are you sure you want to download the
							report? If you press OK, Report will be downloaded and you will
							receive email notification on completion.</p>
					</div>
					<div class="modal-footer">
						<div class=center-block>
							<a class="btn btn-default">OK</a> <a class="btn btn-default"
								data-dismiss="modal">cancel</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-------------  Deals Modal ------------->
	<div class="modal fade" id="new-deals" role="dialog">
		<div class="modal-dialog modal-vertical-centered">
			<div class="modal-content">
				<div class="modal-header">
					<span class="glyphicon glyphicon-remove pull-right"
						data-dismiss="modal"></span>
					<h4 class="modal-title">Create a new Deal</h4>
				</div>
				<div class="modal-body">
					<form class="form" role=form id=create_lead_popup>
						<div class="form-group">
							<input type="text" placeholder="Deal Name" class="form-control"
								id="deal_name">
						</div>
						<div class="form-group">
							<input type="text" placeholder="Deal Source" id="deal-source"
								class="form-control">
						</div>
						<div class="form-group">
							<textarea placeholder="Notes/Additional Info"
								id="deals_notes_field" class="form-control"></textarea>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-default">+ Create
								this deal</button>
							<a data-dismiss="modal" style="margin-left: 10px;">Cancel</a>
						</div>
					</form>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>

	<!----------- New Account Modal -------------->

	<div class="modal fade" id="new-account" role="dialog">
		<div class="modal-dialog modal-vertical-centered">
			<div class="modal-content">
				<div class="modal-header">
					<span class="glyphicon glyphicon-remove pull-right"
						data-dismiss="modal"></span>
					<h4 class="modal-title">Create a new Account</h4>
				</div>
				<div class="modal-body">
					<form class="form" role=form id=create_lead_popup>
						<div class="form-group">
							<input type="text" placeholder="Account Name"
								class="form-control" id="deal_name">
						</div>
						<div class="form-group">
							<input type="text" placeholder="Account Source" id="deal-source"
								class="form-control">
						</div>
						<div class="form-group">
							<textarea placeholder="Notes/Additional Info"
								id="deals_notes_field" class="form-control"></textarea>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-default">+ Create
								this account</button>
							<a data-dismiss="modal" style="margin-left: 10px;">Cancel</a>
						</div>
					</form>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>

	<!----------------- Upgrade Plan Modal -------------------->

	<div class="modal fade" id="upgrade-plan-modal" role="dialog">
		<div class="modal-dialog modal-vertical-centered">
			<div class="modal-content">
				<div class="modal-header">
					<span class="glyphicon glyphicon-remove pull-right"
						data-dismiss="modal"></span>
					<h4 class="modal-title">Account Details</h4>
				</div>
				<div class="modal-body">
					<div class=row>
						<div class="col-sm-4" style="padding-right: 0px;">
							<div class="panel panel-default">
								<div class=panel-body>
									<div class="">
										<div class="">dgs</div>
										<div class="arrow" style="background-color: blue;"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-4"
							style="padding-right: 0px; padding-left: 0px;">
							<div class="panel panel-default">
								<div class=panel-body>
									<div class="popover top">sdgsg</div>
								</div>
							</div>
						</div>
						<div class="col-sm-4" style="padding-left: 0px;">
							<div class="panel panel-default">
								<div class=panel-body>
									<div class="popover top">sgdsg</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>
	<script type="text/template" id=person-list-template>
    		<@_.each(personsList, function(person){@>
			<div class="row">
				<div class="input-group">
					<button type="button" class="btn btn-default form-control show-person" id=<@= person.get('id') @>><span class="pull-left"><@= person.get('name') @></span></button>
					<span class="input-group-addon btn btn-default delete-person" id=<@= person.get('id') @>><span class="glyphicon glyphicon-trash " id=<@= person.id @>> </span></span>
				</div>
			</div>
			<@});@>
    	</script>
	<script type="text/template" id=person-detail-template>
    		<div class="row" style="margin-top: 15px;">
	    			<div class="col-sm-4">
	    				<img alt="" src="img/customer_photo.png">
	    			</div>
			</div>
			<div class=row>
				<div class="col-sm-4">
	    				<label>Name</label>
	    		</div>
	    		<div class="col-sm-8">
	    			<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-name>
								<@= person.get('name') @>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
				<div class="row">
	    			<div class="col-sm-4">
	    				<label>Job Title</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-jobTitle>
								<@= person.get('jobTitle')@>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>Company</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-company>
								<@= person.get('company') @>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>Source</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-source>
								<@= person.get('source')@>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
    					<label>Phone</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-phone>
								<@= person.get('phone')@>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
    					<label>Email</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-email>
								<@= person.get('email')@><span class="pull-right btn glyphicon glyphicon-envelope send-email" id='<@= person.get('id')@>'></span>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
    					<label>Social ID</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-social>
								<@= person.get('social')@>
								</div>	
							</div>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>Website</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-website>
								<@= person.get('website')@>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
    					<label>Address</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-street>
								<@= person.get('street')@>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>City</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp" >
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-city>
								<@= person.get('city')@>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>State</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-state>
								<@= person.get('state')@>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>Country</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body" id=static-country>
								<@= person.get('country')@>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
	    		<div class="row">
	    			<div class="col-sm-4">
	    				<label>Zip</label>
	    			</div>
	    			<div class="col-sm-8">
	    				<div class="form-group frm-grp">
	    					<div class="panel panel-default form-info-field">
								<div class="panel-body " id=static-zip>
									<@= person.get('zip')@>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
					<div class="row">
	    			<div >
	    				<button class="btn btn-default edit-person-btn" type="button">Edit</button>
						<button class="btn btn-success save-person-btn" type="button" id=<@= person.id @>>Save</button>
						<button class="btn btn-danger delete-person-btn" type="button" id=<@= person.id @>>Delete</button>
	    			</div>
	    		</div>
    	</script>
    	<script type="text/template" id="person-col3-template">
    	<div class="panael panel-default">
        			<div class=panel-heading>
        				<div class="btn-group btn-group-sm conatact-holder">
 							<button type="button" class="btn btn-default" id="tasks-holder">Tasks</button>
  							<button type="button" class="btn btn-default" id="history-holder">History</button>
  							<button type="button" class="btn btn-default" id="documents-holder">Documents</button>
							<button type="button" class="btn btn-default" id="deals-holder">Deals</button>
							<button type="button" class="btn btn-default" id="accounts-holder">Accounts</button>
							<button type="button" class="btn btn-default" id="custom-holder">Custom</button>
						</div>  				
        			</div>
        			<div class="panel-body" >
        				<table class="table table-stripped" id=contact-holder-table>
        					<thead>
		        				<button type="button" class="btn btn-default" data-toggle="modal" data-target="#import-lead-modal"  id="import-document" style="display:none">Import document</button>
		        			</thead>
		        			<tbody id="contacts-col3-table">
								<@var i=0;@>
		        				<@_.each(docsList, function(driveItem){@> 
										
										<tr>
		        						<td >
											<input type="checkbox" id="<@= driveItem.id @>" class="drive-doc-check">
										</td>
										<td >
											<i><img src="<@=driveItem.iconLink @>"></img></i><a href="<@= driveItem.alternateLink@>" target="_blank"><@= driveItem.title@></a>
										</td>
										<td >
											<button id="<@= i @>" class="btn btn-danger btn-sm delete-doc">Delete</button>
										</td>
		        					</tr>	
									<@i++;@>
									 <@});@> 
		        			</tbody>
		        		</table>
        			</div>
        		</div>
			</script>
	<script type="text/template" id="compose-mail-template">	
						<form  class="form" role=form id=create_lead_popup>
	    				<div class="row form-group">
	    					<div class=col-sm-2>
	    						From:
	    					</div>
	    					<div class="col-sm-10">
	    						<select class="form-control col-sm-3" id="email-sender">
	    							<option value=<@= person.get('from') @>><@= person.get('from') @></option>
	    						</select>
	    					</div>
	    				</div>
	    				<div class="row form-group">
						
	    					<div class=col-sm-2>
	    						To:
	    					</div>
	    					<div class="col-sm-10">
	    						<input class="form-control" id="email-recipient" value="<@= person.get('email') @>">
	    					</div>
	    				</div>
	    				<div class="row form-group">
	    					<div class=col-sm-2>
	    						Subject:
	    					</div>
	    					<div class="col-sm-10">
	    						<input class="form-control" id="email-subject">
	    					</div>
	    				</div>
	    				<div class="row form-group">
	    					<div class=col-sm-2>
	    						Category:
	    					</div>
	    					<div class="col-sm-10">
	    						<select class="form-control col-sm-3" id="email-categoty">
	    							
	    						</select>
	    					</div>
	    				</div>
	    				<div class="row form-group">
	    					<div class=col-sm-2>
	    						Template:
	    					</div>
	    					<div class="col-sm-10">
	    						<select class="form-control col-sm-3" id="email-template">
	    							<option>Select Template</option>
	    						</select>
	    					</div>
	    				</div>
	    			 	<div class="form-group">
	    					<div class="panel panel-default" >
	    						<div class="panel-body" id="email-content" contenteditable=true style="min-height:100@">
	    							<br>
									<span>
										Thanks and Regards<br>
										<@= person.get('name')@>
									</span>
	    						</div>
	    					</div>
	    				</div>
						<div class="form-group">
						
							<button class="btn btn-default"  type="submit">Send Email</button>
						</div>
				    	</form>
						</script>

	<div class="modal fade" id="send-email-modal" role="dialog">
		<div class="modal-dialog ">
			<div class="modal-content" id=send-email-modal-content>
				<div class="modal-header">
					<span class="glyphicon glyphicon-remove pull-right"
						data-dismiss="modal"></span>
					<h4 class="modal-title" id=send-email-modal-header></h4>
				</div>
				<div class="modal-body" id="send-email-modal-body"></div>
			
			<div class="modal-footer" id="send-email-modal-footer">
			</div>
			</div>
		</div>
	</div>

	<script type="text/template" id=drive-items-template>
				<div class="modal-header">
					<span class="glyphicon glyphicon-remove pull-right"
						data-dismiss="modal"></span>
					<h4 class="modal-title" id=modal-header>Please select your docs</h4>
				</div>
				<div class="modal-body" id="modal-body">
				<div class="panel-body limit-hieght" >
					<table class="table table-stripped " id=contact-holder-table>
					<thead>
						<th>select</th>
						<th>File List</th>
					</thead>
		        		<tbody id="contacts-col3-table">
						<@_.each(driveItemsList, function(driveItem){@>
									<tr>
		        						<td >
											<input type="checkbox" id="<@= driveItem.id @>" class="drive-doc-check">
										</td>
										<td >
											<i><img src="<@=driveItem.attributes.iconLink @>"></img></i><a href="<@= driveItem.attributes.alternateLink@>" target="_blank"><@= driveItem.get('title')@></a>
										</td>
		        					</tr>	
								<@});@>
		        		</tbody>
					</table>
				</div>
				</div>
				<div class="modal-footer" id="send-email-modal-footer">
					<button class="btn btn-info docs-import-btn" >Import</button>
				</div>
		</script>
		<script type="text/javascript" src="lib/js/underscore-min.js"></script>
		<script type="text/javascript" src="lib/js/jquery-1.10.2.js"></script>
		<script type="text/javascript" src="lib/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="lib/js/backbone-min.js"></script>
		<script type="text/javascript" src="lib/js/jquery.dataTables.js"></script>
		
		<script type="text/javascript" src="js/home.js"></script>
		<script type="text/javascript" src="js/app.js"></script>
		<script type="text/javascript" src="js/view/QuestionView.js"></script>
		<script type="text/javascript" src="js/ApplicationRouter.js"></script>
  	</body>
</html>
    