<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.*" %>
<%@ page import="user.*" %>
<jsp:useBean id="dao" class="user.UserDAO" />
<jsp:useBean id="vo" class="user.User" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<title>DDORAEE WORLD</title>
<style>
* {
	font-family: 'Gaegu', cursive;
}
</style>
</head>
<body>
	<%
		UserDAO user = new UserDAO();
		PrintWriter outter = response.getWriter();
		String user_id = null;
		String user_email = null;
		if(session.getAttribute("user_id") != null) {
			user_id = (String)session.getAttribute("user_id");
			user_email = dao.getEmail(user_id);
		}
		dao = new UserDAO(); 
		String rand = dao.matching();
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
		Notice notice = new NoticeDAO().getNotice(notice_seq);
	%>
   <nav class = "navbar navbar-default" style="display: flex;">
      <div class = "navbar-header">
         <button type = "button" class = "navbar-toggle collapsed" data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1" aria-expanded = "false">
            <span class = "icon-bar"> </span>
            <span class = "icon-bar"> </span>
            <span class = "icon-bar"> </span>
         </button>
      </div>
      <a href="index.jsp"><img class="navbar-brand" src="img/LOGO4.png" style="width: 110px; height: 100px; padding: 0; margin-left: 30px; margin-top: 10px;" alt="LOGO"></a>
      <div style="margin: auto;" class = "collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
         <ul class = "nav navbar-nav">
            <li> <a style="padding:40px; font-family: 'Gugi', cursive;" href = "about.jsp">ABOUT</a>
            <li> <a style="padding:40px; font-family: 'Gugi', cursive;" href = "notice.jsp">NOTICE</a>
            <li> <a style="padding:40px; font-family: 'Gugi', cursive;" href = "homepage.jsp?user_id=<%=user_id%>">MY HOME</a>
            <li> <a style="padding:40px; font-family: 'Gugi', cursive;" href="homepage.jsp?user_id=<%= rand %>"> RANDOM PAGE</a>
         </ul>
      </div>
      <div style="align: right;">
         <%
         	if(user_id == null) {
         %>
         <ul class = "nav navbar-nav navbar-right">
	         <li class = "dropdown">
	            <a href = "#" style="font-family: 'Gugi', cursive; margin-top:30px; padding: 10px;" class = "dropdown-toggle" data-toggle = "dropdown" role = "button" aria-haspopup = "true" aria-expanded = "false">
	               Login <span class = "caret"> </span>
	            </a>
	            <ul class = "dropdown-menu">
	               <li>
	                  <a href = "login.jsp" style="font-family: 'Gugi', cursive;">Login</a>
	               <li>
	                  <a href = "sign.jsp" style="font-family: 'Gugi', cursive;">Join us</a>
	            </ul>
	      </ul>
         <%
         	}
         	else {
         %>
         	<ul class = "nav navbar-nav navbar-right">
	         <li class = "dropdown">
				<a href = "#" style="font-family: 'Gugi', cursive; margin-top:30px; padding: 10px;" class = "dropdown-toggle" data-toggle = "dropdown" role = "button" aria-haspopup = "true" aria-expanded = "false">
	               MyPage <span class = "caret"> </span> <!-- caret : 역삼각형 버튼 -->
	            </a>
	            <ul class = "dropdown-menu">
	               <li>
	                  <a href = "logoutProc.jsp"style="font-family: 'Gugi', cursive;">Logout</a>
	               <li>
	                  <a href = "user_updatelogin.jsp" style="font-family: 'Gugi', cursive;">Modify Password</a>
	            </ul>
	      </ul>
         <%
         	}
         %>
      </div>
	</nav>
	
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #ddd">
						<thead>
							<tr>
								<th colspan="3" style="background-color: black; text-align: center;">게시판 글 보기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="width: 20%;">글 제목</td>
								<td colspan="2" style="text-align: left;"><%= notice.getNotice_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
							</tr>
							<tr>
								<td style="width: 20%;">작성자</td>
								<td colspan="2" style="text-align: left;"><%= notice.getNotice_writer() %></td>
							</tr>
							<tr>
								<td style="width: 20%;">작성일자</td>
								<td colspan="2" style="text-align: left;"><%= notice.getNotice_date().substring(0, 11) + notice.getNotice_date().substring(11, 13) + "시" + notice.getNotice_date().substring(14, 16) + "분" %></td>
							</tr>
							<tr>
								<td style="width: 20%;">글 내용</td>
								<td colspan="2" style="height: 300px; text-align: left;"><%= notice.getNotice_content().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
							</tr>
						</tbody>
				</table>
				<center>
					<a href="notice.jsp" class="btn btn-primary" style="background-color: black; border-color: white;">목록</a>
					<%
						if(user.permission(user_id)){
					%>
						<a href="notice_update.jsp?notice_seq=<%=notice_seq %>" class="btn btn-primary" style="background-color: black;border-color: white;">수정</a>
						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="notice_deleteProc.jsp?notice_seq=<%=notice_seq %>" class="btn btn-primary" style="background-color: black; border-color: white;">삭제</a>
					<%
						}
					%>
		</div>
	</div>
	
	<!-- Foot -->
	<footer style="background-color: gray; padding-left: 60px; padding-bottom: 30px; padding-top: 35px;">
      	<div style="font-size: 20px; text-align: left; color: white; margin-left: 50px;">
      		<p style="font-family: 'Gugi', cursive;">DDORAEE WORLD</p>
      	</div>
      	<p></p>
      	<div style="font-size: 10px; font-family: 'Gugi', cursive; text-align: right; color: white; margin-right: 50px; margin-bottom: -20px;">
      		<p style="font-family: 'Gugi', cursive;">&copy; 2021 GlobalIn. DDORAEE WORLD</p>
      	</div>
	</footer>
</body>
</html>