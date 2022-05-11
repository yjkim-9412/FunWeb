<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test4.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		$('#fr').submit(function(){
			
			
// 			//val() 함수 value값
// 			alert($('#id').val());
// 			alert($('#pass').val());
			
// 			//포커스 focus()
			if($('#id').val()==""){
				alert("아이디 입력하세요")
				$('#id').focus();
				return false;
			}
			
			if($('#pass').val()==""){
				alert("비밀번호 입력하세요")
				$('#pass').focus();
				return false;
			}
			if($('#gender1').is(":checked")==false && $('#gender2').is(":checked")==false){
				alert("성별 선택하세요");
				return false;
			}
			if($('#age').val()==""){
				alert("나이를 선택하세요");
				return false;
			}
		});
	});
	
</script>
</head>
<body>
<form action="" method="post" id="fr">
아이디 : <input type="text" name="id" id="id"><br>
비밀번호 : <input type="password" id="pass" name="pass"><br>
성별 : <input type="radio" value="남" name="gender" id="gender1">
	   <input type="radio" value="남" name="gender" id="gender2"><br>		
연령 : <select name="age" id="age">
	<option value="">나이선택</option>
	<option value="10">10대</option>
	<option value="20">20대</option>
	<option value="30">30대</option>
</select><br>
<input type="submit" value="전송">
</form>
</body>
</html>

