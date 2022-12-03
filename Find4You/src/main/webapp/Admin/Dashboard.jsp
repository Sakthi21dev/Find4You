<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="../Styles.css"><title>Dashboard</title>
	</head>
	<body>
	<header>
	<nav>
	<ul id="nav-list">
	<li class="nav-link"><a href="">Find4You</a></li>
	<li class="nav-link"><a href="#user">Users</a></li>
	<li class="nav-link"><a href="#artist">Artists</a></li>
	<li class="nav-link"><a href="#payment">payment</a></li>
			<li class="nav-link"><a href="../logout.jsp" ><i class="material-icons">logout</i></a></li>
	</ul>
	</nav>
	<%
		String msg = request.getParameter("msg");
		if("success".equals(msg)){
			%> 
			<div class="message">
				<h3 class="green">Request Success!</h3>
			</div>
			<%
		}else if("failed".equals(msg)){
			%>
			<div class="message">
				<h3 class="red">Request failed!</h3>
			</div>
		<%}
	
	%>
	</header>
	
	<section id="user">
	<% 
	
	Connection con = ConnectionProvider.getcon();
	PreparedStatement ps = con.prepareStatement("Select * from users");
	ResultSet rs = ps.executeQuery();
	%>
	<table>
			<tr>
				<th>User Name</th>
				<th>Email Id</th>
				<th>Phone Number</th>
				<th>Action</th>
			</tr>
			<%while(rs.next()){ %>
			<tr>
				<td><%=rs.getString("first_Name")+" "+rs.getString("last_Name") %></td>
				<td><%=rs.getString("email_Id") %></td>
				<td><%=rs.getString("phone_No") %></td>
				<%if(rs.getString("user_Status").equals("block")){ %>
				<td><a href="accountAction.jsp?msg=open&user=<%=rs.getString(1)%>"><button class="green" type="button">Unblock</button></a></td>				
				<%}else if(rs.getString("user_Status").equals("paid")){ %>
				<td><a href="accountAction.jsp?msg=open&user=<%=rs.getString(1)%>"><button class="green" type="button">Activate</button></a></td>
				<%}else if(rs.getString("user_Status").equals("open")){ %>
				<td><a href="accountAction.jsp?msg=block&user=<%=rs.getString(1)%>"><button class="red" type="button">Block</button></a></td>
				<%}else if(rs.getString("user_Status").equals("pending")){ %>
				<td>Not Paid</td>
				<%} %>
			</tr>
			<% 
			
				}%>
	
	
	</table>
	</section>
	<section id="artist">
		<% 
			 ps = con.prepareStatement("Select * from artists");
			 rs = ps.executeQuery();
		%>
	<table>
			<tr>
				<th>Artist Name</th>
				<th>Email Id</th>
				<th>Phone number</th>
				<th>Category</th>
				<th>Action</th>
			</tr>
			<%while(rs.next()){ %>
			<tr>
				<td><%=rs.getString(1)+" "+rs.getString(2) %></td>
				<td><%=rs.getString(5) %></td>
				<td><%=rs.getString(7) %></td>
				<td><%=rs.getString(4) %></td>
				<%if(rs.getString(8).equals("block")){ %>
				<td><a href="artaccountAction.jsp?msg=open&user=<%=rs.getString(5)%>"><button class="green" type="button">Unblock</button></a></td>				
				<%}else if(rs.getString(8).equals("open")){ %>
				<td><a href="artaccountAction.jsp?msg=block&user=<%=rs.getString(5)%>"><button class="red" type="button">Block</button></a></td>
				<%} %>
			</tr>
			<% 
			
				}%>
	
	
	</table>
	
	</section>
	<section id="payment">
			<% 
			 ps = con.prepareStatement("Select * from payment");
			 rs = ps.executeQuery();
		%>
	<table>
			<tr>
				<th>Payment Id</th>
				<th>Transaction Id</th>
				<th>From</th>
			</tr>
			<%while(rs.next()){ %>
			<tr>
				<td><%=rs.getString(1)%></td>
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
			</tr>
			<%}%>
	
	</table>
	
		
	</section>
	<div class="gallery" id="products">
	<h1>Products</h1>
			<% 
			 ps = con.prepareStatement("Select * from products where product_Status = 'pending'");
			 rs = ps.executeQuery();
			 while(rs.next()){
		%>
				<figure>
				
					<img src="../Product/<%=rs.getString("location") %>" alt="Product-image" />
					<figcaption>
					Title : <%=rs.getString(2) %><br/>
					Description : <%=rs.getString(3) %>
					<br>	
					<a href="productAction.jsp?id=<%=rs.getString(1)%>&msg=approved"><button class="green">Approve</button></a>
					<a href="productAction.jsp?id=<%=rs.getString(1)%>&msg=denied"><button class="red">Deny</button></a>
					</figcaption>
				</figure>	
				<%} %>
		
	</div>
	
</body>
</html>