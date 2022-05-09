<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/updatePro.jsp</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String subject = request.getParameter("subject"); 
String content = request.getParameter("content");

BoardDTO boardDTO = new BoardDTO();
boardDTO.setName(name);
boardDTO.setNum(num);
boardDTO.setSubject(subject);
boardDTO.setContent(content);

BoardDAO boardDAO = new BoardDAO();
boardDAO.updateBoard(boardDTO);

response.sendRedirect("notice.jsp");
%>
</body>
</html>