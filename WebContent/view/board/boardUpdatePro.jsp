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
	//form문 타입이 enctype="multipart/form-data" 이라서 request대신 multi를써야 값을 가져올수있다.
	MultipartRequest multi = new MultipartRequest(request, path , size, "utf-8");
	Board board = new Board();
	board.setWriter(multi.getParameter("writer"));
	board.setPass(multi.getParameter("pass"));
	board.setSubject(multi.getParameter("subject"));
	board.setContent(multi.getParameter("content"));
	board.setFile1(multi.getFilesystemName("file1"));
	board.setNum(Integer.parseInt(multi.getParameter("num")));
	BoardDao bd = new BoardDao();
	
	
	// 수정한 게시글에 파일첨부가없으면 원본에 파일첨부한걸 넣는다.
	if(board.getFile1() == null || board.getFile1().equals("")){
		board.setFile1(multi.getParameter("file2"));
	}

	Board dbboard = bd.boardOne(board.getNum());
	
	String msg = "비밀번호가 틀렸습니다.";
	String url = "boardUpdateForm.jsp?num="+board.getNum();
	if(board.getPass().equals(dbboard.getPass())){
		
		if(bd.boardUpdate(board) > 0){
			msg = "수정 완료";
			url = "boardInfo.jsp?num="+board.getNum();
		}
		else{
			msg = "수정 실패";
		}
	}
	
%>
<script type="text/javascript">
	alert("<%=msg%>")
	location.href = "<%=url%>"

</script>
</body>
</html>