<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
int pd_num = Integer.parseInt(request.getParameter("pd_num"));
int num = Integer.parseInt(request.getParameter("num"));
String cm_id = request.getParameter("cm_id");
String contents = request.getParameter("contents");

String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";

    Class.forName(driverName);
    Connection conn = DriverManager.getConnection(dbURL, "root", "dongyang");
    Statement stmt = conn.createStatement();
    
    PreparedStatement pstmt = null;

Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

String strSQL = "";
strSQL = "update tblcomment set contents='"+contents+"', cm_writedate='"+indate+"' where cm_id="+cm_id;

stmt.executeUpdate(strSQL);

stmt.close();
conn.close();

%>
<script>
alert("수정이 완료되었습니다.");
parent.opener.location.reload();
self.close();
location.href("review_write_output.jsp?num=<%=num%>&pd_num=<%=pd_num%>");
</script>