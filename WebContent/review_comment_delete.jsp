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
String pd_num = request.getParameter("pd_num");
String num = request.getParameter("num");
String cm_id = request.getParameter("cm_id");

if (cm_id ==null) { %>
<script>
alert("오류가 발생했습니다. 다시 시도해 주세요.");
</script>
<% 

}
String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");

PreparedStatement pstmt = null;
ResultSet rs = null;

String strSQL = "";

strSQL = "DELETE From tblcomment WHERE cm_id=?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(cm_id));
pstmt.executeUpdate();

strSQL = "UPDATE tblcomment SET cm_id = cm_id - 1 WHERE cm_id > ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(cm_id));
pstmt.executeUpdate();
%>
<script>
alert("삭제가 완료되었습니다.");
location.href("review_write_output.jsp?num=<%=num%>&pd_num=<%=pd_num%>");
</script>
</body>
</html>