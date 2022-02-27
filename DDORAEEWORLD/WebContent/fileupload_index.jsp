<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
<style>
* {
	font-family: 'Gaegu', cursive;
}
</style>
</head>
<body>
<form action="fileupload.jsp" method="post" enctype="multipart/form-data">
	업로드할 파일 선택 : <br>
<input type="file" name="profil_img">
<input type="submit" value="업로드">
</form>
</body>
</html>