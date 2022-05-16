<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test5.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	$('#btn').click(function(){
		$.ajax({
			url:'test5_idcheck.jsp',
			data:{'id':$('#id').val()},
			success:function(rdata){
				// id="iddiv"에 들고온 데이터 rdata를 넣기
				$('#iddiv').html(rdata);
			}
		});
	});
});
</script>
</head>
<body>
<form action="a.jsp" method="post">
<input type="text" name="id" id="id">
<input type="button" value="아이디 중복체크" id="btn">
<div id="iddiv"></div>
</form>
</body>
</html>