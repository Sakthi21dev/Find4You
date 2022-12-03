<%@ page import="Connection.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%
	String trans_Id = request.getParameter("trans_Id");
	String userId = request.getParameter("userId");
	try{
	Connection con = ConnectionProvider.getcon();
	PreparedStatement ps = con.prepareStatement("INSERT INTO payment(trans_Id,user_Id) Values(?,?);");
	ps.setString(1,trans_Id);
	ps.setString(2, userId);
	ps.executeUpdate();
	ps = con.prepareStatement("UPDATE USERS SET user_Status = 'paid' where id = ?");
	ps.setString(1,userId);
	ps.executeUpdate();
	response.sendRedirect("login.jsp?msg=success");
	}catch(Exception e){
		System.out.println(e);
		response.sendRedirect("login.jsp?msg=error");
	}
%>