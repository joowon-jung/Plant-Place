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
		String driver = "org.gjt.mm.mysql.Driver";
		String url = "jdbc:mysql://localhost:3306/test";
		String user = "root";
		String pwd = "dongyang";
		Connection con = null;
		Statement stmt = null;

		String sql = "create table tbllogin( ";
		sql = sql + "id varchar(20), ";
		sql = sql + "pass varchar(20), ";
		sql = sql + "name varchar(20), ";
		sql = sql + "zip char(7), ";
		sql = sql + "address1 varchar(50), ";
		sql = sql + "address2 varchar(50), ";
		sql = sql + "phone varchar(20), ";
		sql = sql + "email varchar(30), ";
		sql = sql + "bday char(12), ";
		sql = sql + "PRIMARY KEY (id)) DEFAULT CHARSET=utf8;";
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, pwd);
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
			sql = "SET NAMES utf8;";
			stmt.executeUpdate(sql);
			// 관리자 추가
			String strSQL = "INSERT INTO tbllogin(id,pass,name,zip,address1,address2,phone,email,bday)";
			strSQL = strSQL +  "VALUES('admin', '1234', 'admin', '', '', '', '', '', '')"; 
			stmt.executeUpdate(strSQL);
			out.print("데이터베이스 연결 성공!");
			%><br><%
			out.print("관리자 아이디: admin, 패스워드: 1234");
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