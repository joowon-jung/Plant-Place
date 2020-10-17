<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<HTML>
<HEAD>
<TITLE> 게시판 </TITLE>
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />
<META http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type='text/css'>
<!--
	a:link		{font-family:"";color:black;text-decoration:none;}
	a:visited	{font-family:"";color:black;text-decoration:none;}
	a:hover		{font-family:"";color:black;text-decoration:underline;}
-->

.button22 {
    width:30px;
    height:20px;
    background-color: white;
    border: none;
    color:green;
    padding: 10px 0;
    text-align: center;
    text-decoration: none;
    font-weight: bold;
    display: inline-block;
    font-size: 9px;
    margin: 0px;
    cursor: pointer;
    border-radius:10px;

}
</style>
<script>
function goList(num)
{
	location.href="product_detail.jsp?pd_num="+num+"&rv_page=1";
}

function goDelete(num, pd_num)
{
	var del = confirm("정말로 삭제하시겠습니까?");
	if(del == true) {
		location.href = "review_delete.jsp?num="+num+"&pd_num="+pd_num; //리뷰 번호
	}
}

function goModify(num, pd_num)
{
	var mod = confirm("수정하시겠습니까?");
	if(mod == true) {
		location.href = "review_modify.jsp?num="+num+"&pd_num="+pd_num;
	}
}

function cmDelete(num, pd_num, cm_id)
{
	var cmdel = confirm("삭제하시겠습니까?");
	if(cmdel == true) {
		location.href = "review_comment_delete.jsp?num="+num+"&pd_num="+pd_num+"&cm_id="+cm_id;
	}
}

function cmModify(num, pd_num, cm_id)
{
		width = 600;
		height = 150;
		pop_w = (screen.availWidth - width) / 2;
		pop_h = (screen.availHeight - height) / 2;
		
		window.open("review_comment_modify.jsp?num="+num+"&pd_num="+pd_num+"&cm_id="+cm_id, '회원가입', 'width='+width+', height='+height+', location=no, resizable=no, toolbar=no, left='+pop_w+', top='+pop_h);
}
</script>
</HEAD>

<BODY class="board">

<%
String pd_num = request.getParameter("pd_num");
String num = request.getParameter("num");
Object user = session.getAttribute("user");

String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";


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
<center>
<br><br>
<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>

<TABLE border='0' width='600'>
	<TR>
    		<TD align='left'>
      		<font size='2'> 작성자 : <%=name %></font>
    		</TD>
    		
    		<TD align=right>
      		<font size='2'>작성일: <%=writedate %>, 조회수: <%=readcount %></font>
    		</TD>
    	</TR>
</TABLE>

<TABLE border='0' cellspacing=3 cellpadding=3 width='600'>
	<TR bgcolor='green'>
		<TD align='center'>
    		<font size='3'><b><%=title %></font>
		</TD>
	</TR>
</TABLE>

<TABLE border='0' cellspacing=5 cellpadding=10 width='600'>
	<TR bgcolor='#E0FFDB'>
		<TD><font size='2' color=''><%=contents %></font>
		</TD>
	</TR>
</TABLE>

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
  	<TR>
  		<TD><hr size='1' noshade>
  		</TD>
  	</TR>
</TABLE>

<TABLE border='0' width='600'>
<%if(user != null) { %>
	<% if(name.equals(user)) { %> 
		<TD align='left'>
			<input class="button" type="button" onclick="goModify(<%=num%>,<%=pd_num%>)" value="수정하기">
			<input class="button" type="button" onclick="goDelete(<%=num%>,<%=pd_num%>)" value="삭제하기">
		</TD>
		<TD align='right'>
			<input class="button" type="button" onclick="goList(<%=pd_num%>)" value="목록보기">
 		</TD>
	<% } else if(user.equals("admin")) { %>
		<TD align='left'>
			<input class="button" type="button" onclick="goDelete(<%=num%>,<%=pd_num%>)" value="삭제하기">
		</TD>
		<TD align='right'>
			<input class="button" type="button" onclick="goList(<%=pd_num%>)" value="목록보기">
 		</TD>
		<%} else {
			%>
		<TD align='right'>
			<input class="button" type="button" onclick="goList(<%=pd_num%>)" value="목록보기">
 		</TD><%
		}
	} else { %>
		<TD align='right'>
			<input class="button" type="button" onclick="goList(<%=pd_num%>)" value="목록보기">
 		</TD>
 	<%  } %> 
</TABLE>
<%
strSQL = "UPDATE tblreview SET rv_readcount=rv_readcount+1 WHERE rv_num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));
pstmt.executeUpdate();

}catch(SQLException e){
   	out.print("SQL에러 " + e.toString());
}catch(Exception ex){
   	out.print("JSP에러 " + ex.toString());
}
if(user != null) {
	if(user.toString().equals("admin")) {
%>
<FORM Name='Plus' Action='review_comment_input.jsp' Method='post'>

<TABLE border='0' width='600' cellpadding='2' cellspacing='2'>
<input type='hidden' name='num' value='<%=num%>'>
<input type='hidden' name='pd_num' value='<%=pd_num %>'>
	<TR>
		<TD>
		&nbsp; <input type='text' size='78' name='comment'>
		<input id="button" class="button" Type = 'Submit' Value = '댓글등록'>
      	</TD>
	</TR>
</TABLE>

<%}
}%>

<%
String strSQL = "SELECT * FROM tblcomment WHERE cm_rvnum = '" + num +"'";
pstmt = conn.prepareStatement(strSQL);
rs = pstmt.executeQuery(); 

while(rs.next()){ 
%>
<TABLE border='0' width='600'>
	<TR bgcolor='white'>     
		 <TD>
		 <font size=2 color='black'>
		 	<b>운영자 : </b>
		 	<%=rs.getString("contents")%>
		 	(<%=rs.getString("cm_writedate")%>)
		 	<% if(user != null) { %>
		 	<% if(user.toString().equals("admin")) { %>
		 </font>
		 </TD>  
		 <Td align='right'>
		 	<input 
		 	class="button22" type="button" value="수정" onclick="cmModify(<%=num%>,<%=pd_num%>, <%=rs.getInt("cm_id")%>)">
		 	<input 
		 	class="button22" type="button" value="삭제" onclick="cmDelete(<%=num%>,<%=pd_num%>, <%=rs.getInt("cm_id")%>)">
		 	<% } } %>
		 </Td>        
	</TR> 
</TABLE>   	
<%     
}

rs.close();
pstmt.close();
conn.close();
%>
</BODY>
</HTML>
