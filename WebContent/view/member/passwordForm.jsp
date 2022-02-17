<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

function inputChk(f){
	if(f.pass.value==''){
		alert("비밀번호를 입력하세요.")
		f.pass.focus()
		return false;
	}
	if(f.newPass.value==''){
		alert("새로운 비밀번호를 입력하세요.")
		f.newPass.focus()
		return false;
	}
	if(f.newPass.value == f.pass.value){
		alert("현재 비밀번호와 같습니다 다시 입력하세요")
		f.newPass.value=""
		f.newPass.focus()
		return false
	}
	if(f.newPass.value != f.newPass2.value){
		alert("새로 입력한 비밀번호와 다릅니다 다시 입력해주세요.")
		f.newPass2.value = ""
		f.newPass2.focus()
		return false;
	}
	
	return true;
}

</script>
</head>
<body>
<%
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
%>
<hr>
	<!-- login start -->
	<div class="container">
		<h2   id="center"">비밀번호 변경</h2>
	<form action="<%=request.getContextPath() %>/view/member/passwordPro.jsp" method="post" name="f" onsubmit="return inputChk(this)">
		<div class="form-group">
			<label for="usr">Id:</label> 
				<input type="text" class="form-control" name="id" readonly="readonly" value="<%=login%>"> 
				
			<label for="pwd">현재 비밀번호 : </label>
				<input type="password" class="form-control" name="pass">
			<label for="pwd">변경 비밀번호 : </label>
				<input type="password" class="form-control" name="newPass">
			<label for="pwd">변경 비밀번호 확인:</label>
				<input type="password" class="form-control" name="newPass2">
		</div>
		<div id="center" style="padding: 3px;">
			<button type="submit" class="btn btn-dark">비밀번호 변경</button>
		</div>
	</form>
	</div>
<%	
	} 
%>
</body>
</html>