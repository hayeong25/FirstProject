<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.*" %>
<%@ page session = "true" %>
<%
	String id = request.getParameter("user_id");
			UserDAO dao = new UserDAO();
			dao.login(request);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PASSWORD CHECK</title>
</head>
<body>
	<% 
		int result = dao.login(request);
		switch(result){
		case -1 : 
	%>
		<script>
			alert('오류가 발생했습니다.');
			history.back();
		</script>
	<% 
		break; 
		case 0 : 
	%>
		<script>
			alert('아이디 또는 비밀번호를 확인해주세요.');
			history.back();
		</script>
	<% 
		break;
		case 1 :
	%>
		<script>
			location.href="user_update.jsp";
		</script>
	<%
		session.setAttribute("user_id", id); 
	%>
	<%
		break; }
	%>
</body>
</html>