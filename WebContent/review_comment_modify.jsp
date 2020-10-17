<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />
<SCRIPT language="JavaScript">

function Check()
{
	
	if (Modify.contents.value.length < 1) {
		alert("댓글내용을 입력하세요.");
		Modify.contents.focus(); 
		return false;
	        }
Modify.submit();
}
</SCRIPT>
</head>
<body>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
String pd_num = request.getParameter("pd_num"); //제품번호 받아옴
String num = request.getParameter("num"); //리뷰번호 받아옴
String cm_id = request.getParameter("cm_id");

if (cm_id ==null) { %>
<script>
alert("오류가 발생했습니다. 다시 시도해 주세요.");
</script>

<% } 

String driverName = "com.mysql.jdbc.Driver";
String dbURL = "jdbc:mysql://localhost:3306/test";


Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL, "root", "dongyang");
Statement stmt = conn.createStatement();

PreparedStatement pstmt = null;
ResultSet rs = null;
 
try {

	 String strSQL = "SELECT * FROM tblcomment WHERE cm_id = ?";
	 pstmt = conn.prepareStatement(strSQL);
	 pstmt.setInt(1, Integer.parseInt(num));
	 
rs = pstmt.executeQuery();
rs.next();

int cm_rvnum = rs.getInt("cm_rvnum"); // 댓글이 달린 리뷰의 번호
String contents = rs.getString("contents").trim();
String writedate = rs.getString("cm_writedate");
%>
<center>
<form name="Modify" action="review_comment_modify_output.jsp" Method='POST' OnSubmit='return Check()'>
<input type='hidden' name='num' value='<%= num %>'>
<input type='hidden' name='pd_num' value='<%= pd_num %>'>
<input type='hidden' name='cm_id' value='<%= cm_id %>'>

<br><br><br>
<TABLE border='0' width='600' cellpadding='2' cellspacing='2'>
	<TR>
		<TD align="center">
		<input type='text' size='80' name='contents'> 
      	</TD>
	</TR>
	<tr>
		<td align="center">
		<input id="button" class="button" Type = 'Submit' Value = '댓글수정'>
		</td>
	</tr>
</TABLE>
</form>
<%
}catch(SQLException e){
   	out.print("SQL에러 " + e.toString());
}catch(Exception ex){
   	out.print("JSP에러 " + ex.toString());
}finally{  
}
%>
</body>
</html>