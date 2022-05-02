<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/joinIdCheck.jsp</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("userid");

	MemberDAO memberDAO = new MemberDAO();

	int result = memberDAO.joinIdCheck(id);
	if (result == 1) {
		out.print("사용가능한 아이디입니다");
	%>
	<input type="button" value="아이디 사용하기" onclick="result()">
	<%
	} else if (result == 0) {
	out.print("중복된 아이디입니다");
	} else {
	out.print("에러발생");
	}
	%>
	<fieldset>
		<form action="joinIdCheck.jsp" method="post" name="wfr">
			ID : <input type="text" name="userid" value="<%=id%>"> 
			<input type="submit" value="중복 확인">
		</form>
	</fieldset>
	<script type="text/javascript">
		
		function result() {
			
			
			opener.document.fr.id.value = document.wfr.userid.value;

			opener.document.fr.id.readOnly = true;
			
			window.close();
		}
	</script>
</body>
</html>