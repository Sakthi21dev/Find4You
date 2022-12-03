<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Connection.ConnectionProvider" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="../Styles.css">
		<title>DashBoard | Home</title>
	
	</head>
	<body>
		<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  %>	
		<%
		String artistId = null;
		if(session.getAttribute("artistId")==null){
			response.sendRedirect("login.jsp");
		}else{
			artistId =(String) session.getAttribute("artistId");
			
		}
		%>
		<header>
			<h1>Welcome to Dashboard</h1>
			<nav>
				<ul id="nav-list">
				<li class="nav-link"><a>Find4You </a></li>
						<li class="nav-link"><a href="profile.jsp" ><i class="material-icons">person</i></a></li>
				<li class="nav-link"><a href="viewMessage.jsp" ><i class="material-icons">chat_bubble</i></a></li>
				<li class="nav-link"><a href="addProduct.jsp" ><i class="material-icons">add</i></a></li>
				<li class="nav-link"><a href="viewProduct.jsp" ><i class="material-icons">rate_review</i></a></li>
				<li class="nav-link"><a href="../logout.jsp" ><i class="material-icons">logout</i></a></li>
				
				</ul>
			</nav>
		</header>
		
		<div class="message">
		<% if("success".equals(request.getParameter("msg"))) { %>
			<h2 class="success green">Request Success</h2> <%} else 
				if("failed".equals(request.getParameter("msg"))){%>
			<h2 class="error red">Request failed</h2> <%} %>
		</div>
		
		<%
		try{
		Connection con = ConnectionProvider.getcon();
		PreparedStatement ps = con.prepareStatement("Select count(*) from category where artist_Id = ? ");
		ps.setString(1,artistId);
		ResultSet rs = ps.executeQuery();
		rs.next();
		if(rs.getInt(1)==0){
			%> 
			
			<div >
				<p class="red"> No Category is selected! Please select to receive requests.<a href="profile.jsp#Category"><button>Add</button></a></p>
			</div>
			
			<%
		}
		
		
		
		
		 ps = con.prepareStatement("Select * from request_details where category IN( select category from category where artist_Id = ?) AND request_Status = 'open';");
		 ps.setString(1, artistId );
		 rs = ps.executeQuery();
		%>
		<table>
			<tr>
				<th>Request Id</th>
				<th> Name </th>
				<th>Title</th>
				<th>Description</th>
				<th>Send Message</th>
			</tr>
			<%	if(!rs.next()){
				%> 
				<tr ><td colspan="5">New Requests are shown here.</td></tr>				
				<%		
			}else{
			do{ %>
			<tr>
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString("user_Name") %></td>
				<td><%=rs.getString(6) %></td>
				<td><%=rs.getString(7) %></td>
				<td><a href="message.jsp?id=<%=rs.getString(1) %>"><i class="material-icons green">reply</i></a></td>
			</tr>
		<%
		}while(rs.next());
		%>
		</table>
		<% %>
		
		
			<%
		}
		}	catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		}
		
	%>
	
	</body>
</html>