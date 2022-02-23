<%@page import="service.BoardDao"%>
<%@page import="model.Board"%>
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
	request.setCharacterEncoding("utf-8");
	BoardDao bd = new BoardDao();
	Board board = new Board();
	
	board.setWriter(request.getParameter("writer"));
	board.setPass(request.getParameter("pass"));
	board.setSubject(request.getParameter("subject"));
	board.setContent(request.getParameter("content"));
	board.setFile1("");
	
	board.setIp(request.getLocalAddr());
	
	String boardid = (String) session.getAttribute("boardid");
	if(boardid == null)
		boardid = "1";
	
	board.setBoardid(boardid);
	
	int num = Integer.parseInt(request.getParameter("num"));
	int ref = Integer.parseInt(request.getParameter("ref"));
	int reflevel = Integer.parseInt(request.getParameter("reflevel"));
	int refstep = Integer.parseInt(request.getParameter("refstep"));
	
	String msg = "답변 등록시 오류가 발생했습니다.";
	String url = "boardReplyForm.jsp?num="+num;
	bd.refStepAdd(ref, refstep);
	
	board.setNum(bd.nextNum());
	board.setRef(ref);	// 댓글 다는 게시글의 ref값을 저장한다.
	board.setReflevel(reflevel + 1);	// 게시글의 댓글 갯수
	board.setRefstep(refstep + 1);		// 
	
	
	if(bd.insertBoard(board) > 0){
		msg = "답변 등록 완료";
		url = "list.jsp";
	}
	
	
	
%>
<script type="text/javascript">
	alert("<%=msg%>")
	location.href = "<%=url%>"
</script>
</body>
</html>