<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<title>데이터 삽입</title>
<script type="text/javascript">
$(document).ready(function() {
	$("#fileBtn").on("click", function() {
		let fileName = $('#file').val();
		if(fileName == ""){
			alert("파일을 선택해주세요.");
			return false;
		}
		let dotName = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
		if(dotName == 'txt'){
			$.ajax({
				url : '/dataInputSql.do',
				type : 'POST',
				dataType : 'json',
				data : new FormData($('#form')[0]),
				cache : false,
				contentType : false,
				processData : false,
				enctype : 'multipart/form-data',
				success : function(result) {
					alert("성공");
				},
				error : function(Data) {
				}
			});
		} else {
			alert("확장자가 안 맞으면 멈추기");
		}
		
	});
	
	$('#test').click(function(){
		Snackbar.make(view, "스낵바입니다", Snackbar.LENGTH_LONG).show();
	});	
});
</script>
</head>
<body>
	<form id="form">
		<input type="file" id="file" name="file" accept="txt">
	</form>
		<button type="button" id="fileBtn">파일 전송</button>
		
		<button id="test">snack</button>
</body>
</html>