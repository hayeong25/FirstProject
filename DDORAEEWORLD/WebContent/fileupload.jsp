<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="fileupload.FileUploadDAO" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<script>
function pop_close(){
	window.opener.location = "homepage.jsp"
	window.close();
}
</script>
<form action="homepage.jsp" method="post" enctype="multipart/form-data">
<%
	String uploadpath = "C:/Users/hayeo/eclipse-workspace/DDORAEEWORLD/WebContent/img/";
	int maxsize = 1024 * 1024 * 100; //파일크기 10mb
	String encoding = "UTF-8";
	
	//MultipartRequest multipartRequest = new MultipartRequest(request, [저장경로], [파일크기], [인코딩], new DefaultFileRenamePolicy());
	MultipartRequest multipartRequest = new MultipartRequest(request, uploadpath, maxsize, encoding, new DefaultFileRenamePolicy());
	// DefaultFileRenamePolicy() : 중복제거해주는 메소드(같은 파일명 업로드하면 뒤에 숫자 1,2,... 로 자동으로 수정)
	
	String fileName = multipartRequest.getOriginalFileName("profil_img");//업로드한 원래 파일이름을 String 으로 가져옴
	String fileRealName = multipartRequest.getFilesystemName("profil_img");//서버 폴더에 저장할 이름
		//out.write(fileName + "<br>");
	if(!fileName.endsWith(".jpg") || !fileName.endsWith(".jfif") || !fileName.endsWith(".png")){
		//fileName 이름이 .jpg, .jfif, .png로 끝나는 파일만 업로드 가능하게
		new FileUploadDAO().upload(fileName, fileRealName,uploadpath);//디비처리
		//확인처리
	/* 	out.write("업로드한 파일명 : " + fileName + "<br>");
		out.write("실제 파일명 : " + fileRealName + "<br>");
		out.write(uploadpath);//서버로 전송된 파일 위치 */
	}else{
        File file = new File(uploadpath + fileRealName);
        file.delete();
        out.print("<script>");
        out.print("alet('확장자를 확인해주세요.(.jpg, .jfif, .png 만 가능)');");
        out.print("history.back();");
        out.print("<script>");
     }
	session.setAttribute("fileRealName", fileRealName);//서버에 저장된 파일이름(중복된 이름을 가진 파일의 경우 1,2...로 저장)
	
%>
<input type="submit" value="닫기" onclick="pop_close()">
</form>
</body>
</html>