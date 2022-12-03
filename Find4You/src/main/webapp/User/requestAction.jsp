<%@ page import="java.sql.*,Connection.ConnectionProvider"  %>
<%
	String userId = request.getParameter("userId");
	String title = request.getParameter("title");
	String category = request.getParameter("category");
	String desc = request.getParameter("description");
	
	try{
	Connection con = ConnectionProvider.getcon();
	PreparedStatement ps = con.prepareStatement("Insert into Request(user_Id,Category,title,req_description) Values(?,?,?,?)");
	ps.setString(1,userId);
	ps.setString(2,category);
	ps.setString(3,title);
	ps.setString(4,desc);
	ps.executeUpdate();
	response.sendRedirect("Dashboard.jsp?msg=success");
	}catch(Exception e){
		response.sendRedirect("Dashboard.jsp?msg=failed");
		System.out.print(e);
	}
%>