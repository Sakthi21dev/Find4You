<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Connection.ConnectionProvider" %>

<!DOCTYPE html>
<html>
<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="../Styles.css">
		<script src="https://kit.fontawesome.com/c75669dbd2.js" crossorigin="anonymous"></script>
		<title>Product</title>
</head>
<body>
	<%if(null == session.getAttribute("userId")){ %>
		<h1>Welcome to Find4You!</h1>
		<%}else{ %>
		<header>
		<nav>
		<ul id="nav-list">
		<li class="nav-link"><a>Find4You</a></li>
		<li class="nav-link"><a href="../User/Dashboard.jsp"><i class="material-icons">arrow_back</i></a></li>
		</ul>
		</nav>
		</header>
<%}
	 int id = 0;
	 if(request.getParameter("id") == null){
		 %>
		 <%
	 }
	 id = Integer.parseInt(request.getParameter("id"));
	try{
		
		Connection con = ConnectionProvider.getcon();
		PreparedStatement ps = con.prepareStatement("Select * from product_details where id = ? AND product_Status = 'approved'");
		ps.setInt(1,id );
		ResultSet rs = ps.executeQuery();
		
		if(rs.next()){ %>
		<div class="gallery">
		<figure>
		<img src="../Product/<%=rs.getString("location") %>" alt="product-image">
		<figcaption>
		<label><%=rs.getString("title") %></label>
		<label><%=rs.getString("pro_description") %></label>
		<br>
		<a href="mailto:<%=rs.getString("email_Id")%>"><button class="green"><i class="material-icons">mail</i></button></a>
		<a  href="https://wa.me/+91<%=rs.getString("phone_No")%>" target="_blank"><button class="green"><i class="fa-brands fa-whatsapp"></i></button></a>		
		<input type="text"  id="Url" value="http://localhost:8080/Find4You/exploreProduct/Productview.jsp?id=<%=id%>" readonly>
		<button class="green" onclick="copyText()"><i class="material-icons">share</i></button>
		</figcaption>
		</figure>
		</div>
		<script type="text/javascript">
		function copyText() {
			var text = document.getElementById("Url").value;
			navigator.clipboard.writeText(text).then(function() {
			  console.log('Copying to clipboard was successful!');
			}, function(err) {
			  console.error('Could not copy text: ', err);
			});
			}
		</script>
		<%}else{ %>
		
		<h2 class="red">Product not found or may be deleted or may not be approved.</h2>
		
		<%}}catch(Exception e){
			System.out.println(e);
			
		}%>
</body>
</html>