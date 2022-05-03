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
	
	
	%>
	
	<%if(resultDB == 0 || resultDB == 1){%>
	<script type="text/javascript">
		
	
		var result;
	
		
		window.opener.result = <%=resultDB%>;
		
		window.opener.document.fr.id.value;
		
		
		
		window.close();
		
		
	</script>
	<% 
// 	resultDB = null;
	}else{
	out.print("에러발생");
	}%>
		
</body>
</html>