<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 
1) Webcontent밑에 upload 폴더를 만든다 (/upload) 


-->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String path = application.getRealPath("/")+"upload/";
	String filename = null;
	
	MultipartRequest multi = new MultipartRequest(request,path,10*1024*1024,"utf-8");
	// upload폴더에 이미지저장
	filename = multi.getFilesystemName("picture");
	
%>
<script type="text/javascript">
//	memberInput 에서 사진등록의 id인 pic를 지정한다
	const img = opener.document.querySelector("#pic");
	// 이미지 보여주는 코드
	img.src = "<%= request.getContextPath()%>/upload/<%=filename%>";
	// 파일 이름저장
	opener.document.f.picture.value = "<%=filename%>";
	self.close();
	
	
</script>
</body>
</html>