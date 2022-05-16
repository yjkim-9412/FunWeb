<%@page import="shop.ShopDAO"%>
<%@page import="comment.CommentDTO"%>
<%@page import="comment.CommentDAO"%>
<%@page import="java.util.ArrayList"%>
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
<title>gcenter/gnotice.jsp</title>
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
<li><a href="../gcenter/gnotice.jsp">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%
CommentDAO commentDAO = new CommentDAO();
CommentDTO commetDTO;

ShopDAO shopDAO = new ShopDAO();


// 모든형을 배열에 저장 => 업캐스팅 데이터 저장

// 한페이지에 보여줄 글개수 지정
int pageSize=6;
// 페이지 번호 가져오기

String pageNum = request.getParameter("pageNum");
//페이지 번호가 없으면 "1"페이지 지정
if(pageNum == null) {
	pageNum="1";
}
// pageNum pageSize 조합해서 => startRow 시작하는 행번호  => 식(알고리즘)
// PageNum => 문자열 정수형 변경
int currentPage = Integer.parseInt(pageNum);
// pageNum pageSize => startRow
// 1		10		=>	 	=> (1-1) * 10 + 1=> 0 + 1=>1
// 2		10		=>		=> (2-1) * 10 + 1=> 10 + 1=>11
// 3		10		=>		=> (3-1) * 10 + 1=> 20 + 1=>21
int startRow = (currentPage - 1) * pageSize + 1;

//startRow pageSize 조합해서 => endRow 끝나는 행번호 구하기
// 	1		10					10
//	11		10					20
//	21		10					30

int endRow = startRow + pageSize - 1;

// List boardList=boardDAO.getBoardList();

//BoardDTO형만 배열에 저장
// List<BoardDTO> boardList=boardDAO.getBoardList(startRow, pageSize);
List<BoardDTO> shopList=shopDAO.getShopList(startRow, pageSize);

// 날짜 => 문자열(원하는 포맷) 변경
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
%>
<!-- 게시판 -->
<article>
<h1>이모티콘</h1>
<table id="notice">
    <tr onclick=>
    <%int countComment;
    for(int i = 0; i < shopList.size(); i++){
    	// 배열 한칸 데이터 가져올때 get()
    	BoardDTO boardDTO = shopList.get(i);%>
    	
    	
    	 <%countComment = commentDAO.getCommentCount(boardDTO.getNum());%>
    	<td>
    	<%=i+1 %><br>
    	<a href="gcontent.jsp?num=<%=boardDTO.getNum()%>" style=""><img src="../upload/<%=boardDTO.getFile()%>" width="100" height="100"></a><br>
    	<%=boardDTO.getSubject()%> (<%=countComment%>)<br>
    	<%=boardDTO.getName() %><br>
        <%=dateFormat.format(boardDTO.getDate())%><br>
        <%= boardDTO.getReadcount()%><br>
        </td>
        <%
        if((i + 1)%3==0) {
        	%>
        	<tr></tr>
        	<%
        }
        %>
        
   <% countComment = 0;}%>
   
</table>
<div id="table_search">
<form action="../center/noticeSearch.jsp" method="post">
<select name="ns">
	<option value="subject">제목</option>
	<option value="name">작성자</option>
	<option value="content">내용</option>
</select>
<input type="text" name="search" class="input_box" value="">
<input type="submit" value="글검색" class="btn" style="cursor: pointer;">
</form>
<%
String id = (String)session.getAttribute("id");
if (id != null) {
%>
<input type="button" value="글쓰기" class="btn" onclick="location.href='gwrite.jsp'" style="cursor: pointer;">
<%} %>
</div>
<div class="clear"></div>
<div id="page_control">
<%
// 1 ~ 10 11~ 20 페이지번호 구하기
// 한화면 보여줄 페이지개수 설정
int pageBlock=5;

//시작하는 페이지 번호
// pageNum(currentPage) pageBlock => startPage
// 		1~10(0~9)			10		=>	0*10 + 1 => 1
//		11~20(10~19)		10		=>	1*10 + 1 =>11
//		21~30(20~29)		10		=>	2*10 + 1 =>21
int startPage = (currentPage-1) / pageBlock * pageBlock+1; 
//끝나는 페이지 번호
int endPage = startPage + pageSize - 1;



// 구한 끝나는 페이지번호 10, 실제 페이지 번호 2
// 글개수 구하기

// 전체페이지 개수 구하기 글개수 50 , 한화면에 보여줄 글개수 10 => 페이지개수 5 + 0 => 5
// 전체페이지 개수 구하기 글개수 50 , 한화면에 보여줄 글개수 10 => 페이지개수 5 + 1 => 6
// int PageCount=글개수/pageSize + (글개수%pageSize==0?0:1);
int count = shopDAO.getShopCount();

int pageCount = count/pageSize + (count%pageSize==0?0:1);
if(endPage > pageCount){
	endPage=pageCount;
	}
%>

<%
if(startPage > pageBlock){
	%>
	<a href="gnotice.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a>
	<%
}
%>
<%for(int i=startPage; i<=endPage; i++) {

%>
<a href="gnotice.jsp?pageNum=<%=i%>"><%=i %></a>
<%

}
%>
<% if(endPage < pageCount){
%>
<a href="gnotice.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
<%
}
%>

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