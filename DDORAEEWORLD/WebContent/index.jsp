<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="dao" class="user.UserDAO" />
<jsp:useBean id="vo" class="user.User" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>DDORAEE WORLD</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<style>
* {
	font-family: 'Gaegu', cursive;
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
   
   <!-- Carousel -->
      <div class="container">
      <div id="myCarousel" class="carousel slide" data-ride="carousel">
         <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
         </ol>
         <div class="carousel-inner">
            <div class="item active">
               <img src="https://cgeimage.commutil.kr/phpwas/restmb_allidxmake.php?idx=3&simg=20210202124855093469f2741072510624586229.jpg" style="width: 1500px; height: 500px;">
            </div>
            <div class="item">
               <img src="img/LOGO4.png" alt="LOGO" style="width: 1500px; height: 500px;">
            </div>
            <div class="item">
               <img src="http://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2017/03/04/2f5db294-0f91-4112-b732-5083924b5386.jpg" style="width: 1500px; height: 500px;">
            </div>
         </div>
         <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
         </a>
         <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
         </a>
      </div>
   </div>
    
   <div class="container marketing">
      <hr class="featurette-divider">
      <div class="row" style="margin: auto;">
        <div class="col-lg-4" style="font-size: 16px; width: 350px;">
          <h2>FOLLOW LIST</h2>
          <div data-spy = "scroll"   data-target = "# navbar- example" data-offset = "0" style = "height: 200px; overflow : auto; position: relative;">
          <%
          if(user_id != null && !user_id.equals("")){
             List<String> list = dao.followList(user_id);
             for(int i = 0; i < list.size(); i++) {
          %>
             <p style="margin-top: 15px;"><%= i+1 %>. <a href="homepage.jsp?user_id=<%= list.get(i).toString()%>"><%= list.get(i).toString() %></a> </p>
         <%
             }
          }
         %>
          </div>
        </div>
        <div class="col-lg-4">
          <img src="https://media1.tenor.com/images/6f8cc88e3f492c969f690eb447378253/tenor.gif?itemid=19804594" alt="baby sun" style="opacity: 0.8; border-radius: 50px; width: 350px; height: 300px; margin-top: 40px; margin-bottom: 40px;">
       </div>
        <div class="col-lg-4">
          <h2>추천 주제</h2>
          <p style="padding: 100px; background-color: lightgray; border-radius: 50px; text-align: center;">오늘의 주제</p>
          <p><a class="btn btn-primary pull-right" style="border: none; background-color: red; color: white;" href="homepage.jsp" role="button">글쓰러 가기&raquo;</a></p>
        </div>
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