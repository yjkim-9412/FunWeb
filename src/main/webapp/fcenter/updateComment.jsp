<%@page import="java.util.List"%>
<%@page import="comment.CommentDTO"%>
<%@page import="comment.CommentDAO"%>
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
<title>center/updateCommnet.jsp</title>
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
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
int num = Integer.parseInt(request.getParameter("num"));
int comment_num = Integer.parseInt(request.getParameter("comment_num"));

CommentDAO commentDAO = new CommentDAO();
CommentDTO commentDTO = commentDAO.getComment(comment_num);


BoardDAO boardDAO = new BoardDAO();
BoardDTO boardDTO = boardDAO.getBoard(num);



boardDTO.setNum(num);


SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.M.d. H:mm");

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

<div id="show">




<!-- table로 추후에 변경 --> 

댓글목록<br>
<form action="updateCommentPro.jsp" name="frm" method="post">
<table id="notice" style="width: 100%">

    	
    	<tr><td class="left"><%=commentDTO.getName()%></td>
       
        <td><textarea name="comment" rows="4" cols="60" style="resize: none;"></textarea></td>
        
        
        <td>
        <input type="hidden" name="comment_num" value="<%=comment_num%>">
        <input type="hidden" name="num" value="<%=boardDTO.getNum()%>">
        <input type="submit" value="등록" style="cursor: pointer; float: left;">
        
        <input type="button" name=cancle value="취소" onclick="fn_cancle()" style="float: left;"></td>
        
        </tr>
        
        
    	 
    
</table>
</form> 
</div>



<div id="table_search">
<%if(id != null ) {%>
	
	<%if(id.equals(boardDTO.getName())) {%>
<input type="button" value="글수정" class="btn" style="cursor: pointer;" onclick="location.href='update.jsp?num=<%=boardDTO.getNum()%>'">
<input type="button" value="글삭제" class="btn" style="cursor: pointer;" onclick="location.href='deleteForm.jsp?num=<%=boardDTO.getNum()%>'">

<% }
}%>
<input type="button" value="글목록" class="btn" onclick="location.href=notice.jsp" style="cursor: pointer;">

</div>
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
		if(document.updateComment.comment.value=="" || document.updateComment.comment.value==null) {
			
			alert("댓글내용을 작성해주세요");
			return false;
		}
		if(document.id.value=="null" || document.id.value=="") {
			alert("로그인후 댓글 작성해주세요");
			location.href="../member/login.jsp";
			return false;
		} else {
			return true;
		}
	}//fn_content()
	
	function fn_cancle() {
		history.back();
	}
	

</script>
</body>
</html>