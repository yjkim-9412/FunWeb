<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/loginPro.jsp</title>
</head>
<body>
<%
//폼에서 가져온값 request에 저장 "id" "pass" 파라미터 값 가져오기
String id=request.getParameter("id");
String pass=request.getParameter("pass");

//MemberDAO 객체생성=> 기억장소 할당
MemberDAO memberDAO=new MemberDAO();
//리턴할형 MemberDTO   userCheck(String id, String pass) 메서드 정의
//MemberDTO memberDTO =  주소.userCheck(id,pass) 메서드 호출
MemberDTO memberDTO=memberDAO.userLogin(id, pass);

if(memberDTO!=null){
	// memberDTO 데이터 있으면  아이디 비밀번호 일치 
	// => 세션값 생성(페이지 상관없이 값유지), 기준값 적용 => main.jsp 이동
	session.setAttribute("id", id);
	response.sendRedirect("../main/main.jsp");
}else{
	// memberDTO 데이터 없으면(null이면) 아이디 비밀번호 틀림 => 아이디 비밀번호 틀림 메시지 출력 , 뒤로이동
	%>
	<script type="text/javascript">
		alert("입력하신 정보 틀림");
		history.back();
	</script>
	<%		
}
%>

%>
</body>
</html>