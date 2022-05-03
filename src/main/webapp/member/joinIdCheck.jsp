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
	int resultDB = memberDAO.joinIdCheck(id);
	
	if(resultDB == 1){
	%>
	<fieldset>
		<p>사용가능한 아이디입니다</p>
		 <input type="button" value="아이디 사용하기" onclick="result();">
	</fieldset>
	<%}else if (resultDB == 0) { %>
		<fieldset>
		<p>중복된 아이디입니다</p>
		<input type="button" value="확인" onclick="result();" style="cursor: pointer;">
		</fieldset>
	<%} else {
		out.print("에러발생");
	}%>
	<script type="text/javascript">
		
		function result(){
		
		window.opener.result = <%=resultDB%>;
		window.opener.document.fr.id.value;
		
		window.close();
		}
		
	</script>
		
</body>
</html>