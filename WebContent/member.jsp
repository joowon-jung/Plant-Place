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
function Check() //자바스크립트 함수 Check 
{
if (Member.id.value.length < 1){ //길이가 1보다 작음 = 아무것도 입력안했을때
	alert("아이디를 입력하세요."); //상자띄움
	Member.id.focus(); //마우스커서 아이디박스에 
	return false;
}

if (Member.pass.value.length < 1){ //길이가 1보다 작음 = 아무것도 입력안했을때
	alert("비밀번호를 입력하세요."); //상자띄움
	Member.pass.focus(); //마우스커서 비밀번호박스에 
	return false;
}

Member.submit(); //submit 버튼 실행 (40번째 줄)
} 
</SCRIPT>

</head>
<body id="login">

<center> 

<FORM Name='Member' Method='post' Action='member_ok.jsp'> <!-- member_ok.jsp로 전달 -->
<fieldset>
<legend><b>회원 로그인</b></legend>
<TABLE align=center width='400' border='0' cellpadding='10' cellspacing='0'>
<TR>
	<TD align='right'>
		<p>아이디</p>
	</TD>
	<TD align='center'>
		<input type=text maxlength=10 size=10 name=id>
	</TD>
	<TD rowspan='2' align='left'>
		<input class="button" onclick='Check()' type='button' value='로그인'>
		<!-- 로그인 누르면 Check() 함수 호출해줌 -->
	</TD>
</TR>
<TR>
	<TD align='right'>
		<p>비밀번호</p>
	</TD>
	<TD align='center'>
		<input type='password' maxlength='10' size='10' name='pass'>
	</TD>
	<TD>
		<font size='2'>
		</font>
	</TD>
</TR>

</TABLE>
</fieldset>
</FORM>

</body>
</html>