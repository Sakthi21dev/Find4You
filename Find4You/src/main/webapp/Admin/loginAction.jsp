<%
			String username = request.getParameter("username");
			if(username.equals("Admin")&&"admin123".equals(request.getParameter("password"))){
				session.setAttribute(username, "email");
				response.sendRedirect("Dashboard.jsp");
			}else{
				response.sendRedirect("login.jsp?msg=wrong");
			}
		
	
	%>
	