<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Connection.ConnectionProvider" %>

	<%
		String id = request.getParameter("id");
		String msg = request.getParameter("msg");
		String reqid = request.getParameter("reqid");
		try{
		Connection con = ConnectionProvider.getcon();
		PreparedStatement ps = con.prepareStatement("UPDATE message set message_status = ? where id = ?");
		PreparedStatement ps2;
		if("accepted".equals(msg)){
			
			ps.setString(1,"accepted");
			ps.setString(2,id);
			ps2 = con.prepareStatement("Update Request set request_Status = 'closed' where id = ?");
			ps2.setString(1, reqid);
			ps2.executeUpdate();
			
		}else if("denied".equals(msg)){
			
			ps.setString(1,"denied");
			ps.setString(2,id);
			
		}
		
		ps.executeUpdate();
		response.sendRedirect("./Dashboard.jsp?msg=success");
		}catch(Exception e){
			System.out.print(e);
			response.sendRedirect("./Dashboard.jsp");
		}
		
		%>