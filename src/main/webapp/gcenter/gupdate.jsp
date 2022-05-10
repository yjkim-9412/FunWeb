<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fupdate.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>

<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->
<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="../fcenter/fnotice.jsp">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%
String id = (String)session.getAttribute("id");
int num = Integer.parseInt(request.getParameter("num"));
BoardDAO boardDAO = new BoardDAO();
BoardDTO boardDTO = boardDAO.getBoard(num);
boardDTO.getName();
if(id==null) {
response.sendRedirect("../member/login.jsp");


}%>
<!-- 게시판 -->
<article>
<h1>Notice Update</h1>
<form action="fupdatePro.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%=num%>">
<table id="notice">
<tr><td>작성자</td><td><input type="text" name="name" value="<%=id%>" style="float: left;" readonly ></td></tr>
<tr><td>제목</td><td><input type="text" name="subject" value="<%=boardDTO.getSubject()%>" style="float: left;"></td></tr>
<tr><td>첨부파일</td><td><input type="file" name="file">
        <%=boardDTO.getFile() %>
        <input type="hidden" name="oldfile" value="<%=boardDTO.getFile() %>"></td></tr>
<tr><td>내용</td>
<td><textarea name="content" rows=10 cols=87 style="resize: none"  ><%=boardDTO.getContent()%></textarea></td></tr>
</table>

<div id="table_search">
<input type="submit" value="글수정" class="btn" style="cursor: pointer;">
</div>
</form>
<div class="clear"></div>

</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>