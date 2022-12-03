<%@ page import="java.sql.*,Connection.ConnectionProvider"  %>
<%
	String artistId = request.getParameter("artist_id");
	String userId = request.getParameter("user_id");
	String id = request.getParameter("id");
	String message = request.getParameter("message");
	
	try{
	Connection con = ConnectionProvider.getcon();
	PreparedStatement ps = con.prepareStatement("Insert into message(request_Id,from_Id,to_Id,message) Values(?,?,?,?)");
	ps.setString(1,id);
	ps.setString(2,artistId);
	ps.setString(3,userId);
	ps.setString(4,message);
	ps.executeUpdate();
	response.sendRedirect("Dashboard.jsp?msg=success");
	}catch(Exception e){
		response.sendRedirect("Dashboard.jsp?msg=failed");
		System.out.print(e);
	}
%>