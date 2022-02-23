<%@page import="model.Board"%>
<%@page import="service.BoardDao"%>
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
	int num = Integer.parseInt(request.getParameter("num"));
	String pass = request.getParameter("pass");
	String msg = "비밀번호가 틀렸습니다";
	String url = "boardDeleteForm?num="+num;
	
	BoardDao bd = new BoardDao();
	// 패스워드가 일치하는지 확인하기위해 생성
	Board b = bd.boardOne(num);
	
	if(b.getPass().equals(pass)){
		
		if(bd.boardDelete(num) == 0){
			msg = "게시물삭제에 오류가 발생했습니다.";
		}
		else{
			msg = "게시물이 삭제되었습니다.";
		}
			url = "list.jsp";
	}
	
%>

<script type="text/javascript">
	alert("<%=msg%>")
	location.href = "<%=url%>"
</script>
</body>
</html>