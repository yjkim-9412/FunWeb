<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
String id = request.getParameter("id");

MemberDAO memberDAO = new MemberDAO();
MemberDTO memberDTO = memberDAO.getMember(id);
int result;
if(memberDTO == null){
	result = 0;%><span style="color: green;">아이디 사용가능</span><%
	
}else {
	result = 1;%><span style="color: red;">아이디 중복</span><%
}
%>
		
