<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Personal_bbs.Personal_bbsDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String bbs_title = request.getParameter("bbs_title");
	String bbs_writer = (String)session.getAttribute("user_id");
	String bbs_content = request.getParameter("bbs_content");
	Personal_bbsDAO dao = new Personal_bbsDAO();
	String result = dao.insert(bbs_title, bbs_writer, bbs_content);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script>
	alert("<%=result%>")
	document.location.href="personal_bbs.jsp";
</script>
</head>
<body>
<%-- <form action="personal_bbs.jsp" method="post">
<%=result %>
<input type="submit" value="확인"> --%>
</body>
</html>