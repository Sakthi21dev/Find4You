<%@ page contentType="text/html; charset=ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<title>Log In | User</title>
		<link rel="stylesheet" href="../Styles.css">
		
	</head>
	<body>
	<header>
		<nav>
			<ul id="nav-list">
			<li class="nav-link link"><a href="../index.jsp">Find4You</a></li>
			<li class="nav-link active"><a href="Signup.jsp">User</a></li>
			<li class="nav-link"><a href="../Artist/login.jsp">Artist</a></li>
			</ul>
		</nav>
	</header>
	
	<form action="loginAction.jsp" method="post">
	
		
		<fieldset class="detail">
		<legend>Login Form</legend>
		<label>Email Id</label>
		<input type="text" name="email" autofocus required />
		
		<label>Password</label>
		<input type="password" name="password" required />
		
		</fieldset>
		<%
		String msg = request.getParameter("msg");
		if("notfound".equals(msg)){
			%>
			<div class="message">
				<h3>Warning : User Not Found!</h3>
			</div>
			<%
		}else if("wrong".equals(msg)){
			%> 
			<div class="message">
				<h3>Warning : Password Entered is Wrong!</h3>
			</div>
			<%
		}else if("review".equals(msg)){
			%> 
			<div class="message">
				<h3>Warning : account is under review!</h3>
			</div>
			<%
		}else if("success".equals(msg)){
			%> 
			<div class="message">
				<h3>Warning : account is created successfully!</h3>
			</div>
			<%
		}
		
		
		%>
		
		<fieldset class="buttons">
		<button class="green" >Submit</button>
		<button class="red" type="reset" >Clear</button>
		<a href="Signup.jsp"><button type="button" >Sign Up</button></a>
		</fieldset>
		
	</form>
	</body>
</html>