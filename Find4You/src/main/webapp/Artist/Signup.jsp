<%@ page import="Connection.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<title>Sign Up| Artist</title>
		<link rel="stylesheet" href="../Styles.css">
		
	</head>
	<body>
	<header>
		<nav>
			<ul id="nav-list">
			<li class="nav-link link"><a href="../index.jsp">Find4You</a></li>
			<li class="nav-link"><a href="../User/login.jsp">User</a></li>
			<li class="nav-link active"><a href="../Artist/login.jsp">Artist</a></li>
			</ul>
		</nav>
	</header>
	
	<form autocomplete="off" method="post" action="signupAction.jsp">
		<fieldset class="details">
			
			<legend>Registration Form</legend>
			
			<label>First Name<span class="required">*</span></label>
			<input type="text" pattern="[A-Za-z]{3,50}" name="fname" title="atleast 2 characters" placeholder="e.g Sakthi" autofocus required />
			
			<label>Last Name</label>
			<input type="text" pattern="[A-Za-z]{0,50}" name="lname" placeholder="e.g saraboj" title="Alphabets only"/>
			
			<label>Date of Birth<span class="required">*</span></label>
			<input type="date"  name="dob" min="1960-01-01" max="2004-12-31" required>
			
			<label>Phone number<span class="required">*</span></label>
			<input type="text" pattern="[6-9][0-9]{9}" name="phoneno" title="Enter your phone number" placeholder="e.g 875434xx00" required>
			
			<label>Email<span class="required">*</span></label>
			<input type="email" name="email" maxlength="75" title="Please enter a valid email id" placeholder="e.g example@email.com" required/>
			
			<label>Password<span class="required">*</span></label>
			<input type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!$&*#.,@]).{8,30}"  name="password" placeholder="pa**word" required />
			
			<label>Confirm Password<span class="required">*</span></label>
			<input type="text" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!$&*#.,@]).{8,30}"  name="cnfm_password" placeholder="pa**word" required />
			
			
			</fieldset>
	 		<div class="msg">
				<%
				String msg = request.getParameter("msg");
				if("mismatch".equals(msg)) 
				{ %>
				<h3 class="warning">Password mismatch</h3> 
				<% }
				else if("found".equals(msg))
				{%> 
				<h3 class="warning">User Already Found</h3> 
				<%}else if("error".equals(msg))
				{%>
				
				<h3 class="warning">Something went wrong. Please try later...</h3>
				<% } %>
				
			</div>
			<fieldset class="buttons" >
				
				<button type="submit" >Sign Up</button>
				<button type="reset" >Clear</button>
			
			</fieldset>
			
	</form>
	</body>
</html>