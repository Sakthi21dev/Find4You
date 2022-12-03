<%@ page import="java.sql.*,Connection.ConnectionProvider"%>
<% 
	
	String msg = request.getParameter("msg");
	String user_Id = request.getParameter("user");

	try{
	Connection con = ConnectionProvider.getcon();
	PreparedStatement ps = con.prepareStatement("UPDATE Users Set User_Status = ? where id = ?");
	ps.setString(1, msg);
	ps.setString(2, user_Id);
	ps.executeUpdate();
	response.sendRedirect("Dashboard.jsp?msg=success");
	}catch(Exception e){
		System.out.print(e);
		response.sendRedirect("Dashboard.jsp?msg=failed");
	}
%>