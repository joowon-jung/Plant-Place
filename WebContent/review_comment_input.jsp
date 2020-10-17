<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
String num = request.getParameter("num");		// 리뷰 번호
String contents = request.getParameter("comment");
String pd_num = request.getParameter("pd_num");
int num_plus = 0;

String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");

Statement stmt = conn.createStatement();

String strSQL = "SELECT cm_id FROM tblcomment ORDER BY cm_id DESC";
ResultSet rs = stmt.executeQuery(strSQL);

// if(rs.wasNull())  
// 	num_plus = 1;
// else {
//     	strSQL = "SELECT Max(cm_id) FROM tblcomment";
//     	rs = stmt.executeQuery(strSQL);
//     	rs.next();
//     	num_plus = rs.getInt(1) + 1;
// }

while (rs.next()) {
	rs.getInt(1);
	if (rs.wasNull())
		num_plus = 1;
	else {
		strSQL = "SELECT Max(cm_id) FROM tblcomment";
		rs = stmt.executeQuery(strSQL);
    	rs.next();
    	num_plus = rs.getInt(1) + 1;
	}
}

Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));


strSQL ="INSERT INTO tblcomment (cm_id, cm_rvnum, contents, cm_writedate)";
strSQL = strSQL +  "VALUES('" + num_plus + "', '" + num + "', '" + contents + "', '" + indate + "')";
stmt.executeUpdate(strSQL);

stmt.close();
conn.close();
%>
<script>
location.href("review_write_output.jsp?num=<%=num%>&pd_num=<%=pd_num%>");
</script>
</body>
</html>