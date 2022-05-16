<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gcenter/purchasePro.jsp</title>
</head>
<body>

<%
String id = (String)session.getAttribute("id");
if(id==null){%>
<script type="text/javascript">
alret("로그인 후 구매해주세요");
location.href="../member/logout.jsp";
</script>
	<%}%>
<%
String merchantId = request.getParameter("merchantId");
int price = Integer.parseInt(request.getParameter("price"));
MemberDAO memberDAO = new MemberDAO();
MemberDTO memberDTO = memberDAO.getMember(id);
MemberDTO MmemberDTO = memberDAO.getMember(merchantId);

memberDAO.usePoint(price, memberDTO, MmemberDTO);
%>
</body>

</html>