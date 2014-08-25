<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%String fname = (String)session.getAttribute("firstname") ;%>
<div class="navbar navbar-inverse navbar-static-top"> 
	    <div class="container">
	   <img class="navbar-brand" alt="" src="img/logo.png" width="130" height="30" >
		    <button class="navbar-toggle" data-toggle="collapse" data-target=".navHeaderCollapse">
			    <span class="icon-bar"></span>
			    <span class="icon-bar"></span>
			    <span class="icon-bar"></span>
		    </button>
		    <div class="collapse navbar-collapse navHeaderCollapse">
			    <ul class="nav navbar-nav navbar-right" id="links">
			    	<li><a href="#">Welcome
		    <%if(fname==null){ %>
		    	Guest
		    <%}else{ %>
		    	<%=fname.toUpperCase() %>
		    <%} %></a></li>
			    	<li id="home"><a href="./index.do">Home</a></li>
			    	<%if(fname==null){ %><li id="signin"><a href="./login.do" data-backdrop="static" data-toggle="modal">SignIn</a></li><%} %>
				    <%if(session.getAttribute("adminLogin")!=null && (Boolean)session.getAttribute("adminLogin")){ %><li id="admin"><a href="./admin.do" >Admin</a></li><%} %>
				   <%if(fname!=null){ %> <li id=logout><a href="./logout.do">Logout</a></li><%} %>
			    </ul>
	    	</div>
	    </div>
    </div>
