<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session = "true" %>
<%
	String user_id = null;
	if(session.getAttribute("user_id") != null){
		user_id = session.getAttribute("user_id").toString();
	}
	
	request.getAttribute("user_id");
	request.getAttribute("self_comment");
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
<form action="updatedb.jsp" method="post">
	<table>
		<tr>
			<td>자기소개 수정</td>
		</tr>
		<tr>
			<td>
				<textarea rows="10" cols="50" maxlength="20" placeholder="소개글 작성" name="self_comment"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<input type="submit" value="수정">
			</td>
		</tr>
	</table>
</form>
</body>
</html>