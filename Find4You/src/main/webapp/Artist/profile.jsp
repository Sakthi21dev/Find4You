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
		<title>Profile</title>
	
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
			<nav>
				<ul id="nav-list">
				<li class="nav-link"><a>Find4You</a></li>
				<li class="nav-link"><a href="Dashboard.jsp" ><i class="material-icons">arrow_back</i></a></li>
				</ul>
			</nav>
		</header>
		
		
	<form autocomplete="off" method="post" action="profileUpdate.jsp">
		<fieldset class="details">
			
			<legend>Registration Form</legend>
			
			<%

			Connection con = ConnectionProvider.getcon();
			PreparedStatement ps = con.prepareStatement("Select * from artists where id = ? ");
			ps.setString(1,artistId);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
			
			%>
			<label>First Name<span class="required">*</span></label>
			<input type="text" pattern="[A-Za-z]{3,50}" name="fname" value="<%=rs.getString("first_Name") %>" title="atleast 2 characters" placeholder="e.g Sakthi" autofocus required />
			
			<label>Last Name</label>
			<input type="text" pattern="[A-Za-z]{0,50}" name="lname" value="<%=rs.getString("last_Name") %>" placeholder="e.g saraboj" title="Alphabets only"/>
			
			<label>Date of Birth<span class="required">*</span></label>
			<input type="date"  name="dob" min="1960-01-01" value="<%=rs.getString("date_Of_Birth") %>" max="2004-12-31" required>
			
			<label>Phone number<span class="required">*</span></label>
			<input type="text" pattern="[6-9][0-9]{9}" name="phoneno" value="<%=rs.getString("phone_No") %>" title="Enter your phone number" placeholder="e.g 875434xx00" required>
			
			<label>Email<span class="required">*</span></label>
			<input type="email" name="email" maxlength="75" value="<%=rs.getString("email_Id") %>" title="Please enter a valid email id" placeholder="e.g example@email.com" required/>
			
			<label>Password<span class="required">*</span></label>
			<input type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!$&*#.,@]).{8,30}"  value="<%=rs.getString("password") %>"  name="password" placeholder="pa**word" required />
			
			<label>Confirm Password<span class="required">*</span></label>
			<input type="text" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!$&*#.,@]).{8,30}"  name="cnfm_password" value="<%=rs.getString("password") %>" placeholder="pa**word" required />
			
			
			</fieldset>
			<%} %>
	 		<div class="msg">
				<%
				String msg = request.getParameter("msg");
				if("mismatch".equals(msg)) 
				{ %>
				<h3 class="warning">Password mismatch</h3> 
				<% }
				else  if("error".equals(msg))
				{%>
				
				<h3 class="warning">Something went wrong. Please try later...</h3>
				<% } %>
				
			</div>
			<fieldset class="buttons" >
				
				<button type="submit" >Change</button>
				<button type="reset" >Clear</button>
			
			</fieldset>
			
	</form>
	<div id="Category">
	<form method="post" autocomplete="off" action="addCategory.jsp" >
		<fieldset>
			<legend>Add Category</legend>
			<label>Category</label>
			<%
				ps = con.prepareStatement("select distinct(category) from category where not category In (Select category from category where artist_Id = ?); ");
				ps.setString(1, artistId);
				PreparedStatement ps2 = con.prepareStatement("select category from category where artist_Id = ?");
				ps2.setString(1, artistId);
				rs = ps.executeQuery();
			    ResultSet rs2 = ps2.executeQuery();
			    while(rs.next()){
			%>
			<a href="addCategory.jsp?category=<%=rs.getString("category")%>"><button type="button" class="green"><%=rs.getString("category")%></button></a>
			<%} %>
			
			<label>Category Selected</label>
			
			<%
			boolean data = false;
			while(rs2.next())
			
			{ 
				data = true;
			%>
			
			<a href="removeCategory.jsp?cat=<%=rs2.getString("category")%>"><button type="button" class="green"><%=rs2.getString("category")%><i class="material-icons red">cancel</i></button></a>
			<%}
			if(!data){ %>
			<label class="red">No Category Selected!</label>
			<%} %>
			
			<label>Other</label>
			
				<input type="text" name="category">
				<button  type="submit">Add</button>
			</fieldset>
			</form>
			</div>
			
			

</body>
</html>