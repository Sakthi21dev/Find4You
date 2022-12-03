<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<%
	String id = request.getParameter("id");
	System.out.print(id);
	try{
	Connection con = ConnectionProvider.getcon();
	PreparedStatement ps = con.prepareStatement("Delete from Request where id = ?");
	ps.setInt(1,Integer.parseInt(id));
	ps.executeUpdate();
	System.out.print(ps);
	response.sendRedirect("Dashboard.jsp?msg=success");
	}catch(Exception e){
		response.sendRedirect("Dashboard.jsp?msg=failed");
		System.out.print(e);
	}
%>