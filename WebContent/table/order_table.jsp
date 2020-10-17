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
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String user = "root";
		String pwd = "dongyang";
		Connection con = null;
		Statement stmt = null;

		String sql = "create table tblorder( ";
		sql = sql + "od_num varchar2(15), ";
		sql = sql + "od_user varchar2(20), ";
		sql = sql + "od_pd number, ";
		sql = sql + "od_amount number, ";
		sql = sql + "od_price number, ";
		sql = sql + "foreign key(od_user) references tbllogin(id),";
		sql = sql + "foreign key(od_pd) references tblproduct(pd_num),";
		sql = sql + "PRIMARY KEY (od_num))";
		
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