<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		
		<meta charset="utf-8">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="../Styles.css">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="Styles.css">
		<title>Edit Request</title>
	</head>
	<body>
	<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  %>
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
		String id = request.getParameter("id");
		try{
			Connection con = ConnectionProvider.getcon();
			PreparedStatement ps = con.prepareStatement("Select * from request where id = ?");
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
	%>
	<form action="editAction.jsp" method="post" >
	<fieldset>
	<input type="hidden" name="id" value="<%=id%>" required>
	<label>Title</label>
	<input type="text" name="title" value="<%=rs.getString(4) %>"  required/>
	<% 
			ps = con.prepareStatement("Select Category from category");
			ResultSet rs2 = ps.executeQuery();
			
	%>
	<label>Category</label>
	<select required name="category">
		<%while(rs2.next()){ %>
		<option <% if(rs2.getString(1).equals(rs.getString(3))){ %> Selected <%} %> ><%=rs2.getString(1) %></option>
		<%} %>
	</select>
	<label>Description</label>
	<textarea maxlength="200" cols="30" name="desc" required ><%=rs.getString(5)%></textarea>
	<label>Status</label>
	<select required name="status">
		<option value="Open" <%if(rs.getString(6).equalsIgnoreCase("Open")){  %> Selected <%}%> >Open</option>
		<option value="Closed" <%if(rs.getString(6).equalsIgnoreCase("Closed")){  %> Selected <%}%> >Closed</option>
	</select>
	
	</fieldset>
	<fieldset class="buttons">
	<button type="submit"><i class="material-icons green">done</i></button>
	<a href="deleteRequest.jsp?id=<%=id%>"><i class="material-icons red">delete</i></a>
	</fieldset>
	</form>
		<% }
		}catch(Exception e){
			e.printStackTrace();
		}
			%>
</body>
</html>