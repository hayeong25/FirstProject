<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="notice.NoticeDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="notice" class="notice.Notice" scope="page"/>
<jsp:setProperty name="notice" property="notice_title"/>
<jsp:setProperty name="notice" property="notice_content"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DDORAEE WORLD</title>
</head>
<body>
	<%
		UserDAO user = new UserDAO();
		PrintWriter outter = response.getWriter();
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String) session.getAttribute("user_id");
		}
		
		if(!user.permission(user_id)){
			outter.println("<script>");
			outter.println("alert('권한이 없습니다.')");
			outter.println("history.back()");
			outter.println("</script>");
		}else{
			if(notice.getNotice_title() == null || notice.getNotice_content() == null){
				outter.println("<script>");
				outter.println("alert('입력하지 않은 사항이 있습니다.')");
				outter.println("history.back()");
				outter.println("</script>");
			}else{
				NoticeDAO noticeDAO = new NoticeDAO();
				int result = noticeDAO.write(notice.getNotice_title(), user_id, notice.getNotice_content());
				if(result == -1){
					outter.println("<script>");
					outter.println("alert('데이터베이스 오류로 인해 글쓰기에 실패하셨습니다.')");
					outter.println("history.back()");
					outter.println("</script>");
				}else{
					outter.println("<script>");
					outter.println("alert('성공적으로 게시되었습니다.')");
					outter.println("location.href = 'notice.jsp'");
					outter.println("</script>");
				}
			}
		}
	%>
</body>
</html>