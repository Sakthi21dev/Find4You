<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="../Styles.css">
		<title>Message</title>
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
			if(null == session.getAttribute("artistId")){
				response.sendRedirect("login.jsp");
			}
			String artistId = (String)session.getAttribute("artistId");
			int id = Integer.parseInt(request.getParameter("id"));
			try{
				Connection con = ConnectionProvider.getcon();
				PreparedStatement ps = con.prepareStatement("Select * from request_details  where id = ?");
				ps.setInt(1, id);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
				%>
		<form action="messageAction.jsp" autocomplete="off" method="post" >
		<fieldset  >
		<label>From</label>
		<input type="hidden" name="artist_id" value="<%=artistId%>" readonly="readonly" required>
		<input type="text" value="<%=session.getAttribute("Name") %>">
		<label>To</label>
		<input type="hidden" name="user_id" value="<%=rs.getString("user_Id")%>" readonly="readonly" required>
		<input type="text" name="name" value="<%=rs.getString("user_Name")%>" readonly="readonly" required>
		<label>Title</label>
		<input type="text" name="title"  value="<%=rs.getString(6) %>" readonly="readonly" required/>
		<label>Id</label>
		<input type="text" name="id"  value="<%=rs.getString(1) %>" readonly="readonly" required/>
		</fieldset>
		<fieldset>
		<label>Message</label>
		<textarea maxlength="200" cols="30" name="message" required autofocus placeholder="type here..." ></textarea>
		</fieldset>
		<fieldset class="buttons">
		<button class="green" type="submit"><i class="material-icons">done</i></button>
		<button class="red" type="reset"><i class="material-icons">close</i></button>
		</fieldset>
		</form>
			<% }
			}catch(Exception e){
				e.printStackTrace();
			}
				%>
</html>