<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gcenter/gdeleteBoard.jsp</title>
</head>
<body>
<%
//  delete.jsp?num=1
// request num  파라미터 값 가져오기
int num=Integer.parseInt(request.getParameter("num"));
// BoardDAO 객체생성
BoardDAO boardDAO=new BoardDAO();
// 리턴할형없음 deleteBoard(int num) 메서드 정의 , 조건 num=?
// deleteBoard(num)  메서드 호출
boardDAO.deleteBoard(num);
// notice.jsp  이동
response.sendRedirect("gnotice.jsp");

%>
</body>
</html>