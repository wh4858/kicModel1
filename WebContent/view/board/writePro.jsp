<%@page import="service.BoardDao"%>
<%@page import="model.Board"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String path = application.getRealPath("/")+"/boardupload/";
	int size = 10 * 1024 * 1024;
// form문 타입이 enctype="multipart/form-data" 이라서 request대신 multi를써야 값을 가져올수있다.
	MultipartRequest multi = new MultipartRequest(request, path , size, "utf-8");
	Board board = new Board();
	board.setWriter(multi.getParameter("writer"));
	board.setPass(multi.getParameter("pass"));
	board.setSubject(multi.getParameter("subject"));
	board.setContent(multi.getParameter("content"));
	board.setFile1(multi.getFilesystemName("file1"));
	
	board.setIp(request.getLocalAddr());
	
	String boardid = (String) session.getAttribute("boardid");
	if(boardid == null){
		boardid = "1";
	}
	
	board.setBoardid(boardid);
	
	BoardDao bd = new BoardDao();
	//새글인 경우
	board.setNum(bd.nextNum()); // db에서 다음번호를 읽음
	board.setRef(board.getNum());
	
	
	int num = bd.insertBoard(board);
	
	String msg = "";
	String url = "";
	
	if(num > 0){
		msg = "게시물이 등록 되었습니다.";
		url = "list.jsp?pageNum=1";
	}
	else{
		msg = "게시물 등록에 실패했습니다.";
		url = "writeForm.jsp";
	}
%>
<script type="text/javascript">
	alert("<%=msg %>")
	location.href="<%=url %>"
</script>
</body>
</html>