<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/joinPro.jsp</title>
</head>
<body>
<%
//post 방식 => request 한글처리
request.setCharacterEncoding("utf-8");
//폼에서 가져온값 request에 저장 
//"id" "pass" "name" email address phone mobile 파라미터 값 가져오기
String id = request.getParameter("id");
String pass = request.getParameter("pass");

String name = request.getParameter("name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String address2 = request.getParameter("address2");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");

//데이터를 담아서 전달하는 자바파일 => 패키지(폴더) member  파일이름 MemberDTO
//전달 데이터를 저장할 멤버변수 정의 
//멤버변수에 값을 저장 메서드 정의 set() , 값을 가져올 메서드 정의 get()  
//데이터를 저장하기위해서 MemberDTO 기억장소 할당 => 객체생성
MemberDAO memberDAO = new MemberDAO();

MemberDTO memberDTO = new MemberDTO();

//set메서드 호출 => 멤버변수에 id pass name email address phone mobile 값 저장
memberDTO.setId(id);
memberDTO.setPass(pass);
memberDTO.setName(name);
memberDTO.setEmail(email);
memberDTO.setAddress(address + address2);
memberDTO.setPhone(phone);
memberDTO.setMobile(mobile);




//디비작업 자바파일 => 패키지(폴더) member  파일이름 MemberDAO
//MemberDAO 파일 사용할때 기억장소 할당 => 객체생성
memberDAO.insertMember(memberDTO);
//public void insertMember(MemberDTO 주소저장변수) 메서드 정의
//MemberDAO 파일안에 있는 insertMember(MemberDTO 주소)메서드 호출

response.sendRedirect("login.jsp");
%>


	

</body>
</html>


