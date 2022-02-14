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
	String login = (String)session.getAttribute("memberId");
// 현재 클라이언트와 연결된 모든걸 종료시킨다.
	session.invalidate();

%>

<script type="text/javascript">

	alert("<%=login%>님이 로그아웃 되었습니다.");
	location.href = "<%=request.getContextPath()%>/view/member/loginForm.jsp";

</script>
</body>
</html>