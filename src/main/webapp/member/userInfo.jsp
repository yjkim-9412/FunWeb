<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/userInfo.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

</head>
<body>
<%


String id = (String)session.getAttribute("id");

out.print(id);

MemberDAO memberDAO = new MemberDAO();
MemberDTO memberDTO = memberDAO.getMember(id);
// MemberDTO memberDTOR = memberDAO.getRating(memberDTO.getRating());


%>

	<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>회원정보</h1>
<form action="update.jsp" name="fr" id="join" method="post" onsubmit="return fn_Checkpass();">
<fieldset>
<legend>기본정보</legend>
<label>ID</label><div id="duplicateId"></div>
<input type="text" name="id"  value="<%=memberDTO.getId()%>"readonly ><br>
<label>이름</label>
<input type="text" name="name" value="<%=memberDTO.getName()%>" readonly><br>
<label>E-Mail</label>
<input type="email" name="email" value="<%=memberDTO.getEmail()%>" readonly><br>
<label>총 누적한 포인트</label>
<input type="text" name="point" value="<%=memberDTO.getPoint_max()%>" readonly><br>
<label>사용가능 포인트</label>
<input type="text" name="point" value="<%=memberDTO.getPoint_cur()%>" readonly><br>
<label>회원등급</label>
<input type="text" name="rating" value="<%=memberDTO.getRating_name()%>" readonly><br>

</fieldset>

<fieldset>
<legend>추가정보</legend>
<label>주소</label>
<input type="text" name="address" id="addr1" value="<%=memberDTO.getAddress()%>" readonly><br>

<label>집전화</label>
<input type="text" name="phone" value="<%=memberDTO.getPhone()%>" readonly><br>
<label>개인번호</label>
<input type="text" name="mobile" value="<%=memberDTO.getMobile()%>" readonly><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원정보 수정" class="submit" style="cursor: pointer;">

</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>