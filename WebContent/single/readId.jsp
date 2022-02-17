<%@page import="model.Member"%>
<%@page import="service.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// database확인
	String id = request.getParameter("id");
	if(id==null) id = "";
	MemberDao md = new MemberDao();
	Member mem = md.selectOne(id);
	String chk = mem == null ? "false" : "true";
%>
<%=chk%>