<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style-size.css"/>
<link rel="stylesheet" type="text/css" href="style-layout.css"/>
<link rel="stylesheet" type="text/css" href="style-presentation.css"/>
<link rel="stylesheet" type="text/css" href="style-selection.css"/>
</head>
<body id='login'>

<%@ page import = "java.sql.*" %>

<FORM>

<TABLE border='1' width=200>
	
<%
String id = request.getParameter("id");

if (id == ""){
%>

<TR>
	<TD align='center' bgcolor='cccccc'>
	<font size='2'>id를 입력하세요.</font>
	</TD>
</TR>
<TR>
	<TD align='center'>
	<a href=javascript:close()>[닫 기]</a>
	</TD>
</TR>

<%
} else {
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://localhost:3306/test";

	Class.forName(driverName);
	Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");

	Statement stmt = conn.createStatement();
	
	String strSQL = "SELECT id FROM tbllogin where id='" + id + "'";
	ResultSet rs = stmt.executeQuery(strSQL);


	if (!rs.next()) {
%>
<TR>
	<TD align='center' bgcolor='cccccc'>
	<fint size='2'>입력하신 ID : <%=id%> <BR> 사용할 수 있는 아이디입니다.</font>
	</TD>
</TR>
<TR>
	<TD align='center'>
	<a href=javascript:close()>[닫 기]</a>
	</TD>
</TR>
<%
	} else {
%>
<TR>
	<TD align='center' bgcolor='cccccc'>
	<font size='2'>입력하신 ID : <%=id%> <BR> 이미 존재하는 아이디입니다.</font>
	<script> opener.document.Signup.userid.value = ""; </script>
	</TD>
</TR>
<TR>
	<TD align='center'>
	<a href=javascript:close()>[닫 기]</a>
	</TD>
</TR>
<%
	}

	rs.close();
	stmt.close();
	conn.close();
}
%>



</body>
</html>