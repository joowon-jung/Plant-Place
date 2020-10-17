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
</head>
<script>
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
if (Write.pgroup.value == "0") {
	alert("상품 분류를 선택해 주세요.");
	Write.pgroup.focus();
	return false;
}

Write.submit();
}
function deleteOk(num) {
	var del = confirm("정말로 삭제하시겠습니까?");
	if(del == true) {
		location.href = "product_delete.jsp?num="+num;
	}
}
</script>
<body>

<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");

String num = request.getParameter("num"); 

PreparedStatement pstmt = null;
ResultSet rs = null;

try {

String strSQL = "SELECT * FROM tblproduct WHERE pd_num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));

rs = pstmt.executeQuery();
rs.next();

String name = rs.getString("pd_name");
String price = rs.getString("pd_price");
String group = rs.getString("pd_group");
String filename = rs.getString("pd_file");

String group_txt = "";
switch(group)
{
case "1": group_txt= "씨앗"; break;
case "2": group_txt= "식물"; break;
case "3": group_txt= "원예도구"; break;
case "4": group_txt= "자갈/모래/흙"; break;
case "5": group_txt= "영양제/비료"; break;
}

%>
<br><Br>
<center><font size='3'><b> 상품 수정 </b></font>                   

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
            <input type="file" name="userFile">
            <input type="hidden" name="pd_num" value="<%=num%>">
            <input type="hidden" name="flag" value="modify">
		</TD>
	</TR>

	<TR>
      		<TD colspan='2'>
         		<hr color='green' size='1' noshade>
      		</TD>
	</TR>

	<TR>
		<TD width='100' bgcolor='green'>
			<font color='white' size='2'><center><b>상품명</b></center></font>
		</TD>
		<TD>
			<font size='2'><input type='text' value="<%=name%>" size='20' maxlength='50' name='pname'></font>
		</TD>
	</TR>
		<TR>
		<TD width='100' bgcolor='green'>
			<font color='white' size='2'><center><b>상품 가격</b></center></font>
		</TD>
		<TD>
			<font size='2'><input type='number' value="<%=price%>" size='20' maxlength='50' name='pprice'></font>
		</TD>
	</TR>
	<TR>
		<TD width='100' bgcolor='green'>
			<font color='white' size='2'><center><b>상품 분류</b></center></font>
		</TD>
		<TD>
			<select name='pgroup' style="background-color:cccccc;">
				<option value='0' selected>변경 전: <%= group_txt %></option>
				<option value='1'>씨앗</option>
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
				<TD align='left'>
					<input class='button' Type = 'Submit' Value = '상품수정'>
				</TD>
				<TD align='right'>
					<input class='button' Type = 'button' Value = '상품삭제' onClick="deleteOk(<%=num%>)">
				</TD>
			</TR>
		</TABLE>
		</TD>
	
</TABLE>

</FORM>
<table>
		<TD align='right'>
			<a href='product_list.jsp'>[목록보기]</a>
 		</TD>
	</TR>
</TABLE>
<%
rs.close();
pstmt.close();
conn.close();
}
catch(SQLException e){

}
%>




</body>
</html>