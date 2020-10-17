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
String pd_num = request.getParameter("pd_num"); //제품번호 받아옴
String num = request.getParameter("num"); //리뷰번호 받아옴
Object user = session.getAttribute("user"); //유저id

 if (num ==null) { %>
	<script>
	alert("오류가 발생했습니다. 다시 시도해 주세요.");
	location.href = 'main.jsp';
	</script>
	<% 
}
String driverName = "org.gjt.mm.mysql.Driver";
String dbURL = "jdbc:mysql://localhost:3306/test";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");

PreparedStatement pstmt = null;
ResultSet rs = null;


String strSQL = "";

strSQL = "DELETE From tblreview WHERE rv_num=?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));
pstmt.executeUpdate();

strSQL = "UPDATE tblreview SET rv_num = rv_num - 1 WHERE rv_num > ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));
pstmt.executeUpdate();

/*  rs.close();
pstmt.close();
conn.close();  */
%>
<script>
alert("삭제가 완료되었습니다.");
location.href="product_detail.jsp?pd_num="+<%=pd_num%>+"&rv_page=1";
</script>
</body>
</html>