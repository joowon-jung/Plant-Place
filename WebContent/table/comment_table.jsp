<!-- 회원 DB -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%@ page import="java.sql.*"%>
	<%
		request.setCharacterEncoding("UTF-8");
	%>

	<%
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String user = "root";
		String pwd = "dongyang";
		Connection con = null;
		Statement stmt = null;

		String sql = "create table tblcomment( ";
		sql = sql + "cm_id number, ";		// 댓글 고유번호
		sql = sql + "cm_rvnum number, ";	// 댓글이 달린 리뷰의 번호
		sql = sql + "contents clob, ";	// 내용
		sql = sql + "cm_writedate varchar2(20), ";
		sql = sql + "foreign key(cm_rvnum) references tblreview(rv_num),";
		sql = sql + "PRIMARY KEY (cm_id)) ";
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, pwd);
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
			//sql = "SET NAMES utf8;";
			//stmt.executeUpdate(sql);
			out.print("데이터베이스 연결 성공!");
		} catch (Exception e) {
			out.print("데이터베이스 연결 실패!" + e);
		} finally {
			try {
				if (con != null)
					con.close();
				if (stmt != null)
					stmt.close();
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		}
	%>
</body>
</html>