<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="notice.Notice"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
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
		if(user_id == null){
			outter.println("<script>");
			outter.println("alert('로그인이 필요한 작업입니다.')");
			outter.println("location.href='login.jsp'");
			outter.println("</script>");
		}
		int notice_seq = 0;
		if(request.getParameter("notice_seq") != null){
			notice_seq = Integer.parseInt((String) request.getParameter("notice_seq"));
		}
		
		if(notice_seq == 0){
			outter.println("<script>");
			outter.println("alert('유효하지 않은 글입니다.')");
			outter.println("location.href='notice.jsp'");
			outter.println("</script>");
		}
		Notice notice = new NoticeDAO().getNotice(notice_seq);
		if(!user.permission(user_id)){
			outter.println("<script>");
			outter.println("alert('권한이 없습니다..')");
			outter.println("location.href='notice.jsp'");
			outter.println("</script>");
		} else{
			NoticeDAO noticeDAO = new NoticeDAO();
			int result = noticeDAO.delete(notice_seq);
			if(result == -1){
				outter.println("<script>");
				outter.println("alert('글 삭제에 실패하셨습니다.')");
				outter.println("history.back()");
				outter.println("</script>");
			} else {
				outter.println("<script>");
				outter.println("alert('성공적으로 삭제되었습니다.')");
				outter.println("location.href = 'notice.jsp'");
				outter.println("</script>");
			}
		}
	%>
</body>
</html>