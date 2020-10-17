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
Object s_user = session.getAttribute("user");

if(!s_user.equals("admin")) { %>
<script> 
	alert("잘못된 접근입니다.");
	location.href = 'member.jsp';
</script>
<% } else {
	String id = request.getParameter("userid");
	
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://localhost:3306/test";

	Class.forName(driverName);
	Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");
	
	Statement stmt = conn.createStatement();
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String strSQL = "";
	strSQL = "SELECT * FROM tblreview WHERE rv_userid='"+id+"'";
	rs = stmt.executeQuery(strSQL);
	
	if(rs.next()) {
		do {
			int rv_num = rs.getInt("rv_num");
			
			strSQL = "DELETE FROM tblcomment WHERE cm_rvnum=?";
			pstmt = conn.prepareStatement(strSQL);
			pstmt.setInt(1, rv_num);
			pstmt.executeUpdate();
			
		}while(rs.next());
	}
	
	strSQL = "DELETE FROM tblreview WHERE rv_userid=?";
	pstmt = conn.prepareStatement(strSQL);
	pstmt.setString(1, id);
	pstmt.executeUpdate();
	
	strSQL = "DELETE FROM tblorder WHERE od_user=?";
	pstmt = conn.prepareStatement(strSQL);
	pstmt.setString(1, id);
	pstmt.executeUpdate();
	
	strSQL = "DELETE From tbllogin WHERE id=?";
	pstmt = conn.prepareStatement(strSQL);
	pstmt.setString(1, id);
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
}
%>
<script>
alert("탈퇴 처리가 완료되었습니다.");
location.href="member_view.jsp";
</script>
</body>
</html>