<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page session = "true" %>
<%@ page import = "Personal_bbs.*" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="bbsdao" class="Personal_bbs.Personal_bbsDAO" />
<jsp:useBean id="bbsvo" class="Personal_bbs.Personal_bbsVO" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 홈페이지</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<style>
* {
	font-family: 'Gaegu', cursive;
	font-size: 15px;
}
#top_img{
	height : 300px;
	}
#top_img::before{
	content : "";
	background-image: url("img/KakaoTalk_20210301_150324558.png");
	height : 330px;
	background-size : cover;
	opacity : 0.5;
	position : absolute;
	top : 120px;
	left : 0px;
	right : 0px;
	bottom : 0px;
}
#top_id{
	position : relative;
	padding-top : 100px;
	text-align: center;	
	font-size : 80px;
}
#medium{
	height : 200px;
}
#profil{
	float:left;
	padding-left: 200px;
}
#profil_content{
	float:right;
	padding-right: 900px;
}
</style>
<script>
	function upload_popup(){
	   var url = "fileupload_index.jsp";
	   var option = "width=430,height=400,location=no,status=no,scrollbars=yes";
	   
	   window.open(url, "파일업로드", option);   
	}
	
	function update_popup(){
	   var url = "update.jsp";
	   var option = "width=430,height=400,location=no,status=no,scrollbars=yes";
	   
	   window.open(url,"자기소개 수정", option);
	}
</script>

</head>
<body>
	<!-- Navbar -->
<%
	String user_id = null;
	UserDAO dao = new UserDAO(); 
	String rand = dao.matching();
	if(session.getAttribute("user_id") != null) {
		user_id = session.getAttribute("user_id").toString();
	}
	
	String fileRealName = (String)session.getAttribute("fileRealName");
    String path = "C:/Users/hayeo/eclipse-workspace/DDORAEEWORLD/WebContent/img/";
    String url = fileRealName;
    String self_comment = dao.select(user_id);
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
	               MyPage <span class = "caret"> </span>
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


<div id="top_img">
	<p id="top_id"><%= request.getParameter("user_id")%></p>
</div>

<hr>

<div id="medium">
	<form enctype="multipart/form-data" method="post" action="fileupload_index.jsp">
		<div id="profil" style="margin: 30px;">
		<%
			if(url == null){
		%>
	  			<img src="img/KakaoTalk_20210228_152018560.png" alt="img" width="150" height="150"><br>
	  	<%
	  			if(user_id.equals(request.getParameter("user_id"))) {
	  	%>
					<input type="submit" value="수정" onclick="upload_popup()" style="border: none; background-color: gray; color: white;">
		<%
				}
		%>
		<%
			}else{
		%>
		   		<img src="<%=url %>" alt="profile img" width="150" height="150"><br>
		<%
	  				if(user_id.equals(request.getParameter("user_id"))) {
	  	%>
						<input type="submit" value="수정" onclick="upload_popup()" style="border: none; background-color: gray; color: white;">
		<%
					}
		%>
		<%
	 		}
	 	%>
	 	</div>
	</form>
	
	<div id="profil_content" style="height: 120; width: 900;">
      <input type="submit" value="FOLLOW" onclick="follow(user_id, <%=request.getParameter("user_id") %>)" style="border: none; background-color: red; color: white; border-radius: 10px; padding: 5px; margin-top: 20px; margin-bottom: 60px;">
         <form method="post">
        <p style="height:70; width:900;"><%=self_comment %></p>
        <%if(user_id.equals(request.getParameter("user_id"))){ %>
        <input type="submit" value="수정" style="border: none; background-color: gray; color: white;" onclick="update_popup()">
         <%} %>
        </form>
   	</div>
</div>

<div class="container marketing">
      <hr class="featurette-divider">
      <jsp:include page="personal_bbs.jsp"></jsp:include>
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