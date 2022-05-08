<%@page import="comment.CommentDTO"%>
<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/deleteCommentPro.jsp</title>
</head>
<body>
<%


String id = (String)session.getAttribute("id");
int comment_num = Integer.parseInt(request.getParameter("comment_num"));
int num = Integer.parseInt(request.getParameter("num"));
CommentDAO commentDAO = new CommentDAO();
CommentDTO commentDTO = new CommentDTO();



if(id != null) {
	
	commentDAO.deleteComment(comment_num);
	
	response.sendRedirect("content.jsp?num=" + num);
}else{%>
	<script type="text/javascript">
	alret("세션값 틀림");
	location.href("../member/login.jsp");
	</script>
<%}%>


</body>
</html>