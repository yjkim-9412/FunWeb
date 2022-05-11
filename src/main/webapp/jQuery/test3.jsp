<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test3.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		// 이벤트 대상.bind('이벤트종료', 함수) , 대상.click(함수)
		$('#btn1').bind('click',function(){
// 			alert("이벤트");
// 			id="aa" 대상에 "버튼1클릭" 내용넣기
			$('#aa').html("버튼1클릭");
		});
		$('#btn2').bind('click',function(){
// 			alert("이벤트2");
			$('#aa').html("버튼2클릭");
		});
		$('#img1').mouseover(function(){
			$(this).attr('src','7.jpg');
		});
		$('#img1').mouseout(function(){
			$(this).attr('src','6.jpg');
		});	
		
		// id="img1" 대상 mouseover() 했을때 src값을 7.jpg변경
		
		// id="img1" 대상 mouseover() 했을때 src값을 6.jpg변경
	});
	
</script>
</head>
<body>
<img src="6.jpg" id="img1">
<div id="aa"></div>
<input type="button" value="버튼1" id="btn1">
<input type="button" value="버튼2" id="btn2">
</body>
</html>

