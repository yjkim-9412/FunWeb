<%@page import="member.MemberDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/writePro.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
int readcount = 0;

BoardDAO boardDAO = new BoardDAO();
BoardDTO boardDTO = new BoardDTO();
MemberDAO memberDAO = new MemberDAO();

boardDTO.setName(name);
boardDTO.setPass(pass);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
boardDTO.setReadcount(readcount);

boardDAO.insertBoard(boardDTO);

response.sendRedirect("notice.jsp");
%>
</body>
</html>