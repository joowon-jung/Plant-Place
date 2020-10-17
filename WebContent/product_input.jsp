<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import = "java.sql.*" %>
<%@page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*, java.io.*" %>

<%
String realFolder = "";
String savePath = "C:/Users/ppoxx/eclipse-workspace/Plant_Place/WebContent/images_pd/";
int sizeLimit = 5 * 1024 * 1024; // 최대 업로드 파일 크기 5MB(메가)로 제한
DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

String encType = "UTF-8";

ServletContext context = getServletContext();

String driverName = "org.gjt.mm.mysql.Driver";
String dbURL = "jdbc:mysql://localhost:3306/test";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");
MultipartRequest multi = null;
multi = new MultipartRequest(request,savePath,sizeLimit,encType,policy);

String pd_num = multi.getParameter("pd_num"); 
String userName = multi.getParameter("name");
String fileName = multi.getFilesystemName("userFile");
String flag = multi.getParameter("flag");

String name = multi.getParameter("pname");  
String price = multi.getParameter("pprice"); 
String group = multi.getParameter("pgroup");

Statement stmt = conn.createStatement();

String strSQL = "SELECT Max(pd_num) FROM tblproduct";
ResultSet rs = stmt.executeQuery(strSQL);
int num = 1;

if (!rs.wasNull()){
	rs.next();
	num = rs.getInt(1) + 1;	
}

if(flag.equals("modify")) {
	if(fileName == null) strSQL = "UPDATE tblproduct SET pd_name='"+name+"', pd_price='"+price+"', pd_group='"+group+"' WHERE pd_num="+pd_num+";";
	else {
		strSQL = "UPDATE tblproduct SET pd_name='"+name+"', pd_price='"+price+"', pd_group='"+group+"', pd_file='"+fileName+"' WHERE pd_num="+pd_num+";";
		
	}
} else {
	
strSQL ="INSERT INTO tblproduct (pd_num, pd_name, pd_price, pd_group, pd_file)";
strSQL = strSQL +  "VALUES('" + num + "', '" + name + "', '" + price + "', '" + group + "',";
strSQL = strSQL +  "'" + fileName + "')";
}
stmt.executeUpdate(strSQL);

stmt.close();                	
conn.close();

response.sendRedirect("product_list.jsp"); 
%>


</body>
</html>