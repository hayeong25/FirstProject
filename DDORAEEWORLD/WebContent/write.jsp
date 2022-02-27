<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="user.*" %>
<%@ page import = "Personal_bbs.Personal_bbsVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<title>bbs write</title>
<style>
* {
	font-family: 'Gaegu', cursive;
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
.write_form{
	text-align: center;
	padding : 20px;
}
.in{
	display : inline-block;
	vertical-align: middle;
}
.cmt{
	text-decoration: 
}
</style>
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
    String path = "img/KakaoTalk_20210301_150324558.png";
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
	
	<div class="container">
		<div class="row">
			<form method="post" action="writedb.jsp">
				<table class="table table-striped" style="margin: auto; text-align: center; width: 1000px; margin-bottom: 50px;">
					<thead>
						<tr>
							<th colspan="2" style="background-color: red; text-align: center;">글 작성</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="Title" name="bbs_title" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" rows="10" cols="20" name="bbs_content" placeholder="Content" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<center>
					<input type="submit" value="등록" style="background-color: red; color: white; border-color: white;">
					<input type="reset" value="취소" onclick='history.back()' style="background-color: red; color: white; border-color: white;">
			</form>
		</div>
	</div>
<%
	request.getAttribute("bbs_title");
	request.getAttribute("bbs_content");
%>
	
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