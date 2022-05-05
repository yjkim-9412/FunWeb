<%@page import="member.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/content.jsp</title>
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
<!-- 게시판 -->
<%
String id = (String)session.getAttribute("id");
int num = Integer.parseInt(request.getParameter("num"));
BoardDAO boardDAO = new BoardDAO();

//게시판 글 조회수 증가
// 리턴할형 없음 updateReadcount(int num) 메서드
// update board set readcount = readcount +1 where num=?
// updateReadcount(num) 호출

BoardDTO boardDTO = boardDAO.getBoard(num);

MemberDAO memberDAO = new MemberDAO();

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.M.d. H:m");

%>

<article>
<h1>Notice Write</h1>
<table id="notice">
<tr><td>글번호</td><td><%=boardDTO.getNum()%></td>
    <td>등록일</td><td><%=dateFormat.format(boardDTO.getDate())%></td></tr>
<tr><td>글쓴이</td><td><%=boardDTO.getName()%></td>
    <td>조회수</td><td><%=boardDTO.getReadcount()%></td></tr>
<tr><td>글제목</td><td colspan="3"><%=boardDTO.getSubject()%></td></tr>
<tr><td>글내용</td><td colspan="3"><%=boardDTO.getContent()%></td></tr>
</table><br>

<div id="comment">


<form name="fr" action="commentPro.jsp" method="post" onsubmit="return fn_content();">
댓글<br>
<textarea name="content" rows=5 cols=87 style="resize: none"  readonly></textarea><br> <!-- table로 추후에 변경 --> 
댓글작성란<br>
<textarea name="comment" rows=5 cols=87 style="resize: none"></textarea>
<input type="hidden" name="num" value="<%=boardDTO.getNum()%>">
<input type="hidden" name="id" value="<%=id%>">

<input type="submit" value="댓글작성" class="btn" style="cursor: pointer;">


</form>
</div>



<div id="table_search">
<%if(id != null ) {%>
	
	<%if(id.equals(boardDTO.getName())) {%>
<input type="button" value="글수정" class="btn" style="cursor: pointer;" onclick="location.href='update.jsp?num=<%=boardDTO.getNum()%>'">
<input type="button" value="글삭제" class="btn" style="cursor: pointer;" onclick="location.href='deleteForm.jsp?num=<%=boardDTO.getNum()%>'">

<%}
}%>
<input type="button" value="글목록" class="btn" onclick="location.href=notice.jsp" style="cursor: pointer;">

</div>
<script type="text/javascript">
function sendComment() {
	location.href("commentPro.jsp")
}
</script>
<div class="clear"></div>

</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
<script type="text/javascript">

function fn_content() {
	if(document.fr.comment.value=="") {
		alert(document.fr.comment.value);
		alert("댓글내용을 작성해주세요");
		return false;
	}
	if(document.fr.id.value=="null" || document.fr.id.value=="") {
		alert("로그인후 댓글 작성해주세요");
		location.href="../member/login.jsp";
		return false;
	} else {
		return true;
	}
	
	
}
</script>
</body>
</html>