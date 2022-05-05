<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice.jsp</title>
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
<li><a href="#">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%


BoardDAO boardDAO = new BoardDAO();


List boardList=boardDAO.getBoardList();

// 날짜 => 문자열(원하는 포맷) 변경
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
%>
<!-- 게시판 -->
<article>
<h1>Notice</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite" style="font-size: 8pt">작성자</th>
    <th class="tdate" style="font-size: 8pt">작성날짜</th>
    <th class="tread" style="font-size: 8pt" >조회수</th></tr>
    <%
    for(int i = 0; i < boardList.size(); i++){
    	// 배열 한칸 데이터 가져올때 get()
    	BoardDTO boardDTO = (BoardDTO)boardList.get(i);%>
    	<tr onclick="location.href='content.jsp?num=<%=boardDTO.getNum()%>'" style="cursor: pointer;"><td><%= boardDTO.getNum()%></td><td class="left"><%= boardDTO.getSubject()%></td>
        <td></td><td><%=dateFormat.format(boardDTO.getDate())%></td><td><%= boardDTO.getReadcount()%></td></tr>
   <% }%>
</table>
<div id="table_search">
<input type="text" name="search" class="input_box">
<input type="button" value="글검색" class="btn" style="cursor: pointer;">

<%
String id = (String)session.getAttribute("id");
if (id != null) {
%>
<input type="button" value="글쓰기" class="btn" onclick="location.href='write.jsp'" style="cursor: pointer;">
<%} %>
</div>
<div class="clear"></div>
<div id="page_control">
<a href="#">Prev</a>
<a href="#">1</a><a href="#">2</a><a href="#">3</a>
<a href="#">4</a><a href="#">5</a><a href="#">6</a>
<a href="#">7</a><a href="#">8</a><a href="#">9</a>
<a href="#">10</a>
<a href="#">Next</a>
</div>
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