<%@ page contentType="text/html; charset=ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<title>Log In | Artist</title>
		<link rel="stylesheet" href="../Styles.css">
		
	</head>
	<header>
		<nav>
			<ul id="nav-list">
			<li class="nav-link link"><a href="../index.jsp">Find4You</a></li>
			<li class="nav-link"><a href="../User/login.jsp">User</a></li>
			<li class="nav-link active"><a href="Signup.jsp">Artist</a></li>
			</ul>
		</nav>
	</header>

	<form action="loginAction.jsp" method="post">
		<fieldset class="detail">
		<legend>Login Form</legend>
		<label>Email Id</label>
		<input type="text" name="email" required autofocus />
		<label>Password</label>
		<input type="password" name="password" required />
		</fieldset>
		<%
		String msg = request.getParameter("msg");
		if("notfound".equals(msg)){
			%>
			<div class="message">
				<h3 class="red">Warning : User Not Found!</h3>
			</div>
			<%
		}else if("wrong".equals(msg)){
			%> 
			<div class="message">
				<h3 class="red">Warning : Password Entered is Wrong!</h3>
			</div>
			<%
		}else if("success".equals(msg)){
			%> 
			<div class="message">
				<h3 class="green">Success! Account is created Successfully!</h3>
			</div>
			<%
		}else if("blocked".equals(msg)){
			%> 
			<div class="message">
				<h3 class="red">Your account was blocked!</h3>
			</div>
			<%
		}
		
		%>
		
		<fieldset class="buttons">
		<button class="green">Submit</button>
		<button class="red" type="reset" >Clear</button>
		<a href="Signup.jsp"><button type="button" >Sign Up</button></a>
		</fieldset>
		
	</form>
	