<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	session.invalidate();
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DDORAEE WORLD</title>
</head>
<body>
	<script>
		alert('성공적으로 로그아웃 되었습니다.');
		location.href="index.jsp";
	</script>
</body>
</html>