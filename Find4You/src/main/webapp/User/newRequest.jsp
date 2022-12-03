<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  %>
<!DOCTYPE html>
<html lang="en">
	<head>
		
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="../Styles.css">
		<title>New Request</title>
	</head>
	<body>
		<header>
			<nav>
				<ul id="nav-list">
				<li class="nav-link"><a>Find4You</a></li>
				<li class="nav-link"><a href="Dashboard.jsp"><i class="material-icons">arrow_back</i></a></li>
				</ul>
			</nav>
		</header>
		<%	
			if(session.getAttribute("userId")==null){
				response.sendRedirect("login.jsp");
			}
			String userId = (String) session.getAttribute("userId");
			try{
				Connection con = ConnectionProvider.getcon();
				PreparedStatement ps ;
					%>
		<form action="requestAction.jsp" method="post" >
		<fieldset>
		<input type="hidden" name="userId" value="<%=userId%>" required>
		<label>Title</label>
		<input type="text" name="title"  required/>
		<% 
				ps = con.prepareStatement("Select distinct category from Category");
				ResultSet rs2 = ps.executeQuery();
				
		%>
		<label>Category</label>
		<select name="category" required>
			<%
			while(rs2.next())
			{ %>
			<option  ><%=rs2.getString(1) %></option>
			<% 
			} %>
		</select>
		<label>Description</label>
		<textarea maxlength="200" cols="30" name="description" required placeholder="describe here..." ></textarea>
		</fieldset>
		<fieldset class="buttons">
		<button class="green" type="submit"><i class="material-icons">done</i></button>
		<button class="red" type="reset"><i class="material-icons">close</i></button>
		</fieldset>
		</form>
			<% 
			}catch(Exception e){
				e.printStackTrace();
			}
				%>
</body>
</html>