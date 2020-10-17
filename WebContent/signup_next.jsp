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
<body>
<SCRIPT language="JavaScript">
function Login() 
{
	//opener.document.mainframe.location.href = 'member.jsp';
	parent.opener.location.reload();
	self.close();
} 
</SCRIPT>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
String id = request.getParameter("userid");
String pass = request.getParameter("pass1"); 
String name = request.getParameter("name");
String zip = request.getParameter("zip");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
String address3 = request.getParameter("address3");
String phone = request.getParameter("tel1") + request.getParameter("tel2") + request.getParameter("tel3");
String email = request.getParameter("usermail");
String bday = request.getParameter("userbday");

String address_d = address2+address3;
%>

<%
String check_ok = "yes";


if (id == "")
	check_ok = "no";

if (pass == "")
	check_ok = "no";

if (name == "")
	check_ok = "no";

if (phone == "")
	check_ok = "no";

if (email == "")
	check_ok="no";

String driverName = "org.gjt.mm.mysql.Driver";
String dbURL = "jdbc:mysql://localhost:3306/test";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");

Statement stmt = conn.createStatement();

String strSQL = "SELECT id FROM tbllogin where id='" + id + "'";
ResultSet rs = stmt.executeQuery(strSQL);

if (!rs.next())
	check_ok="yes";
else
	check_ok="no";

if (check_ok == "yes"){
	strSQL = "INSERT INTO tbllogin(id,pass,name,zip,address1,address2,phone,email,bday)";
	strSQL = strSQL +  "VALUES('" + id + "', '" + pass + "', '" + name + "', '" + zip + "',";
	strSQL = strSQL +  "'" + address1 + "', '" + address_d + "', '" + phone + "',"; 
    strSQL = strSQL +  "'" + email + "', '" + bday + "')";
	stmt.executeUpdate(strSQL);
%>

<BODY>
<br><br>
<center><font size='3'><b> 회원 가입 성공! </b></font>  

<FORM name="zipform" method="post" action="member.jsp">
<TABLE cellSpacing='0' cellPadding='10' align='center' border='0'>
<TR>
	<TD align='center'>
		<p>회원 가입을 축하합니다.<BR>식물공간에 방문하시겠어요?<p>
	</TD>
</TR>
<TR>
	<TD align='center'>
		<input class="button" onclick='Login()' type='button' value='당연하죠!'>
	</TD>
</TR>
</TABLE>
</FORM>
</BODY>
</HTML>

<%
} else {
%>

<HTML>
<HEAD>
<TITLE> 회원 가입 실패 </TITLE> 
</HEAD>

<BODY>

<center><font size='3'><b> 회원 가입 실패 </b></font>
<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>

<TABLE cellSpacing='0' cellPadding='10' align='center' border='0'>
<TR>
	<TD align='center'>
		<font size='2'>회원 가입에 실패 했습니다. <BR>다시 시도해 주세요.</font>
	</TD>
</TR>
<TR>
	<TD align='center'>
		<font size='2'><a href="signup.html">[돌아가기]</a></font>
	</TD>
</TR>
</TABLE>

</BODY>
</HTML>
<%
}
rs.close();
stmt.close();
conn.close();
%>
