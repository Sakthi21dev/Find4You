<%@ page contentType="text/html; charset=ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<title>Log In | Admin</title>
		<link rel="stylesheet" href="../Styles.css">
		
	</head>
	<body>
	<header>
		<nav>
			<ul id="nav-list">
			<li class="nav-link"><a href="../index.jsp">Find4You</a></li>
			<li class="nav-link"><a href="../User/login.jsp">User</a></li>
			<li class="nav-link"><a href="../Artist/login.jsp">Artist</a></li>
			</ul>
		</nav>
	</header>
	
	<form action="loginAction.jsp" method="post">
		<fieldset class="detail">
		<legend>Login Form</legend>
		<label>Username</label>
		<input type="text" name="username" required  autofocus/>
		<label>Password</label>
		<input type="password" name="password" required />
		</fieldset>
		<%
		String msg = request.getParameter("msg");
		if("wrong".equals(msg)){
			%> 
			<div class="message red">
				<h3>Warning : Password Entered is Wrong!</h3>
			</div>
			<%
		}%>
		
		<fieldset class="buttons">
		<button>Submit</button>
		<button type="reset" >Clear</button>
		</fieldset>
		
	</form>
	</body>
	</html>