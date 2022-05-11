<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test1.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
// 	https://jquery.com/download/
// 	script폴더에 jquery-3.6.0.js 넣기
//  함수들의 모임

	// 대상.함수()
	$(document).ready(function(){
// 		alert("준비");
		// 대상 => * 전체  , 태그 대상, id=이름 #이름, class=이름 .이름
		$('*').css("color","blue");
		$('h1').css("color","green");
		$('#a2').css("color","red");
		$('.a3').css("color","black");
		// input태그[속성=값]
		$('input[type=text]').css('color',"skyblue");
		// 태그:first처음 태그:last마지막 odd홀수 even짝수
		$('tr:odd').css('background-color','skyblue');
		$('tr:even').css('background-color','pink');
		$('tr:first').css('background-color','green');
		
		// 대상.attr(태그속성,값)
		
	});
	
</script>
</head>
<body>
<table>
<tr><td>번호</td><td>제목</td></tr>
<tr><td>1</td><td>제목1</td></tr>
<tr><td>2</td><td>제목2</td></tr>
<tr><td>3</td><td>제목3</td></tr>
<tr><td>4</td><td>제목4</td></tr>
<tr><td>5</td><td>제목5</td></tr>
</table>
어이디 :<input type="text" name="id"><br>
비밀번호 : <input type="password" name="pass"><br>
<h1>제목1</h1>
<h1 id="a2">제목2</h1>
<h1 class="a3">제목3</h1>
내용
</body>
</html>

