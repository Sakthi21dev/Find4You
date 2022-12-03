<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Removing</title>
</head>
<body>
		<%
		
		try{
			Connection con = ConnectionProvider.getcon();
			PreparedStatement ps = con.prepareStatement("Delete from Category Where artist_Id = ? AND Category = ?");
			ps.setString(1, session.getAttribute("artistId").toString());
			ps.setString(2,request.getParameter("cat").toUpperCase());
			ps.executeUpdate();
			response.sendRedirect("profile.jsp#Category");
		}catch(Exception e){
			System.out.println(e);
			response.sendRedirect("Dashboard.jsp?msg=error");
		}
		
		
		%>

</body>
</html>