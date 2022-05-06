<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/commentPro.jsp</title>
</head>
<body>
<%
String id = (String)session.getAttribute("id");
request.setCharacterEncoding("utf-8");
String comment = request.getParameter("comment");
int num = Integer.parseInt(request.getParameter("num"));

MemberDAO memberDAO = new MemberDAO();
memberDAO.getMember(id);
MemberDTO memberDTO = new MemberDTO();

CommentDAO commentDAO = new CommentDAO();
CommentDTO commentDTO = new CommentDTO();

commentDTO.setNum(num);
commentDTO.setId(id);
commentDTO.setName(memberDTO.getName());
commentDTO.setComment(comment);

commentDAO.insertComment(commentDTO);

response.sendRedirect("content.jsp");


%>
</body>
</html>