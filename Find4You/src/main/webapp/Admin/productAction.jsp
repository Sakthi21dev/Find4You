<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Connection.ConnectionProvider" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>processing..</title>
</head>
<%
	try{
	String id = request.getParameter("id");
	String msg = request.getParameter("msg");
	Connection con = ConnectionProvider.getcon();
	PreparedStatement ps = con.prepareStatement("UPDATE Products SET product_Status = ? where id = ?");
	ps.setString(1, msg);
	ps.setString(2, id);
	ps.executeUpdate();
	response.sendRedirect("Dashboard.jsp?msg=success");
	}catch(Exception e){
		System.out.println(e);
		response.sendRedirect("Dashboard.jsp?msg=failed");
	}
%>
<body>

</body>
</html>