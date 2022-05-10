<%@page import="board.BoardDAO"%>
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
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");

String comment = request.getParameter("comment");
int num = Integer.parseInt(request.getParameter("num"));
out.print(comment);

MemberDAO memberDAO = new MemberDAO();
MemberDTO memberDTO = memberDAO.getMember(id);


CommentDAO commentDAO = new CommentDAO();
CommentDTO commentDTO = new CommentDTO();

commentDTO.setNum(num);
commentDTO.setId(id);
commentDTO.setName(memberDTO.getName());
commentDTO.setComment(comment);

commentDAO.insertComment(commentDTO);
response.sendRedirect("content.jsp?num="+ num);

%>
<script type="text/javascript">

</script>
</body>
</html>