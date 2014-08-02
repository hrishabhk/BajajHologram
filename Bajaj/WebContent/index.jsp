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
<link rel="stylesheet" type="text/stylesheet" href="lib/css/jquery-ui.min.css">
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
		  <div class=container >
		 
		  	<div class="navbar"style="padding-right:10px;">
	        	<ul class="nav nav-pills navbar-left input_element">
		        	<li><a class="btn btn-default btn-sm" data-toggle="modal" data-target="#new-leads" id="add-new-question-btn">+ New Question</a></li>
	        	</ul>
        	</div>
        	<div class="container tab-body" id="questionList">
        		
        	</div>
		  </div>
		  </script>
	<!-----------        QuestionList       ------------>
<script type="text/template" id="questionListTemplate">
<table class="table table-stripped" id=inbox-table>
    <thead>
       <tr>
        <th>QuestionList</th>
       </tr>
   </thead>
  <tbody >
  	<@if(QACollection.length >0){@>
		<@_.each(QACollection.models, function(QAModel){@>
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
		<@});} else { console.log('Hrishabh')@>
			<tr>
		  	<td>
				<ul>
					
					<li class="NoQuestion">No Frequent Question added yet !</li>
					
					</span>
				</ul>
			</td>
		</tr>
		<@}@>
  </tbody>
</table>
</script>

<script type="text/template" id="questionDetailTemplate">
	<p class="text-justify" style="font-size: 14px;"><@=model.get('question')@></p>
	<p class="text-justify" style="font-size: 14px;"><@=model.get('answer')@></p>
	<div class="modal-footer">
		<div class=center-block>
			<a class="btn btn-default" data-dismiss="modal">OK</a>
			<a class="btn btn-default" id="EditQA">Edit</a>
		</div>
	</div>
</script>
<script type="text/template" id="questionEditTemplate">
	<input type="hidden" value="<@=model.id@>">
	<textarea id="questionVal"><@=model.get('question')@></textarea>
	<textarea id="answerVal"><@=model.get('answer')@></textarea>
	<select id="frequentVal" >
		<option value="0">Not Frequent</option>
		<option value="1">Frequent</option>
	</select>
	<div class="modal-footer">
		<div class=center-block>
			<a class="btn btn-success" data-dismiss="modal"  id="SaveQA">OK</a>
		</div>
	</div>
</script>
	<!-- Modal For Alert -->
	<div class="modal fade" id="QADeatailModal" role="dialog">
		<div class="modal-dialog modal-vertical-centered">
			<div class="modal-content">
				<div class="modal-header"></div>
				<div class="modal-body" id="QAModal">
						
					
				</div>
			</div>
		</div>
	</div>
	
		<script type="text/javascript" src="lib/js/underscore-min.js"></script>
		<script type="text/javascript" src="lib/js/jquery-1.10.2.js"></script>
		<script type="text/javascript" src="lib/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="lib/js/backbone-min.js"></script>
		<script type="text/javascript" src="lib/js/jquery.dataTables.js"></script>
		<script type="text/javascript" src="lib/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/commonFunction.js"></script>
		<!-- Collection -->
		<script type="text/javascript" src="js/collection/QACollection.js"></script>
		
		<!-- Model -->
		<script type="text/javascript" src="js/model/QAModel.js"></script>
		
		<!-- View -->
		<script type="text/javascript" src="js/view/QuestionDetailView.js"></script>
		<script type="text/javascript" src="js/view/QuestionListView.js"></script>
		<script type="text/javascript" src="js/view/QuestionBaseView.js"></script>
		
		
		<!-- Router -->
		<script type="text/javascript" src="js/ApplicationRouter.js"></script>
  	</body>
</html>
    