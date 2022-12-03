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
		<title>Message</title>
	</head>
	<body>
	<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  %>	
	<%
		String artistId = "";
		if(session.getAttribute("artistId")==null){
			response.sendRedirect("login.jsp");
		}else{
			artistId =(String) session.getAttribute("artistId");
		}
		%>
		<header>
			<nav>
				<ul id="nav-list">
				<li class="nav-link"><a>Find4You</a></li>
				<li class="nav-link"><a href="Dashboard.jsp" ><i class="material-icons">arrow_back</i></a></li>
				</ul>
			</nav>
		</header>
		
		
		<%
		try{
		Connection con = ConnectionProvider.getcon();
		PreparedStatement ps = con.prepareStatement("Select * from message_details where Artist_Id = ?");
		ps.setString(1, artistId );
		ResultSet rs = ps.executeQuery();
		%>
		<table>
			<tr>
				<th>Name</th>
				<th>Message</th>
				<th>Status</th>
			</tr>
			<%	if(!rs.next()){
				%> 
				<tr ><td colspan="3">New Messages are shown here.</td></tr>				
				<%		
			}else{
			do{ %>
			<tr>
				<td><%=rs.getString("user_Name") %></td>
				<td><%=rs.getString("message") %></td>
				<%if("accepted".equals(rs.getString("message_Status"))) {%>
				<td><a href='mailto:<%=rs.getString("User_email") %>'><button type="button">Send  Mail</button></a></td>
				<%}else{ %>
				<td><%=rs.getString("message_Status") %></td>
				<%}%>
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