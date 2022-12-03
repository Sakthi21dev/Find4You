<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<%
	String email =  request.getParameter("email"); 
	String password = request.getParameter("password");
	try{
	Connection con = ConnectionProvider.getcon();
	PreparedStatement ps = con.prepareStatement("Select id,email_Id, password,user_Status from Users where email_Id = ?");
	ps.setString(1, email);
	ResultSet rs = ps.executeQuery();
	if(!rs.next()){
		response.sendRedirect("login.jsp?msg=notfound");
	}
		do{
			if(password.equals(rs.getString(3))){
				String status = rs.getString(4);
			if("pending".equals(status)){
				response.sendRedirect("payment.jsp?userId="+rs.getString(1));
			}else if("open".equals(status)){
				session.setAttribute("userId",rs.getString(1));
				response.sendRedirect("Dashboard.jsp"); 
			}else if("paid".equals(status)){
				response.sendRedirect("login.jsp?msg=review");
			}
			}else{
				response.sendRedirect("login.jsp?msg=wrong");
			}
					
		
		}while(rs.next());
	
	}catch(Exception e){
		System.out.println("EXCEPTION FOUND! IN LOGIN\n"+e);
		e.printStackTrace();
	}
%>