<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />
<script>
function Del(form)
{
	OD = confirm("탈퇴 처리 후에는 회원 정보를 복구할 수 없습니다.\n진행하시겠습니까?");
	if(OD) {
		form.submit();
	}	
}
function goPage()
{
	location.href = "member_page.jsp"
}
</script>
</head>
<body class="board">
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
Object user = session.getAttribute("user");

if(user==null || !user.equals("admin")) {
	%><script>
	alert("잘못된 접근입니다.");
	location.href = 'main.jsp';
	</script><%
}


String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
String strSQL = "";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");

Statement stmt = conn.createStatement();
ResultSet rs = null;

int i = 0;

%>
<br>
<center><font size='3'><b>회원 관리 화면</b></font>
<center><font size='2'>클릭시 추가 정보를 볼 수 있습니다.</center>
<br>
                                    
<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>    

<TABLE border='0' cellspacing=1 cellpadding=2 width='600'>             
	<tr>
	<td colspan=3 width='600px' style="text-align: center; text-weight: bold; text-size:14px;">회원 정보</td>
	</tr>
<%
	strSQL = "SELECT * FROM tbllogin";
	rs = stmt.executeQuery(strSQL);
	int count = 1;
	while(rs.next()) {
		%><tr style="font-size:14px;"><%
		String id = rs.getString("id");
		if(id.equals("admin")) continue;
		String name = rs.getString("name");
		String zip = rs.getString("zip");
		String address1 = rs.getString("address1");
		String address2 = rs.getString("address2");
		String phone = rs.getString("phone");
		String email = rs.getString("email");
		String bday = rs.getString("bday");
		
		%>
		<tr style="font-size: 15px; height: 100px;">
		<td width='80px'style="background: green; color: white; text-align: center; text-weight: bold;"><%=count++%></td>
				<td width='470px' style="padding-left: 20px;"><a
								onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';"
								href="javascript:void(0)" style="text-weight:bold;"><%=id%> (<%=name%>)</a><div
									style="display: none; background: rgba(255, 255, 255, 0.7); padding: 10px; line-height:1.3em">
									주소: [<%=zip%>] <%=address1%> <%=address2%><br>
									전화번호: <%=phone%> | 이메일: <%=email%> | 생일: <%=bday%> 
								</div>
				</td>
				<td><form method='post' action='member_delete.jsp'>
				<input type="hidden" name="userid" value="<%=id%>">
				<input type="button" value="삭제"
						style="color: #fff; background-color: green; font-weight: bold; font-size: 9px; border: none; border-radius: 10px; padding-top: 5px; padding-bottom: 5px;"
						onclick="Del(this.form)"></form></td>
			</tr>
		<%
	}%>
	<tr>
	<TD align='right' colspan=3>
	<input class="button" type="button" onclick="goPage()" value="돌아가기">
	</TD>
	</tr>
</TABLE>

</body>
</html>