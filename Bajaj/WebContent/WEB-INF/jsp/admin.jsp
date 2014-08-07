<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% String loginModule = (String) session.getAttribute("loginModule"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<link href="lib/css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" type="text/stylesheet" href="lib/css/jquery.dataTables.css">
<link rel="stylesheet" type="text/stylesheet" href="lib/css/jquery-ui.min.css">
<link rel="stylesheet" type="text/stylesheet" href="css/admin.css">
<script type="text/javascript">
var loginModule = <%=loginModule%>;
</script>
<title>Admin</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container" id="page-container"></div>
	
	<script type="text/template" id='userTemplate'> 
  <div class="container">
  	<div id="contacts_header" class="navbar"style="padding-right:10px;">
       	<ul class="nav nav-pills navbar-left input_element">
        	<li><a class="btn btn-default btn-sm" id="addUser">+ New User</a></li>
       	</ul>
      	</div>
      	<div class="container tab-body" id="contact_body">
      	<div class="row" style=" height: 100%; ">
       		<div class="col-sm-3 contact-container contactListContainer">
				<div class="navbar navbar-default nav-contact-panel" role="navigation" id="cancel-contact" >
					<a class="btn btn-default btn-sm pull-right give-margin" id=cancel-contact-button>X Cancel</a>
				</div>
				<div class="nav-contact-panel" role="navigation" id="userListContainer"></div>
			</div>
			<div class="contact-container col-sm-4 " id="userInfo">
       		<img style="position:absolute;top:50%;right:25%;display:block;" src="img/empty_contact.png">
       	</div>
       	<div class="col-sm-5 " id='person_col3_holder'>
      	</div>
       	</div>
  	</div>
     </div>
    </div>
        	</script>
<script type="text/template" id="userFormTemplate">
 		<form class="form" style="margin-top: 25px;" id="user-form">
  		<div class="row">
  			<div class="col-sm-4">
  				<label>First Name</label>
  			</div>
  			<div class="col-sm-8">
  				<div class="form-group">
					<input type = "hidden" name="id" id="id" value="">
  					<input class="form-control" placeholder="First Name" name="firstName" id="fName">
  				</div>
  			</div>
  		</div>
  		<div class="row">
  			<div class="col-sm-4">
  				<label>Last Name</label>
  			</div>
  			<div class="col-sm-8">
  				<div class="form-group">
  					<input class="form-control" placeholder="Last Name" name="lastName" id="lName">
  				</div>
  			</div>
  		</div>
  		<div class="row">
  			<div class="col-sm-4">
  				<label>User Name</label>
  			</div>
  			<div class="col-sm-8">
  				<div class="form-group">
  					<input class="form-control" placeholder="Email Address" name="userName" id="email">
  				</div>
  			</div>
  		</div>
  		<div class="row">
  			<div class="col-sm-4">
  				<label>Password</label>
  			</div>
  			<div class="col-sm-8">
  				<div class="form-group">
  					<input type = "password" class="form-control" placeholder="Password" name="password" id="password">
  				</div>
  			</div>
  		</div>
  		<div class="row">
  			<div class="col-sm-4">
  				<label>User Type</label>
  			</div>
  			<div class="col-sm-8">
  				<div class="form-group">
  					<select class="form-control" id="userType" name="userType">
  						<option value="staff">Staff</option>
  						<option value="admin">Admin</option>
  					</select>
  				</div>
  			</div>
  		</div>
  			<div class="row">
				<div class="col-sm-12">
					<button type="submit" class="btn btn-success" id="person-submit">Save User</button>
					<button type="reset"  class="btn btn-default">Reset</button>
				</div>
  			</div>
  		</div>
 </form>
    	</script>
	
	<script type="text/javascript" src="lib/js/underscore-min.js"></script>
	<script type="text/javascript" src="lib/js/jquery-1.10.2.js"></script>
	<script type="text/javascript" src="lib/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="lib/js/backbone-min.js"></script>
	<script type="text/javascript" src="lib/js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="lib/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="js/commonFunction.js"></script>
	
	<!-- Model -->
	<script type="text/javascript" src="js/model/UserModel.js"></script>
	
	<!-- Collection -->
	<script type="text/javascript" src="js/collection/UserCollection.js"></script>
	
	<!-- Views -->
	<script type="text/javascript" src="js/view/UserFormView.js"></script>
	<script type="text/javascript" src="js/view/UserBaseView.js"></script>
	
	<!-- Router -->
	<script type="text/javascript" src="js/AdminRouter.js"></script>
</body>
</html>