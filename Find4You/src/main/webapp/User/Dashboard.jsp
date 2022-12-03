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
		String userId=null;
		if(session.getAttribute("userId")==null){
			response.sendRedirect("login.jsp");
		}else{
			userId =  session.getAttribute("userId").toString();
		}
		%>
		<header>
			<h1>Welcome to Dashboard</h1>
			<nav>
				<ul id="nav-list">
				<li class="nav-link"><a>Find4You </a></li>
				<li class="nav-link"><a href="newRequest.jsp" ><i class="material-icons">add</i></a></li>
				<li class="nav-link"><a href="viewMessage.jsp" ><i class="material-icons">chat_bubble</i></a></li>
				<li class="nav-link"><a href="explore.jsp" ><i class="material-icons">search</i></a></li>
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
		PreparedStatement ps = con.prepareStatement("Select * from request where User_Id = ?");
		ps.setString(1, userId);
		ResultSet rs = ps.executeQuery();
		%>
		<table>
			<tr>
				<th>Request Id</th>
				<th>Title</th>
				<th>Description</th>
				<th>Category</th>
				<th>Status</th>
				<th>Edit</th>
			</tr>
			<%	if(!rs.next()){
				%> 
				<tr ><td colspan="6">New Requests are shown here.</td></tr>				
				<%		
			}else{
			do{ %>
			<tr>
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString(4) %></td>
				<td><%=rs.getString(5) %></td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(6) %></td>
				<td><a href="editRequest.jsp?id=<%=rs.getString(1) %>"><i class="material-icons">edit</i></a></td>
			</tr>
		<%
		}while(rs.next());
		%>
		</table>
		<%	
		}
		
		}catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		}
		
	%>		
	</body>
</html>