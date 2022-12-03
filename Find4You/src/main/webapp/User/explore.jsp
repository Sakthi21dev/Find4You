<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  %>
<!DOCTYPE html>
<html lang="en">
	<head>
		
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="../Styles.css">
		<script src="https://kit.fontawesome.com/c75669dbd2.js" crossorigin="anonymous"></script>
		<title>Explore</title>
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
			if(session.getAttribute("userId")==null){
				response.sendRedirect("login.jsp");
			}
			String userId = (String)session.getAttribute("userId"); 
			
			try{
				
				Connection con = ConnectionProvider.getcon();
				PreparedStatement ps = con.prepareStatement("Select * from products where product_Status = 'approved' order by RAND () ");
				ResultSet rs = ps.executeQuery();
				
				while(rs.next()){
			%>
				<a href="/Find4You/exploreProduct/Productview.jsp?id=<%=rs.getString(1)%>">
				<figure>
				
					<img src="../Product/<%=rs.getString("location") %>" alt="Product-image" />
					<figcaption>
					Title : <%=rs.getString(2) %><br/>
					Description : <%=rs.getString(3) %>
					<br>	
					
					</figcaption>
				</figure>	
				</a>
				
				


			<%	
				}
			}catch(Exception e){
				System.out.println(e);
			}
			 %>
			 </div>
		</body>
</html>