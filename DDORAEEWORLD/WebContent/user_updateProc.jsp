<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dao" class="user.UserDAO" />
<jsp:useBean id="vo" class="user.User" />
<jsp:setProperty name="vo" property="*" />
<%
	String user_id = (String)session.getAttribute("user_id");
	String user_password1 = (String)request.getParameter("user_password1");
	String user_password2 = (String)request.getParameter("user_password2");
	vo.setUser_id(user_id);
	vo.setUser_password(user_password1);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<body>
<%
	if(user_password1.equals(user_password2)){ 
		dao.updateUser(vo);
%>
	<script>
		alert('회원정보가 수정되었습니다.');
		location.href="index.jsp";
	</script>
<%
	} else {
%>
	<script>
		alert('비밀번호가 일치하지 않습니다.');
		history.back();
	</script>
<%
	}
%>
</body>
</html>