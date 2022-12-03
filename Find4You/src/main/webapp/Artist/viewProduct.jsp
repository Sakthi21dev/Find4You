<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="expires" content="0">		
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="../Styles.css">
		<title>View Products</title>
	</head>
	<body>
		<header>
			<nav>
				<ul id="nav-list">
				<li class="nav-link"><a>Find4You</a></li>
				<li class="nav-link"><a href="Dashboard.jsp"><i class="material-icons">arrow_back</i></a></li>
				</ul>
			</nav>
		</header>
		<div class="gallery">
		<%	
			if(session.getAttribute("artistId")==null){
				response.sendRedirect("login.jsp");
			}
			String artistId = (String)session.getAttribute("artistId"); 
			
			try{
			Connection con = ConnectionProvider.getcon();
			PreparedStatement ps = con.prepareStatement("Select * from products where artist_Id = ? order by id desc");
			ps.setString(1, artistId);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
			%>
			<figure <%if(rs.getString("product_status").equals("pending")){ %> class="border-yelllow" <%} %>>
				
					<img src="../Product/<%=rs.getString("location") %>" alt="Product-image" />
					<figcaption>
					Title : <%=rs.getString(2) %><br/>
					Description : <%=rs.getString(3) %>
					<br>
					<a href="editProduct.jsp?id=<%=rs.getString(1)%>"><button class="green"><i class="material-icons">edit</i></button></a>
					</figcaption>
			</figure>	
			
			<%	
			}
			}catch(Exception e){
				System.out.println(e);
				response.sendRedirect("Dashboard?msg=error");
			}
			
			%>
			</div>	
</body>
</html>