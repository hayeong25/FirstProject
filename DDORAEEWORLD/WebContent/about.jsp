<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<jsp:useBean id="dao" class="user.UserDAO" />
<jsp:useBean id="vo" class="user.User" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" >
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<title>ABOUT US</title>
<style>
* {
	font-family: 'Gaegu', cursive;
}
.container {
	background: linear-gradient(black, black 50%, white 50%, white 100%);
	padding-left: 60px;
	padding-right: 60px;
	min-height: 100vh;
	align-items: center;
	width: 100%;
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
}
.container .box {
	box-sizing: border-box;
	justify-content: space-between;
	width: 300px;
	position: relative;
	background: white;
	padding: 100px 40px 100px;
	box-shadow: 0 15px 45px rgba(0, 0, 0, .1);
}
.container .box:before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: red;
	transform: scaleY(0);
	transform-origin: top;
	transition: transform 0.5s;
}
.container .box:hover:before {
	transform: scaleY(1);
	transform-origin: bottom;
	transition: transform 0.5s;
}
.container .box h2 {
	position: absolute;
	left: 35px;
	top: 60px;
	font-size: 4em;
	font-weight: 800;
	z-index: 1;
	opacity: 0.5;
	transition: 0.5s;
}
.container .box:hover h2 {
	opacity: 1;
	color: white;
	transform: translateY(-40px);
}
.container .box h3 {
	position: relative;
	font-size: 1.5em;
	z-index: 2;
	color: #555;
	transition: 0.5s;
}
.container .box p {
	position: relative;
	font-size: 1.2em;
	z-index: 2;
	color: #555;
	transition: 0.5s;
}
.container .box:hover h3, .container .box p {
	color: white;
}
</style>
</head>
<body>
	<!-- Navbar -->
<%
	String user_id = null;
	String user_email = null;
	if(session.getAttribute("user_id") != null) {
		user_id = (String)session.getAttribute("user_id");
		user_email = dao.getEmail(user_id);
	}
	dao = new UserDAO(); 
	String rand = dao.matching();
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
		<div class="box">
			<h2>01</h2>
			<h3>개발 목적</h3>
			<p><br>돌아온 Cyworld<br><br>또라이들의 엽기적인 Cyworld</p>
		</div>
		<div class="box">
			<h2>02</h2>
			<h3>기능</h3>
			<p><br>포스트 및 사진 게시<br><br>커뮤니티 & 랜덤 홈피 방문</p>
		</div>
		<div class="box">
			<h2>03</h2>
			<h3>차이점</h3>
			<p><br>블로그처럼 글과 사진 게시 가능<br><br>마음에 드는 홈피 구독 가능</p>
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