<%@page import="model.Member"%>
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
	String url = "";
	String msg = "";
	String login = (String) session.getAttribute("memberId");
	// 로그인이 안되면
	if(login == null || login.trim().equals("")) {
%>
	<script type="text/javascript">
		alert("로그인이 필요 합니다.");
		location.href = "<%=request.getContextPath()%>/view/member/loginForm.jsp";
	</script>
<%	
		}
	else {
		MemberDao md = new MemberDao();
		Member mem = md.selectOne(login);
		String pass = request.getParameter("pass");
		String newPass = request.getParameter("newPass");
		
		if(pass.equals(mem.getPass())){
			if(md.changePass(login, newPass) > 0){
				msg = "비밀번호가 변경되었습니다.";
				url = "main.jsp";
			}
			else{
				msg = "비밀번호 변경중 오류가 발생 되었습니다.";
				url = "main.jsp";
			}
		}
		else{
			msg = "비밀번호가 틀렸습니다";
			url = "member/passwordForm.jsp";
		}
		
	}
%>
<script type="text/javascript">
	alert("<%=msg%>")
	location.href = "<%=request.getContextPath()%>/view/<%=url%>"

</script>
</body>
</html>