<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
int num  = Integer.parseInt(request.getParameter("num"));
int pd_num = Integer.parseInt(request.getParameter("pd_num"));
String name = request.getParameter("name");
String title = request.getParameter("title");
String contents = request.getParameter("contents");

String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";


    Class.forName(driverName);
    Connection conn = DriverManager.getConnection(dbURL, "root", "dongyang");
    Statement stmt = conn.createStatement();

PreparedStatement pstmt = null;

Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

String strSQL = "";
strSQL = "update tblreview set rv_title='"+title+"', rv_contents='"+contents+"', rv_writedate='"+indate+"' where rv_num="+num;

stmt.executeUpdate(strSQL);

stmt.close();
conn.close();

response.sendRedirect("product_detail.jsp?pd_num="+pd_num+"&rv_page=1");
%>