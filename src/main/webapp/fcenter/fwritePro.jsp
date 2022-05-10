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
<title>fcenter/fwritePro.jsp</title>
</head>
<body>
<%
// request 한글처리
// request.setCharacterEncoding("utf-8");

//파일 업로드 하기위해 프로그램 설치
// http://www.servlets.com
// COS File Upload Library
// cos-20.08.zip 다운 => lib => cos.jar 
// WEB-INF - lib - cos.jar
// 파일 업로드
// cos\com\oreilly\servlet              MultipartRequest.class
// 파일이름 동일할 경우 => 파일이름을 변경
// cos\com\oreilly\servlet\multipart    DefaultFileRenamePolicy.class
// 객체생성하면서 파일업로드 함
// MultipartRequest multi=new MultipartRequest(request,업로드폴더경로,파일크기,한글처리,파일이름변경);
// webapp폴더안에 upload 폴더만들기 => 업로드폴더경로 : 물리적인 경로 
String uploadPath=request.getRealPath("/upload");
// 파일크기  10M
int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

// pass name subject content 파라미터 가져오기
String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
// num 데이터베이스 최대num+1 구하기 , readcount=0 설정, date 시스템날짜
int readcount=0;
// 파일
String file=multi.getFilesystemName("file");

// 패키지 board 파일 BoardDTO
// 멤버변수 정의 , set get메서드 정의
// BoardDTO 객체생성
BoardDTO boardDTO=new BoardDTO();
// set메서드 호출 파라미터값 저장 <= pass name subject content readcount
boardDTO.setName(name);
boardDTO.setPass(pass);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
boardDTO.setReadcount(readcount);
// 파일
boardDTO.setFile(file);

// 패키지 board 파일 BoardDAO
// BoardDAO 객체생성
BoardDAO boardDAO=new BoardDAO();
// 리턴할형 없음 insertBoard(BoardDTO boardDTO) 메서드 정의
// insertBoard(boardDTO 주소값) 호출
boardDAO.insertBoard(boardDTO);
// notice.jsp 이동
response.sendRedirect("fnotice.jsp");
%>
</body>
</html>