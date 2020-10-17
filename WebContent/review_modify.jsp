<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />
<title>Insert title here</title>

<SCRIPT language="JavaScript">

function Check()
{
if (Modify.title.value.length < 1) {
	alert("글제목을 입력하세요.");
	Modify.title.focus(); 
	return false;
        }

if (Modify.contents.value.length < 1) {
	alert("글내용을 입력하세요.");
	Modify.contents.focus(); 
	return false;
        }

Modify.submit();
}
</SCRIPT>
</head>
<body class="board">
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
String pd_num = request.getParameter("pd_num"); //제품번호 받아옴
String num = request.getParameter("num"); //리뷰번호 받아옴
Object user = session.getAttribute("user"); //유저id

 if (num ==null) { %>
	<script>
	alert("오류가 발생했습니다. 다시 시도해 주세요.");
	location.href = 'main.jsp';
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

	 String strSQL = "SELECT * FROM tblreview WHERE rv_num = ?";
	 pstmt = conn.prepareStatement(strSQL);
	 pstmt.setInt(1, Integer.parseInt(num));

rs = pstmt.executeQuery();
rs.next();

String name = rs.getString("rv_userid");
String title = rs.getString("rv_title");
String contents = rs.getString("rv_contents").trim();
String writedate = rs.getString("rv_writedate");
int readcount = rs.getInt("rv_readcount");
%>

<center><font size='3'><b> 리뷰 수정 </b></font> 

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>

<FORM Name='Modify' Action='review_modify_output.jsp' Method='POST' OnSubmit='return Check()'>
<input type='hidden' name='num' value='<%= num %>'>
<input type='hidden' name='pd_num' value='<%= pd_num %>'>

<TABLE border='0' width='600'>
	<TR>
		<TD class="head">
			<font size='2'><center><b>작성자</b></center></font> 
		</TD>
		<TD>
		<% if(user == null) { 
			 %><script>location.href("main_image.html");</script><%
		   } else { %>
			<p><%=name %></p>
		<% } %>
		</TD>
	</TR>
	
	<TR>
		<TD class="head">
			<font size='2'><center><b>글 제목</b></center></font>
		</TD>
		<TD>
			<font size='2'><input type='text' size='73' maxlength='50' name='title' value="<%=title %>"></font>
		</TD>
	</TR>
	
	<TR>
		<TD class="head">
			<font size='2'><center><b>글 내용</b></center></font>
		</TD>
		<TD>
         		<font size='2'>
         		<textarea cols='55' rows='15' wrap='virtual' name='contents'><%=contents %></textarea>
         		</font>
      		</TD>
	</TR>
	
	<TR>
		<TD colspan='2'><hr size='1' noshade></TD>
	</TR>
	
	<TR>
		<TD colspan='2' style="width:600px; text-align:center; margin:auto;">
					<input class="button" Type = 'Reset' Value = '다시 작성'>
					<input class="button" Type = 'Button' Value = '수정 완료' Name='Page' onClick='Check();'>
					</TD>
			</TR>
		</TABLE>
	</FORM>
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