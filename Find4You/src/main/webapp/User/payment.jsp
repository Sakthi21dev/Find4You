<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  %>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="../Styles.css">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<title>Payment</title>
</head>
<body>
	<section>
		<form action="paymentAction.jsp" method="post" autocomplete="off">
		<fieldset class="image">
			<h2>Pay Here</h2>
			<img alt="payment img" src="payment.jpg" height="200"  width="200">
		</fieldset>
		<fieldset class="detail">
			<input type="hidden" value="<%=request.getParameter("userId") %>" name="userId" />
			<label>Transaction Id</label>
			<input type="text" name="trans_Id" required>
			<label>Payment</label>
			<input type="number" value="50" disabled>
		</fieldset>
		<fieldset class="buttons">
			<a class="green" href="paymentAction.jsp"><button>Pay ₹50</button></a>
		</fieldset>
		</form>
	</section>
</body>
</html>