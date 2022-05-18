<%@page import="shop.ShopDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fupdatePro.jsp</title>
</head>
<body>
<% 
String uploadPath=request.getRealPath("/upload");

int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());



int num = Integer.parseInt(multi.getParameter("num"));
String name = multi.getParameter("name");
String subject = multi.getParameter("subject"); 
String content = multi.getParameter("content");
String file = multi.getFilesystemName("file");
int price = Integer.parseInt(multi.getParameter("price"));

if(file == null){
	file = multi.getParameter("oldfile");
}

ShopDAO shopDAO = new ShopDAO();
BoardDTO boardDTO = new BoardDTO();
boardDTO.setName(name);
boardDTO.setNum(num);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
boardDTO.setFile(file);
boardDTO.setPrice(price);

shopDAO.updateShop(boardDTO);

response.sendRedirect("gnotice.jsp");
%>
</body>
</html>