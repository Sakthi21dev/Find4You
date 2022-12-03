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
		String userId=null;
		if(session.getAttribute("userId")==null){
			response.sendRedirect("login.jsp");
		}else{
			userId = (String) session.getAttribute("userId");
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
		PreparedStatement ps = con.prepareStatement("Select * from message_details where user_Id = ?");
		ps.setString(1, userId);
		ResultSet rs = ps.executeQuery();
		%>
		<table>
			<tr>
				<th>Request Id</th>
				<th>From</th>
				<th>Message</th>
				<th>Action</th>
			</tr>
			<%	if(!rs.next()){
				%> 
				<tr ><td colspan="3">New Messages are shown here.</td></tr>				
				<%		
			}else{
			do{ %>
			<tr>
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString("user_name") %></td>
				<td><%=rs.getString("message") %></td>
				<%
				String status = rs.getString("message_status");
				if(status.equals("sent")){
		%>
				<td>
				<a  href="messageAction.jsp?id=<%=rs.getString("message_Id") %>&msg=accepted&reqid=<%=rs.getString(1)%>"><button class="green" type="button">Accept</button></a>
				<a  href="messageAction.jsp?id=<%=rs.getString("message_Id") %>&msg=denied&reqid=<%=rs.getString(1)%>"><button class="red" type="button">Deny</button></a>
				</td>
				<%
				}else if(rs.getString("message_status").equals("accepted")){ %>
					<td><a href='mailto:<%=rs.getString("User_email")%>' ><button type="button">Send Mail</button></a> 
			<%	}else if(rs.getString("message_status").equals("denied")){ %>
				<td>Denied</td>
			<%}
				%>
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