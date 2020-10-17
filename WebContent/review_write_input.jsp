<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head><title>게시판 글쓰기</title>
</head>
<%
 response.setHeader("Cache-Control","no-store"); 
 response.setHeader("Pragma","no-cache"); 
%>
<% String pd_num; %>
<%
try{
pd_num = request.getParameter("pd_num"); //받아온 값
int num = Integer.parseInt(pd_num);
String user   = (String)session.getAttribute("user");
String title  = request.getParameter("title");
String contents  = request.getParameter("contents");

Calendar dateIn = Calendar.getInstance(); //시스템에 있는 날짜와 시간 얻어옴 
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
//MONTH는 0부터 시작하기 때문에 +1 해줌
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));


String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";


Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL, "root", "dongyang");
Statement stmt = conn.createStatement();

PreparedStatement pstmt1 = null, pstmt2 = null;

//글번호
// String strSQL = "SELECT Max(rv_num) FROM tblreview";
// pstmt1 = conn.prepareStatement(strSQL);
// ResultSet rs = pstmt1.executeQuery();
// int rv_num = 1;

// if (!rs.wasNull()){
// 	rs.next();
// 	rv_num = rs.getInt(1) + 1;	
// }	
// rs.close();

int rv_num = 1;
pstmt1 = conn.prepareStatement("select count(*) from tblproduct");
ResultSet rs = pstmt1.executeQuery();

String strSQL = "";

while (rs.next()) {
	rs.getInt(1);
	if (rs.wasNull()) {
		rv_num = 1;
	} else {
		strSQL = "SELECT Max(rv_num) FROM tblreview";
		rs = stmt.executeQuery(strSQL);
		rs.next();
		rv_num = rs.getInt(1) + 1;
	}
}
	
//값 집어넣음
strSQL ="INSERT INTO tblreview(rv_num, rv_pdnum, rv_userid, rv_title, rv_contents, rv_writedate, rv_readcount)";
strSQL = strSQL + "VALUES (?, ?, ?, ?, ?, ?, ?)";
pstmt2 = conn.prepareStatement(strSQL);

pstmt2.setInt(1, rv_num);
pstmt2.setInt(2, num); 
pstmt2.setString(3, user);
pstmt2.setString(4, title);
pstmt2.setString(5, contents);
pstmt2.setString(6, indate);
pstmt2.setInt(7, 0);
pstmt2.executeUpdate();


response.sendRedirect("product_detail.jsp?pd_num="+pd_num+"&rv_page=1"); //페이지 이동
%>
<body>
<%
pstmt1.close();
pstmt2.close();
conn.close();
}catch(SQLException e){
e.getStackTrace();
%>

게시판에 문제가 있습니다. 관리자에게 문의하세요.

<%
}
%>
</body>
</html>
