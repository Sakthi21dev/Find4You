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
		<title>Edit Product</title>
	
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
		<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  %>	
		<%
		String artistId = null;
		if(session.getAttribute("artistId")==null){
			response.sendRedirect("login.jsp");
		}else{
			artistId =(String) session.getAttribute("artistId");
			
		}
			Connection con = ConnectionProvider.getcon();
			PreparedStatement ps =  con.prepareStatement("Select * from products where id = ?");
			ps.setString(1,request.getParameter("id"));
			ResultSet rs = ps.executeQuery();
			
		%>
		<form method="POST" action="../EditProduct" enctype="multipart/form-data" >
            <fieldset>
						<legend>Edit Product</legend>            	
            	<%while(rs.next()){ %>
            	<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
            	<input type="hidden" name="action" value="edit">
            	<label>Title</label>
            	<input type="text" name="title" placeholder="e.g: Title" value="<%=rs.getString("title") %>" required>
            	<label>Description</label>
            	<textarea name="description" maxlength="200" placeholder="describe here" required><%=rs.getString("pro_description") %></textarea>
            	
            	<label>Image</label>
            	<input type="file" name="file" id="imgInp"   accept="image/*" />
            	<img alt="Product-Image" id="preImg" Style="width:100%" src="../Product/<%=rs.getString("location") %>" > 
            	<script>
            	imgInp.onchange = evt => {
            		  const [file] = imgInp.files
            		  if (file) {
            		    preImg.src = URL.createObjectURL(file)
            		  }
            		}
            		
            	</script>
            	<input type="hidden" name="userId" value="<%=artistId%>">
 				<%} %>
            	
            
            </fieldset>
            <fieldset class="buttons">
            	
            	<button class="green" type="submit" name="upload" id="upload"> Change </button>
 				<a href="deleteProduct.jsp?id=<%=request.getParameter("id")%>"><button class="red" type="button"  > Delete </button></a>
            
            </fieldset>
            
        </form>
</body>
</html>