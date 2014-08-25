<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
 <%
 if(session.getAttribute("firstname") != null)
{
	 response.sendRedirect("./index.do");
}
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
<title>Login</title>
</head>
<body>
	<!-------------------- Nav Bar ------------->

	<div class="navbar  navbar-default" id="theme-header"> 
		    <img id="login_logo" alt="" src="img/logo.png" width="224" height="78" >
	    </div>
	<!-- Body Part -->
	<div class="container" id="questionContainer"></div>
	<!-- Login -->

	

	<!----------------        Inbox      ------------------>
	<script type="text/template" id='question-template'>
		  <div class=container >
		 
		  	<div class="navbar"style="padding-right:10px;">
	        	<ul class="nav nav-pills navbar-left input_element">
		        	<li><a class="btn btn-default btn-sm" data-toggle="modal" data-target="#new-questions" id="add-new-question-btn">+ New Question</a></li>
	        	</ul>
        	</div>
        	<div class="container tab-body" id="questionList">
        		
        	</div>
		  </div>
		  </script>
	<!-----------        QuestionList       ------------>

	<div class="modal fade" id="signInModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1>Sign In</h1>
				</div>
				<div class="modal-body">
					If you are already registered please enter:
					<form class="form" role=form id=loginForm action="./login.do" method="post">
						<div class="form-group ${loginFailed}">
							<label for="username">User Name:</label> <input type="text"
								placeholder="Email" class="form-control" name="username"
								id="username"> <span id="userNameSpan"
								class="help-block"></span>
						</div>
						<label for="password">Password:</label>
						<div class="form-group ${loginFailed}">
							<input type="password" placeholder="Password"
								class="form-control" name="password" id="password"> <span
								id="logInPassSpan" class="help-block"></span>
						</div>
						<div class="form-group">
							<button id="signIn" class="btn btn-success">Sign in</button>
							<button type="reset" class="btn btn-default">Reset</button>
						</div>
					</form>
				</div>
				<div class="modal-footer">
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="lib/js/jquery-1.10.2.js"></script>
		<script type="text/javascript" src="lib/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="lib/js/backbone-min.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			$('#signInModal').modal({
				 backdrop: 'static',
				 keyboard: false 
			});
		});
		
		</script>
  	</body>
</html>
    