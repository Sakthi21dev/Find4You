<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Connection.ConnectionProvider" %>
<%@ page import="file.DeleteFile" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deleting..</title>
</head>
<body>
		<%
		try{
			Connection con = ConnectionProvider.getcon();
			PreparedStatement ps = con.prepareStatement("Select * from products where id = ?");
			String id = request.getParameter("id");
			ps.setString(1,id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
			String path ="D:\\Find4You\\src\\main\\webapp\\Product";
			String filename = rs.getString("location");
			
			if(DeleteFile.deletefile(path, filename)){
				ps = con.prepareStatement("Delete from products where id = ?");
				ps.setString(1,id);
				if(ps.executeUpdate()>0){
					response.sendRedirect("Dashboard.jsp?msg=success");
				}else{
					response.sendRedirect("Dashboard.jsp?msg=error");
				}
			}else{
				response.sendRedirect("Dashboard.jsp?msg=error");
			}
			
			}
		}catch(Exception e){
			System.out.println(e);
			response.sendRedirect("Dashboard.jsp?msg=error");
		}
		
		
		%>

</body>
</html>