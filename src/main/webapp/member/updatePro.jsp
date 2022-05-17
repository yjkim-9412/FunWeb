<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/updatePro.jsp</title>
</head>
<body>
<%
//post방식 데이터 전달 해오면 한글처리
request.setCharacterEncoding("utf-8");
// 폼에서 입력한 값을 http가 서버에 전달해서 옴
// 서버 request에 폼에서 입력한 값 저장
String id = (String)session.getAttribute("id");
// request에 저장된 파라미터 값 가져오기 "id" "pass" "name"
String idc=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");
String email=request.getParameter("email");
String address=request.getParameter("address");
String phone=request.getParameter("phone");
String mobile=request.getParameter("mobile");

//MemberDAO 객체생성=> 기억장소 할당
MemberDAO memberDAO =new MemberDAO();
// MemberDTO memberDTO =  주소.userCheck(id,pass) 메서드 호출
MemberDTO memberDTO=memberDAO.userCheck(id);

if(memberDTO!=null){
	// memberDTO 데이터 있으면  아이디 비밀번호 일치 => 수정작업 => main.jsp 이동
	// 수정할 정보를 하나의 바구니에 담기위해서 
	// MemberDTO updateDTO 객체생성
	MemberDTO updateDTO=new MemberDTO();
	// set메서드 호출 id,pass,name 폼에서 가져온값 저장
	updateDTO.setId(idc);
	updateDTO.setPass(pass);
	
			
	// 리턴할형 없음  updateMember(MemberDTO updateDTO) 수정작업 메서드 정의
	// 디비주소.updateMember(updateDTO) 메서드 호출
	memberDAO.updateMember(updateDTO);
	
	response.sendRedirect("../main/main.jsp");
}else{
	// memberDTO 데이터 없으면  아이디 비밀번호 틀림 => 아이디 비밀번호 틀림 메시지 출력 , 뒤로이동
	%>
	<script type="text/javascript">
		alert("입력하신 정보 틀림");
		history.back();
	</script>
	<%			
}
%>
</body>
</html>