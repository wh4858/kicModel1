<%@page import="java.util.List"%>
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
	int pageInt = 1;
	// 게시판 한페이지당 3줄만 출력
	int limit = 10;
	
	// 공지사항 게시판 qna 를 구별할 boardid를 세션에 저장하기
		// boardid가 파라미터로 넘어 왔을때만 세션에 저장한다.
		if(request.getParameter("boardid") != null){
			session.setAttribute("boardid", request.getParameter("boardid"));
			session.setAttribute("pageNum", "1");
		}
		
		String boardid = (String) session.getAttribute("boardid");
		
		if(boardid == null){
			boardid = "1";
		}
		
		
	//--------------------------------------------------------------------------------
	// pageNum을 세션에저장해서 게시글보고 뒤로갔을때 바로전에 보던 페이지를 호출하기위해 저장
	if(request.getParameter("pageNum") != null){
		session.setAttribute("pageNum", request.getParameter("pageNum"));
	}
	
	String pageNum = (String) session.getAttribute("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	pageInt = Integer.parseInt(pageNum);
	
	
	//--------------------------------------------------------------------------------
	BoardDao bd = new BoardDao();
	int boardCount = bd.boardCount(boardid); 
	int boardNum = boardCount - (pageInt - 1) * limit;	
	
	
	//--------------------------------------------------------------------------------
	int bottomLine = 3;
	int startPage = (pageInt - 1) / bottomLine  *  bottomLine + 1;
	int endPage = startPage + bottomLine - 1;
	int maxPage = (boardCount / limit) + (boardCount % limit == 0 ? 0 : 1);
	if(endPage > maxPage){
		endPage = maxPage;
	}
	/* 
	-- 1, 4, 7, 10
	-- start : (pageInt-1)*limit + 1;
	-- end : start + limit - 1;
	-- 1 p --> 1 ~ 3
	-- 2 p --> 4
	-- 3 p --> 7 
	*/

	List<Board> list = bd.boardList(pageInt, limit, boardCount, boardid);
	String boardName[] = {"","공지사항", "자유게시판","QnA게시판"};
%>
<hr>
	<!-- table list start -->
	<div class="container">
		<h2  id="center"><%=boardName[Integer.parseInt(boardid)] %></h2>
		<p align="right">
		<%
			if(boardCount > 0){
		%>		
			글개수 : <%=boardCount %>
		<%	
			}
			else{
		%>
			등록된 게시물이 없습니다.
		<%		
			}
		%>
		</p>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>파일</th>
					<th>조회수</th>

				</tr>
			</thead>
			<tbody>
			<%
				for(Board b : list){
			%>
				<tr>
					<td><%=boardNum--%></td>
					<td>
						<%
						// 답글이 있을시에
							if(b.getReflevel() > 0){
						%>
						<img src = "<%=request.getContextPath()%>/image/level.gif" width = "<%= 5*b.getReflevel() %>" >
						<img src = "<%=request.getContextPath()%>/image/re.gif" >
						<%
							}
						%>
						<a href="boardInfo.jsp?num=<%=b.getNum()%>"><%=b.getSubject() %></a>
					</td>
					<td><%=b.getWriter() %></td>
					<td><%=b.getRegdate() %></td>
					<td><%=b.getFile1() %></td>
					<td><%=b.getReadcnt() %></td>
				</tr>
			<%
				}
			%>
			</tbody>
		</table>
		<p align="right"><a href="<%=request.getContextPath() %>/view/board/writeForm.jsp">게시판 입력</a></p>
		<div class="container"  >
		<ul class="pagination justify-content-center"  >
			<li class="page-item <% if(startPage <= bottomLine) {%>disabled <%}%>">
			<a class="page-link" href="list.jsp?pageNum=<%=startPage-bottomLine %>">Previous</a></li>
			<% for(int i = startPage ; i <= endPage ; i++) {%>
				<li class="page-item <% if (i==pageInt){%>active<%}%>">
				<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a></li>
			<% } %>
			<li class="page-item <% if(endPage >= maxPage) {%>disabled <%}%>">
			<a class="page-link" href="list.jsp?pageNum=<%=startPage+bottomLine %>">Next</a></li>
		</ul>
		</div>
	</div>
</body>
</html>