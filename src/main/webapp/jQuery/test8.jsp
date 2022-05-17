<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test8.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#btn').click(function(){
		$.ajax({
			url:'test8_json.jsp',
			dataType:'json',
			success: function(rdata){
				$.each(rdata,function(index,item){
					$('#table1').append("<tr><td>"+item.id+"</td><td>"+item.pass+"</td><td>"+item.name+"</td></tr>")
				});
			}
		});$(this).unbind();
	});
});
</script>
</head>
<body>
<input type="button" value="버튼" id="btn">
<table id="table1" border="1">
</table>
</body>
</html>