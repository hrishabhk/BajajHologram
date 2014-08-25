<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			    	<li id="home"><a href="./index.do">Home</a></li>
			    	<%if(session.getAttribute("firstname")==null){ %><li id="signin"><a href="./login.do" data-backdrop="static" data-toggle="modal">SignIn</a></li><%} %>
				    <%if(session.getAttribute("adminLogin")!=null && (Boolean)session.getAttribute("adminLogin")){ %><li id="admin"><a href="./admin.do" >Admin</a></li><%} %>
				   <%if(session.getAttribute("firstname")!=null){ %> <li id=logout><a href="./logout.do">Logout</a></li><%} %>
			    </ul>
	    	</div>
	    </div>
    </div>
