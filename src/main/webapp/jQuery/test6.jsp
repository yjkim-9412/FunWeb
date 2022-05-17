<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test6.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function (){
	// 배열변수
	var arr=[
		{"id":"kim","name":"김길동"},
		{"id":"lee","name":"이길동"},
		{"id":"hong","name":"홍길동"}
	];
	// Jquery each() 반복함수
	$.each(arr,function(index,item){
// 		alert(index);
// 		alert(item.id);
// 		alert(item.name);
		// 기존태그에 내용을 뒷부분에 추가 append()
		$('#div1').append(item.id + "," + item.name + "<br>");
		
		
				
	});
	// id="btn" 클릭했을때 arr 배열변수에 반복문 통해서 접근
	// id="table1" 테이블태그 귓부분에 추가 <tr><td>"+item.id+"+</td><td>"+item.name+"</td></tr>
	$('#btn').click(function () {
		
		$.each(arr,function(index,item){
			
			$('#table1').append("<tr><td>"+item.id+"</td><td>"+item.name+"</td></tr>")
		});
	});
	

});
</script>
</head>
<body>
<div id="div1"></div>


</body>
</html>