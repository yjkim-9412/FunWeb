<%@page import="comment.CommentDTO"%>
<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/updateCommentPro.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
String comment = request.getParameter("comment");
int comment_num = Integer.parseInt(request.getParameter("comment_num"));
int num = Integer.parseInt(request.getParameter("num"));

CommentDAO commentDAO = new CommentDAO();
CommentDTO commentDTO = new CommentDTO();

commentDTO.setComment(comment);
commentDTO.setComment_num(comment_num);

commentDAO.updateComment(commentDTO);

response.sendRedirect("content.jsp?num="+num);




%>
</body>
</html>