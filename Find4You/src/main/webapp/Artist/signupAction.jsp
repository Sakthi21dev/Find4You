<%@ page import="Connection.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<% 
	//Variables declaration 
	String fname,lname,dob,email,phoneno,password,cnfm_password;
	fname = lname = dob = email = phoneno  = password = cnfm_password = "";
	
	//Assigning Values
	fname = request.getParameter("fname");
	lname = request.getParameter("lname");
	dob = request.getParameter("dob");
	email = request.getParameter("email").toLowerCase();
	phoneno = request.getParameter("phoneno");
	password = request.getParameter("password");
	//Creating Connection
	try{
		
		Connection con = ConnectionProvider.getcon();
		PreparedStatement ps = con.prepareStatement("Select * from Artists where email_Id = ?");
		ps.setString(1,email);
		ResultSet rs = ps.executeQuery();
		if(rs.next()){
			response.sendRedirect("./Signup.jsp?msg=found");
		}else 
		if(password.equals(request.getParameter("cnfm_password")))
		{
	
		 con = ConnectionProvider.getcon();
		 ps = con.prepareStatement("Insert into Artists(first_Name, last_Name, date_Of_Birth, email_Id, password, phone_No, artist_status)  Values(?,?,?,?,?,?,?)");
		//PreparedStatement ps = con.prepareStatement("Insert into Users Values('Sak','last','dob','mail','76')");
	    ps.setString(1, fname);
		ps.setString(2, lname);
		ps.setString(3, dob);
		ps.setString(4, email);
		ps.setString(5, password);
		ps.setString(6, phoneno);
		ps.setString(7,"open");
		ps.execute(); 
		
		response.sendRedirect("./login.jsp?msg=success");
		}
		else
		{
		response.sendRedirect("./Signup.jsp?msg=mismatch");
		}
    
	}catch(Exception e){
		System.out.println(e);
		response.sendRedirect("./Signup.jsp?msg=error");
	}
	
%>