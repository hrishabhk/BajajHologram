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
			    	<li id="home"><a href="./">Home</a></li>
			    	<%if(session.getAttribute("user")==null){ %><li id="signin"><a href="#signIn" data-backdrop="static" data-toggle="modal">SignIn</a></li><%} %>
				    <%if(session.getAttribute("user")!=null){ %><li id="profile"><a href="./detail" id="profile">Profile</a></li><%} %>
				   <%if(session.getAttribute("user")!=null){ %> <li id=friend><a href="./friend">Search</a></li><%} %>
				    <%if(session.getAttribute("user")!=null){ %> <li id=image><a href="./image">Images</a></li><%} %>
				    <%if(session.getAttribute("user")!=null){ %> <li id=video><a href="./video">Video</a></li><%} %>
				   <%if(session.getAttribute("user")!=null){ %> <li id=logout><a href="./logout">Logout</a></li><%} %>
			    </ul>
	    	</div>
	    </div>
    </div>
