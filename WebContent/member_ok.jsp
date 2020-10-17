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
<SCRIPT language="JavaScript">
function Check() 
{
Member.submit(); 
} 
function Next()
{
	parent.document.location.reload();
}
</SCRIPT>
<body id="login">
<center> 
<FORM Name='Member' Method='post' Action='member.jsp'>
<fieldset>
<legend><b>회원 확인</b></legend>
<TABLE cellSpacing='0' cellPadding='30' align='center' border='0' >
<%@ page import = "java.sql.*, java.util.*" %>	
<%
//내가 입력한 id, pass값
String id = request.getParameter("id"); //ip값 받음
String pass = request.getParameter("pass"); //pass값 받음
String sessionID = "yes";
String sessionName = ""; //과제

try{

if (id == "" || pass == "") { //아이디값, 비밀번호 값 비었을 때
%>
<TR>
	<TD align='center'>
	<font size=2>ID와 비밀번호를 입력하세요.</font>
	</TD>
</TR>
<TR>
	<TD align='center'>
	<input class="button" onclick='Check()' type='button' value='로그인'>
	</TD>
</TR>
<%
} else {


	String driverName = "oracle.jdbc.driver.OracleDriver";
	String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";

	Class.forName(driverName);
	Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");

	Statement stmt = conn.createStatement();

	String strSQL = "SELECT * FROM tbllogin where id='" + id + "'";
	//아이디필드에서 아이디값 찾아옴
	ResultSet rs = stmt.executeQuery(strSQL);
	
	rs.next();
	
	//db연동해서 찾은 id, pass값
	String logid = rs.getString("id"); //id값 넣음
	String logpass = rs.getString("pass"); //pass값 넣음
	String logname = rs.getString("name"); //과제

	if (!id.equals(logid)){ //내가 입력한 ip값과 db연동한 ip값 같지 않으면
%>
<TR>
	<TD align="center">
	<font size='2'>회원 ID가 아닙니다.</font>
	</TD>
</TR>
<TR>
	<TD align="center">
	<input class="button" onclick='Check()' type='button' value='로그인'>
	</TD>
</TR>
<%
	} else { 
		if (!pass.equals(logpass)){ //내가 입력한 pass값과 db연동한 pass값 같지 않으면
%>

<TR>
	<TD align='center'>
	<font size=2>비밀번호가 일치하지 않습니다.</font>
	</TD>
</TR>
<TR>
	<TD align='center'>
	<input class="button" onclick='Check()' type='button' value='로그인'>
	</TD>
</TR>

<%
		} else {
			session.setAttribute("user",logid);
			session.setAttribute("name",logname);
			out.print("<script>");
			out.print("parent.location.href = 'main.jsp';");
			out.print("</script>");
		}
	}	
}

} catch(Exception e){
%>
<TR>
	<TD align="center">
	<font size='2'>회원 ID가 아닙니다.</font>
	</TD>
</TR>
<TR>
	<TD align="center">
	<input class="button" onclick='Check()' type='button' value='로그인'>
	</TD>
</TR>

<%
}
%>

</TABLE>
</fieldset>
</FORM>
</body>
</html>