<%@page import="board.BoardDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/recommendPro.jsp</title>
</head>
<body>
<%
String id = (String)session.getAttribute("id");
int num = Integer.parseInt(request.getParameter("num"));

BoardDAO boardDAO = new BoardDAO();
boardDAO.updateRecommend(num);

// response.sendRedirect("content.jsp?num="+num);
%>

<script type="text/javascript">
history.back();
</script>
</body>
</html>