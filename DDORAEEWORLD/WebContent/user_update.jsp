<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<jsp:useBean id="dao" class="user.UserDAO" />
<jsp:useBean id="vo" class="user.User" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<link rel="stylesheet" href="css/bootstrap.css">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript">
	function passwordCheckFunction(){
	    var user_password1 = $('#user_password1').val();
	    var user_password2 = $('#user_password2').val();
	    if(user_password1 != user_password2){
	       $('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
	    }else{
	       $('#passwordCheckMessage').html('');
	    }
	}
</script>
<style>
* {
	font-family: 'Gaegu', cursive;
}
.login-box {
	width: 380px;
	position: relative;
	margin-top: 250px;
	margin-bottom: -50px;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color: black;
}

.login-box h2 {
	float: left;
	font-size: 40px;
	border-bottom: 6px solid red;
	margin-bottom: 50px;
	padding: 13px 0;
}

.textbox {
	width: 100%;
	overflow: hidden;
	font-size: 20px;
	padding: 8px 0;
	margin: 8px 0;
	border-bottom: 1px solid red;
}

.textbox i{
   width: 26px;
   float: left;
   text-align: center;
   color: black;
}

.textbox input{
   border: none;
   outline: none;
   background: none;
   color: black;
   font-size: 16px;
   width: 80%;
   float: left;
   margin: 0 10px;
}

.btn{
   width: 100%;
   background: none;
   border: 1px solid red;
   border-radius: 20px;
   color: black;
   padding: 5px;
   font-size: 16px;
   cursor: pointer;
   margin: 12px 0;
}
</style>
</head>
<body>    
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
   
    <div class="login-box">
    	<form action="user_updateProc.jsp" method="post">
			<h2>Modify Password</h2>
			<div class="textbox">
				<i class="fas fa-user"></i>&nbsp;
				<%=user_id %>
			</div>
			<div class="textbox">
				<i class="fas fa-lock"></i>
				<input type="password" onkeyup="passwordCheckFunction();" id="user_password1" name="user_password1" maxLength="20" placeholder="NEW PASSWORD">
			</div>
			<div class="textbox">
				<i class="fas fa-lock"></i>
				<input type="password" onkeyup="passwordCheckFunction();" id="user_password2" name="user_password2" maxLength="20" placeholder="RE-ENTER PASSWORD">
			</div>
			<div class="textbox">
				<h5 id="passwordCheckMessage" style="color: red;"></h5>
			</div>
			<div class="textbox">
				<i class="fas fa-envelope"></i>&nbsp;
				<%=user_email %>
			</div>
			<input class="btn" type="submit" style="margin-bottom: 0;" value="OK" >&nbsp;&nbsp;
			<input class="btn" type="reset" style="margin: 0;" value="Cancel" onclick="javascript:window.location='index.jsp'">
		</form>
    </div>
    
    <%
		String messageContent = null;
		if(session.getAttribute("messageContent") != null){
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if(session.getAttribute("messageType") != null){
			messageType = (String) session.getAttribute("messageType");
		}
		if(messageContent != null){
	%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content <% if(messageType.equals("오류 메세지")) out.println("panel-warning"); else out.println("panel-success"); %>">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%= messageType %>
						</h4>
					</div>
					<div class="modal-body">
						<%= messageContent %>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#messageModal').modal("show");
	</script>
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
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