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
MemberDAO memberDAO = new MemberDAO();
MemberDTO memberDTO = memberDAO.getMember(id);
String merchantId = request.getParameter("merchantId");
int price = Integer.parseInt(request.getParameter("price"));
String num = request.getParameter("boardNum");
if(id==null){%>
<script type="text/javascript">
alert("로그인 후 구매해주세요");
location.href="../member/logout.jsp";
</script>
	<%}

if(price > memberDTO.getPoint_cur()) {%>
<script type="text/javascript">
alert("포인트가 부족합니다");
history.back();
</script>

<%}else{ %>
<%



MemberDTO MmemberDTO = memberDAO.getMember(merchantId);


memberDAO.usePoint(price, memberDTO, MmemberDTO);

response.sendRedirect("gcontent.jsp?num="+num);
}%>
</body>

</html>