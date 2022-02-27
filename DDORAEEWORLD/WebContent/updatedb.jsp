<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page session = "true" %>
<% request.setCharacterEncoding("UTF-8");%>
<%

	String user_id = null;
	if(session.getAttribute("user_id") != null){
		user_id = session.getAttribute("user_id").toString();
	}
	String self_comment = request.getParameter("self_comment");
	UserDAO dao = new UserDAO();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
<title>자기소개 수정</title>
<style>
* {
	font-family: 'Gaegu', cursive;
	font-size: 15px;
}
</style>
</head>
<body>
<script>
function pop_close(){
	window.opener.location = "homepage.jsp"
	window.close();
}
</script>
	<%
		int result = dao.upload(user_id, self_comment);
		if(result == 1){
	%>
			수정완료!
			<input type="submit" value="돌아가기" onclick="pop_close()">
	<%
		}else{
	%>
			수정 불가...시바
	<%
		}
	%>
</body>
</html>