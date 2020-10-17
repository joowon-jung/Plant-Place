<!-- 리뷰 DB / 외래키 있으므로 반드시 회원 DB, 제품 DB 생성 후 실행 -->
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

		String sql = "create table tblreview( ";
		sql = sql+ "rv_num number,";
		sql = sql + "rv_pdnum number, "; //제품번호
	     sql = sql + "rv_userid varchar2(20), "; //유저아이디
	     sql = sql+ "rv_title varchar2(50),";
	     sql = sql+ "rv_contents varchar2(100),";
	     sql = sql+ "rv_writedate varchar2(20),";
	     sql = sql+ "rv_readcount number, ";
	     sql = sql+ "foreign key(rv_userid) references tbllogin(id), ";
		sql = sql + "foreign key(rv_pdnum) references tblproduct(pd_num),";
		sql = sql + "PRIMARY KEY (rv_num))";
		
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