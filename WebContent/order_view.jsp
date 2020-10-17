<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />
</head>
<body style="width: 600px; margin: 0 auto; padding-bottom: 40px;">
	<%
Object us = session.getAttribute("user");

if(us == null) {
	%>
	<script>
		alert("잘못된 접근입니다.");
		location.href = 'main_image.html';
	</script>
	<%
	}

String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL, "root", "dongyang");
Statement stmt = conn.createStatement();
Statement stmt2 = conn.createStatement();
Statement stmt3 = conn.createStatement();
ResultSet rs = null, rs2 = null, rs3 = null;
String strSQL = "SELECT * FROM tblorder ORDER BY od_num asc";
rs = stmt.executeQuery(strSQL);
if(rs.next()) {
String number = ""; 
%>
<p style="font-size: 14px; font-weight: bold;">주문내역</p>
<fieldset>
	<table style="width: 600px; padding: 10px; text-align: center;">
		<tr style="width: 100px; height: 50px; border: 0px; background-color: green; color: white; font-weight: bold;">
			<th>주문번호</th>
			<th>주문자명</th>
			<th>제품</th>
			<th>수량</th>
			<th>결제 금액</th>
		</tr>
		<%
do {
String od_num = rs.getString("od_num");
String subnum = od_num.substring(0,10);	//1906062215 (+1,+2...)
if(number.equals("")) {
	strSQL = "SELECT * FROM tblorder WHERE od_num LIKE '"+subnum+"%' ORDER BY od_num asc";
} else {
	strSQL = "SELECT * FROM tblorder WHERE od_num LIKE '"+subnum+"%'"+number+" ORDER BY od_num desc";
}
rs2 = stmt2.executeQuery(strSQL);
if(rs2.next()){
	%><tr>
			<td colspan=5><hr></td>
		<tr>
			<%
	while(true) {
		String num = rs2.getString("od_num");
		String user = rs2.getString("od_user");
		String pd = rs2.getString("od_pd");
		String amt = rs2.getString("od_amount");
		int price = rs2.getInt("od_price");
		
		strSQL = "SELECT pd_name, pd_file FROM tblproduct WHERE pd_num = '"+pd+"'";
		rs3 = stmt3.executeQuery(strSQL);
		rs3.next();
		
		String name = rs3.getString("pd_name");
		String file = rs3.getString("pd_file");
		%>
		
		<tr style="font-size: 14px; height: 100px;">
			<td><%= num %></td>
			<td><%= user %></td>
			<td><a href="product_detail.jsp?pd_num=<%=pd%>&rv_page=1"><img
						src="images_pd/<%=file%>" width=100px style="padding-bottom: 5px;"></a>
						<br><a href="product_detail.jsp?pd_num=<%=pd%>&rv_page=1"><%=name%></a></td>
			<td><%= amt %></td>
			<td><%= price %></td>
		</tr>
		<%
		if(rs2.isLast()) break;
		else rs2.next();
	}
	number += " and NOT od_num LIKE '"+subnum+"%' "; 
}
} while(rs.next());
} else {
	%> <p style="font-weight:bold; font-size:14px;">주문 내역이 없습니다.</p> <%
}
%>
	</table>
</fieldset>
</body>
</html>
