<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/update.jsp</title>
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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$('#idcheck').click(function(){
		$.ajax({
			url:'joinIdCheck2.jsp',
			data:{'id':$('#id').val()},
			success:function(rdata){
				// id="iddiv"에 들고온 데이터 rdata를 넣기
				$('#duplicateId').html(rdata);
			}
		});
	});
	//id="join" submit() 이벤트
	
	$('#join').submit(function(){
		
		
		if($('#id').val()==""){
			alert("아이디 입력하세요");
			$('#id').focus();
			return false;
			}
		if($('#Pass').val()==""){
		alert("비밀번호 입력하세요");
		$('#Pass').focus();
		return false;
		}
		if($('#Pass2').val()==""){
		alert("비밀번호 확인 입력하세요");
		$('#Pass2').focus();
		return false;
		}
		if($('#email').val()==""){
			alert("이메일 입력하세요");
			$('#email').focus();
			return false;
		}
		if($('#name').val()==""){
			alert("이름 입력하세요");
			$('#name').focus();
			return false;
		}
		if($('#Pass').val()!=$('#Pass2').val()){
			alert("비밀번호가 일치하지 않습니다");
			$('#Pass').focus();
			return false;
		}
		
	});
});
	
	function fn_Checkaddr() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 각 주소의 노출 규칙에 따라 주소를 조합한다.

						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.

						var fullAddr = ''; // 최종 주소 변수

						var extraAddr = ''; // 조합형 주소 변수

						// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.

						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우

							fullAddr = data.roadAddress;

						} else { // 사용자가 지번 주소를 선택했을 경우(J)

							fullAddr = data.jibunAddress;

						}

						// 사용자가 선택한 주소가 도로명 타입일때 조합한다.

						if (data.userSelectedType === 'R') {

							//법정동명이 있을 경우 추가한다.

							if (data.bname !== '') {

								extraAddr += data.bname;

							}

							// 건물명이 있을 경우 추가한다.

							if (data.buildingName !== '') {

								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);

							}

							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.

							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');

						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.

						document.getElementById('addr1').value = data.zonecode + fullAddr; //5자리 새우편번호 사용

						document.getElementById('addr2').focus();
						
						
					}
				}).open();
		window.close();
	}
	

	
</script>
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
<%
String id = (String)session.getAttribute("id");
out.print(id);
MemberDAO memberDAO = new MemberDAO();

MemberDTO memberDTO = memberDAO.getMember(id);
%>
<article>
<h1>회원가입</h1>
<form action="updatePro.jsp" name="fr" id="join" method="post">
<fieldset>
<legend>기본정보</legend>
<label>ID</label>
<input type="text" name="id" id="id" class="id" value="<%=memberDTO.getId()%>">
<input type="button" value="중복확인" id="idcheck" class="dup"  style="cursor: pointer;"><br>
<div id="duplicateId"></div>
<label>비밀번호 변경</label>
<input type="password" name="pass" id="Pass"><br>
<label>비밀번호 확인</label>
<input type="password" name="pass2" id="Pass2"><br>
<label>이름</label>
<input type="text" name="name" value="<%=memberDTO.getName()%>"><br>
<label>E-Mail</label>
<input type="email" name="email" value="<%=memberDTO.getEmail()%>"><br>
</fieldset>

<fieldset>
<legend>선택정보</legend>
<label>주소</label>
<input type="text" name="address" value="<%=memberDTO.getAddress()%>" id="addr1" >
<input type="button" value="주소검색" class="dup"  onclick="fn_Checkaddr()" style="cursor: pointer;"><br>
<label>상세주소</label>
<input type="text" value="address2" id="addr1" ><br>
<label>집전화</label>
<input type="text" name="phone" value="<%=memberDTO.getPhone()%>"><br>
<label>개인번호</label>
<input type="text" name="mobile" value="<%=memberDTO.getMobile()%>"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원정보수정" class="submit" style="cursor: pointer;">
<input type="reset" value="취소" class="cancel" style="cursor: pointer;">
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