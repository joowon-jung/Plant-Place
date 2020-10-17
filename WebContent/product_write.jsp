<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />
<SCRIPT language="JavaScript">
function Check()
{
if (Write.pname.value.length < 1) {
	alert("상품명을 입력하세요.");
	Write.pname.focus(); 
        return false;
	}

if (Write.pprice.value.length < 1) {
	alert("상품 가격을 입력하세요.");
	Write.pprice.focus(); 
	return false;
	}
	
if (Write.pprice.value <= 0) {
	alert("상품 가격을 정확히 입력하세요.");
	Write.pprice.focus();
	return false;
}

if (Write.userFile.value.length < 1) {
	alert("상품 이미지를 등록하세요.");
	Write.userFile.focus(); 
	return false;
}

Write.submit();
}

</SCRIPT>

</head>
<body>
<br><br>
<center><font size='3'><b> 상품 등록 </b></font>                   

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr color='green' size='1' noshade>
		</TD>
 	</TR>
</TABLE>     

<FORM Name='Write' Action='product_input.jsp' Method='POST' Enctype='multipart/form-data' OnSubmit='return Check()'>

<TABLE border='0' width='600' cellpadding='2' cellspacing='2'>
	<TR>
		<TD width='100' bgcolor='green'>
			<font color='white' size='2'><center><b>상품 이미지</b></center></font>
		</TD>
		<TD>
			<font size='2'>
                           <input type="file" name="userFile">
                           <input type="hidden" name="flag" value="write">
                           </font>
		</TD>
	</TR>
	
	<TR>
      		<TD colspan='2'>
         		<hr color='white' color='green' size='1' noshade>
      		</TD>
	</TR>

	<TR>
		<TD width='100' bgcolor='green'>
			<font color='white' color='white'size='2'><center><b>상품명</b></center></font>
		</TD>
		<TD>
			<font size='2'><input type='text' size='20' maxlength='50' name='pname'></font>
		</TD>
	</TR>
		<TR>
		<TD width='100' bgcolor='green'>
			<font color='white' size='2'><center><b>상품 가격</b></center></font>
		</TD>
		<TD>
			<font size='2'><input type='number' size='20' maxlength='50' name='pprice'></font>
		</TD>
	</TR>
	<TR>
		<TD width='100' bgcolor='green'>
			<font color='white' size='2'><center><b>상품 분류</b></center></font>
		</TD>
		<TD>
			<select name='pgroup' style="background-color:cccccc;">
				<option value='1' selected>씨앗</option>
				<option value='2'>식물</option>
				<option value='3'>원예도구</option>
				<option value='4'>자갈/모래/흙</option>
				<option value='5'>영양제/비료</option>
				</select>
		</TD>
	</TR>

	<TR>
      		<TD colspan='2'>
         		<hr color='green' size='1' noshade>
      		</TD>
	</TR>

	<TR>
		<TD align='center' colspan='2' width='100%'>
		<TABLE>
			<TR>
				<TD align='center'>
					<input class='button' Type = 'Reset' Value = '다시작성'>
				</TD>
				<TD align='center'>
					<input class='button' Type = 'Submit' Value = '상품등록'>
				</TD>
			</TR>
		</TABLE>
		</TD>
	
</TABLE>

</FORM>



</body>
</html>