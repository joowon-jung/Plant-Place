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
<%@page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*, java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%

String num = request.getParameter("num");
Object user = session.getAttribute("user");

if(user==null || !user.equals("admin")) {
	%><script>
	alert("잘못된 접근입니다.");
	location.href = 'main.jsp';
	</script>
<%} else if(num == null) { %>
<script>
alert("오류가 발생했습니다. 다시 시도해 주세요.");
location.href = 'product_list.jsp';
</script>

<% 
}
String savePath = "C:/Users/ppoxx/eclipse-workspace/Plant_Place/WebContent/images_pd/";
int sizeLimit = 5 * 1024 * 1024; // 최대 업로드 파일 크기 5MB(메가)로 제한

String encType = "UTF-8";

ServletContext context = getServletContext();

String driverName = "org.gjt.mm.mysql.Driver";
String dbURL = "jdbc:mysql://localhost:3306/test";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");

PreparedStatement pstmt = null;
ResultSet rs = null;


String strSQL = "";

strSQL = "SELECT * FROM tblproduct WHERE pd_num=" + num;
Statement stmt = conn.createStatement();
rs = stmt.executeQuery(strSQL);

rs.next();
String delfile = rs.getString("pd_file");
stmt.close();


String fileUrl = "C:/Users/ppoxx/eclipse-workspace/Plant_Place/WebContent/images_pd/" + delfile;
boolean fileexists = true;
try
{
 ServletContext cxt = getServletConfig().getServletContext();
 String file = cxt.getRealPath(fileUrl);
 File fileEx = new File(fileUrl);
 if(fileEx.exists())
 {
  fileEx.delete();
 }
}
catch(Exception e) 
{
    e.printStackTrace();
 }

strSQL = "DELETE From tblproduct WHERE pd_num=?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));
pstmt.executeUpdate();
	
strSQL = "UPDATE tblproduct SET pd_num = pd_num - 1 WHERE pd_num > ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));
pstmt.executeUpdate();

rs.close();
pstmt.close();
conn.close();
%>
<script>
alert("삭제가 완료되었습니다.");
location.href="product_list.jsp";
</script>
</body>
</html>