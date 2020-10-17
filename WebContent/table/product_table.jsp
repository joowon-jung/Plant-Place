<!-- 제품 DB -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>

	<%@ page import="java.sql.*"%>
	<%
		request.setCharacterEncoding("UTF-8");
	%>

	<%
		String driver = "org.gjt.mm.mysql.Driver";
		String url = "jdbc:mysql://localhost:3306/test";
		String user = "root";
		String pwd = "dongyang";
		Connection con = null;
		Statement stmt = null;

		String sql = "create table tblproduct( ";
		sql = sql + "pd_num int, ";
		sql = sql + "pd_name varchar(20), ";
		sql = sql + "pd_price int, ";
		sql = sql + "pd_group int, ";		// 분류(씨앗 등)
		sql = sql + "pd_file varchar(200), ";
		sql = sql + "PRIMARY KEY (pd_num)) DEFAULT CHARSET=utf8;";
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, pwd);
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
			sql = "SET NAMES utf8;";
			stmt.executeUpdate(sql);
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