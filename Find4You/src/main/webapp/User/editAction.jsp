<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<%
	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String category = request.getParameter("category");
	String desc = request.getParameter("desc");
	String Status = request.getParameter("status");

	try{
	Connection con = ConnectionProvider.getcon();
	PreparedStatement ps = con.prepareStatement("Update Request SET Category = ?, title = ? , req_Description = ? , request_Status = ? where id = ?");
	ps.setString(1,category);
	ps.setString(2,title);
	ps.setString(3,desc);
	ps.setString(4, Status);
	ps.setString(5,id);
	ps.executeUpdate();
	response.sendRedirect("Dashboard.jsp?msg=success");
	}catch(Exception e){
		response.sendRedirect("Dashboard.jsp?msg=failed");
		System.out.print(e);
	}
%>