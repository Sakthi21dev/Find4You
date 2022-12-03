<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Adding</title>
</head>
<body>
		<%
		
		try{
			Connection con = ConnectionProvider.getcon();
			PreparedStatement ps = con.prepareStatement("Insert into Category(category,artist_Id) values(?,?)");
			ps.setString(1,request.getParameter("category").toUpperCase());
			ps.setString(2, session.getAttribute("artistId").toString());
			ps.executeUpdate();
			response.sendRedirect("profile.jsp#Category");
		}catch(Exception e){
			System.out.println(e);
			response.sendRedirect("Dashboard.jsp?msg=error");
		}
		
		
		%>

</body>
</html>