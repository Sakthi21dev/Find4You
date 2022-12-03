<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<%
	String email =  request.getParameter("email"); 
	String password =  request.getParameter("password");
	String  name = null;
	try{
	Connection con = ConnectionProvider.getcon();
	PreparedStatement ps = con.prepareStatement("Select id,first_name,last_Name,email_Id, password, artist_status from artists where email_Id = ?");
	ps.setString(1, email);
	ResultSet rs = ps.executeQuery();
	if(!rs.next()){
		response.sendRedirect("login.jsp?msg=notfound");
	}
		do{
			if(password.equals(rs.getString("password"))){
				if( "open".equals(rs.getString("artist_status")) )
				{
					session.setAttribute("artistId",rs.getString("id"));
					name = rs.getString("first_name")+" "+rs.getString("last_name");
					session.setAttribute("Name",name);
					response.sendRedirect("Dashboard.jsp");
				}else if( "block".equals(rs.getString("artist_status"))){
					response.sendRedirect("login.jsp?msg=blocked");
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