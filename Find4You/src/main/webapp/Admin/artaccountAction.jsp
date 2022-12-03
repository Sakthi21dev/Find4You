<%@ page import="java.sql.*,Connection.ConnectionProvider"%>
<% 
	
	String msg = request.getParameter("msg");
	String user_Id = request.getParameter("user");

	try{
	Connection con = ConnectionProvider.getcon();
	PreparedStatement ps = con.prepareStatement("UPDATE Artists Set artist_Status = ? where email_Id = ?");
	ps.setString(1, msg);
	ps.setString(2, user_Id);
	ps.executeUpdate();
	response.sendRedirect("Dashboard.jsp?msg=success");
	}catch(Exception e){
		System.out.print(e);
		response.sendRedirect("Dashboard.jsp?msg=failed");
	}
%>