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
<script type="text/javascript">
	function win_upload(){
		const op = "width=500, height=150, left=200, top=250";
		open("<%=request.getContextPath()%>/single/pictureForm.jsp", "" , op);
		
	}

</script>
<body>
<%
	String login = (String) session.getAttribute("memberId");
	// 로그인이 안되면
	if(login == null || login.trim().equals("")){
%>
	<script type="text/javascript">
		alert("로그인이 필요 합니다.");
		location.href = "<%=request.getContextPath()%>/view/member/loginForm.jsp";
	</script>
<%	
		}
	else {
%>
<%
// 해당 id가 member테이블에 있으면 그 id에 해당하는 정보를 mem에 저장한다
	MemberDao md = new MemberDao();
	// id가 없으면 mem = null 있으면 mem이 반환
	Member mem = md.selectOne(login);
%>
<hr>
	<div class="container">
		<h2   id="center">회원 정보 수정</h2>
		<form action="<%=request.getContextPath() %>/view/member/memberUpdatePro.jsp" method ="post" name="f">
											<!-- value가 없으면 사진 이름이 전송안된다 -->
		<input type="hidden" name="picture" value ="<%=mem.getPicture()%>">
		<div class="row">
			<div class="col-3   bg-light">
				<img src="<%= request.getContextPath()%>/upload/<%=mem.getPicture()%>" width="200" height="220" id="pic"><br>
				<button type = "button" class="btn btn-dark" onclick="win_upload()">사진등록</button>
			</div>
			
			<div class="col-9">
				<div class="form-group">
					<label for="id">아이디:</label> 
						<input type="text" class="form-control" name="id" readonly="readonly" value="<%=mem.getId()%>"> 
					<label for="pwd">비밀번호:</label>
						<input type="password" class="form-control" id="pwd" name="pass"> 
					<label for="name">이름:</label> 
						<input type="password" class="form-control" id="name" name="name" readonly="readonly" value="<%=mem.getName()%>"> 
					<label for="gender">성별:</label> 
						<label	class="radio-inline"> </label>
							<input type="radio" name="gender" disabled="disabled" <%=mem.getGender()==1? "checked" : "" %> value="1">남 
						<label class="radio-inline"> </label>
							<input type="radio" name="gender" disabled="disabled" <%=mem.getGender()==2? "checked" : "" %> value="2">여
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<label for="tel">전화번호:</label> 
			<input type="text"	class="form-control" name="tel" value="<%=mem.getTel()%>">
		</div>
		
		<div class="form-group">
			<label for="tel">이메일:</label> 
			<input type="text" class="form-control" name="email" value="<%=mem.getEmail()%>">
		</div>

	<div id="center" style="padding: 3px;">
		<button type="submit" class="btn btn-dark">정보수정</button>
		<button type="button" class="btn btn-dark"
			onclick="location.href='<%=request.getContextPath()%>/view/member/passwordForm.jsp'">비밀번호 변경</button>
	</div>
	</form>
</div>
<% } %>

</body>
</html>