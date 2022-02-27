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
<title>글 작성 페이지</title>
</head>
	<%
		UserDAO user = new UserDAO();
	%>
<body>
	<%
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
			notice_seq = Integer.parseInt(request.getParameter("notice_seq"));
		}
		if(notice_seq == 0){
			outter.println("<script>");
			outter.println("alert('유효하지 않은 글입니다.')");
			outter.println("location.href='notice.jsp'");
			outter.println("</script>");
		}
		if(!user.permission(user_id)){
			outter.println("<script>");
			outter.println("alert('권한이 없습니다..')");
			outter.println("location.href='notice.jsp'");
			outter.println("</script>");
		} else{
			if(request.getParameter("notice_title") == null || request.getParameter("notice_content") == null || request.getParameter("notice_title").equals("") || request.getParameter("notice_content").equals("")){
				outter.println("<script>");
				outter.println("alert('입력하지 않은 사항이 있습니다.')");
				outter.println("history.back()");
				outter.println("</script>");
			} else {
				NoticeDAO notice = new NoticeDAO();
				int result = notice.update(notice_seq, request.getParameter("notice_title"), request.getParameter("notice_content"));
				if(result == -1){
					outter.println("<script>");
					outter.println("alert('글 수정에 실패하셨습니다.')");
					outter.println("history.back()");
					outter.println("</script>");
				} else {
					outter.println("<script>");
					outter.println("alert('성공적으로 수정되었습니다.')");
					outter.println("location.href = 'notice.jsp'");
					outter.println("</script>");
				}
			}
		}
	%>
</body>
</html>