<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Personal_bbs.*" %>
<%@ page import = "user.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>personal_bbs LIST</title>
</head>
<body>
<%
	String user_id = null;
	UserDAO user = new UserDAO(); 
	if(session.getAttribute("user_id") != null) {
		user_id = session.getAttribute("user_id").toString();
	}	
%>
<%
	if(user_id.equals(request.getParameter("user_id"))) {
%>
		<form action="write.jsp" method="post">
			<input type="submit" value="글 작성" style="border: none; border-radius: 10px; padding: 5px; background-color: red; color: white;">
		</form>
<%
	}
%>

	<div style="padding-bottom: 50px">
	<%
		Personal_bbsDAO dao = new Personal_bbsDAO();
		List<Personal_bbsVO> bbs_list = dao.bbs_list();
		for(int i = 0; i < bbs_list.size(); i++){
			String title = bbs_list.get(i).getBbs_title();
			String date = bbs_list.get(i).getBbs_date();
			String content = bbs_list.get(i).getBbs_content();		
	%>
			<table border="1" align="center" width="700">
				<tr align="center">
					<td colspan="2" width="500" height="80"><%= title %></td>
					<td width="200"><%= date %></td>
				</tr>
				<tr align="center">
					<td colspan="3" height="200"><%= content %></td>
				</tr>
				<br>
				<br>
			</table>
	<%
		}
	%>
	</div>
</body>
</html>