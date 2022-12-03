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
		<title>Add Product</title>
	
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
		<form method="POST" action="../FileUploadServlet" enctype="multipart/form-data" >
            <fieldset>
						<legend>Add Product</legend>            	
            	<label>Title</label>
            	<input type="text" name="title" placeholder="e.g: Title" required>
            	<label>Description</label>
            	<textarea name="description" maxlength="200" placeholder="describe here" required></textarea>
            	<label>Image</label>
            	<input type="file" name="file" id="imgInp" accept="image/*" /> 
            	<img alt="Product-Image" id="preImg" Style="width:100%" src="" >
            	<script>
            	imgInp.onchange = evt => {
            		  const [file] = imgInp.files
            		  if (file) {
            		    preImg.src = URL.createObjectURL(file)
            		  }
            		}
            		
            	</script>
            	
            	<input type="hidden" name="userId" value="<%=artistId%>">
 				
            
            
            </fieldset>
            <fieldset class="buttons">
            	
            	<button class="green" type="submit" name="upload" id="upload"> Upload </button>
            	<button class="red" type="reset">Clear</button>
            
            </fieldset>
            
        </form>
</body>
</html>