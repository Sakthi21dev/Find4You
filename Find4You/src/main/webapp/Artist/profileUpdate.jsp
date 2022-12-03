<%@ page import="Connection.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<% 
	
	//Assigning Values
	String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String dob = request.getParameter("dob");
    String email = request.getParameter("email").toLowerCase();
    String phoneno = request.getParameter("phoneno");
    String password = request.getParameter("password");
    String artistId = (String)session.getAttribute("artistId");
    
    if(!password.equals(request.getParameter("cnfm_password"))){
    	response.sendRedirect("profile.jsp?msg=mismatch");
    }
    
	//Creating Connection
	try{
		
		Connection con = ConnectionProvider.getcon();
		PreparedStatement ps = con.prepareStatement("UPDATE Artists SET first_Name = ?, last_Name = ?, date_Of_Birth = ?, email_Id = ?, password = ?, phone_No = ? WHERE id =  ?");
		//PreparedStatement ps = con.prepareStatement("Insert into Users Values('Sak','last','dob','mail','76')");
	    ps.setString(1, fname);
		ps.setString(2, lname);
		ps.setString(3, dob);
		ps.setString(4, email);
		ps.setString(5, password);
		ps.setString(6, phoneno);
		ps.setString(7,artistId);
		ps.execute(); 
		
		response.sendRedirect("./Dashboard.jsp?msg=success");
		
    
	}catch(Exception e){
		System.out.println(e);
		response.sendRedirect("./Dashboard.jsp?msg=error");
	}
	
%>