<%@page import="service.MemberDao"%>
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
	MemberDao md = new MemberDao();
	int num = md.insertMember(request);
	String name = request.getParameter("name");

	String msg = "";
	String url = "";
	if ( num > 0){ 
		msg = name +"님의 가입이 완료 되었습니다.";
		url = request.getContextPath()+"/view/member/loginForm.jsp";
	}
	else{
		msg = "회원가입이 실패했습니다.";
		url = request.getContextPath()+"/view/main.jsp";
	}
%>
<script type="text/javascript">
	alert("<%=msg %>")
	location.href="<%=url %>"

</script>
<%=num %>
</body>
</html>