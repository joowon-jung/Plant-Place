<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<HTML>
<meta charset="UTF-8">
<HEAD>
<TITLE>게시판</TITLE>

<style type='text/css'>
a:link {
	font-family: "";
	color: black;
	text-decoration: none;
}

a:visited {
	font-family: "";
	color: black;
	text-decoration: none;
}

a:hover {
	font-family: "";
	color: black;
	text-decoration: underline;
}

body .head {
 text-align: center;
 height: 29px; border: 0px; background-color: green; color: white; font-weight: bold;
}
</style>
<script>
function goWrite(num)
{
	location.href="review_write.jsp?pd_num="+num;
}
</script>
</HEAD>
<BODY class="board">

	<%
String pd_num = request.getParameter("pd_num"); //받아옴
int num = 0;

if(pd_num != null) {
	num = Integer.parseInt(pd_num);
}
Object user = session.getAttribute("user");
String key = request.getParameter("key");
String keyword = request.getParameter("keyword");

String pageNum = request.getParameter("pageNum");
if(pageNum == null){
	pageNum = "1";	
}

int listSize = 5; //게시판 글 갯수
int currentPage = Integer.parseInt(pageNum); //현재 페이지
int lastRow = 0; //총 글의 갯수
int i = 0;
String strSQL = "";

   
    String driverName = "com.mysql.jdbc.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/test";


        Class.forName(driverName);
        Connection conn = DriverManager.getConnection(dbURL, "root", "dongyang");
        Statement stmt = conn.createStatement();

ResultSet rs = null;
if(num != 0) {
	strSQL = "SELECT count(*) FROM tblreview WHERE rv_pdnum="+num; //글 전체 갯수를 찾아줌 
} else {
	strSQL = "SELECT count(*) FROM tblreview";
}

rs = stmt.executeQuery(strSQL);
rs.next(); 
lastRow = rs.getInt(1); 

int startRow = lastRow - (listSize * currentPage) + 1; //1페이지 시작번호
int endRow = lastRow - ((currentPage - 1) * listSize + 1) + 1; //끝나는 글 번호
	
%>

	<center>
		<font size='3' style="font-weight:bold; color:green;">상품 리뷰</font>
		</TD>

		<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
			<TR>
				<TD><hr color='green' size='1' noshade></TD>
			</TR>
		</TABLE>

		<TABLE border='0' cellspacing=1 cellpadding=2 width='600'>

			<TR bgcolor='cccccc'>
				<TD class='head' width="50">
					<b>번호</b>
				</TD>
				<TD class='head' width="250">
					<b>글 제목</b>
				</TD>
				<TD class='head' width="100">
					<b>작성자</b>
				</TD>
				<TD class='head' width="150">
					<b>작성일</b>
				</TD>
				<TD class='head' width="50">
					<b>조회</b>
				</TD>
			</TR>

			<!-- 글 찍는 부분 -->
			<%
if(lastRow > 0) {
	int count = 1;
	if(num != 0){
		if(key==null || keyword==null){ //다 찾아서 찍음
			//번호 가져옴
			strSQL = "SELECT * FROM tblreview WHERE rv_pdnum="+num + " ORDER BY rv_num desc";
		}
		rs = stmt.executeQuery(strSQL);
	}

	int check = lastRow - (listSize * (currentPage-1));
	int checking = 5;
	if(check < listSize) checking = check;
	for(i = 1; i <= listSize * (currentPage-1); i++) {	// 실행X
		rs.next();
	}
		while(rs.next()){ //찾은 레코드로 이동

		int listnum = rs.getInt("rv_num");
		String name = rs.getString("rv_userid");
		String title = rs.getString("rv_title");
		String writedate = rs.getString("rv_writedate");
		int readcount = rs.getInt("rv_readcount");

%>

			<TR bgcolor='#E0FFDB' style="height:23px;">
				<TD align=center><font size=2 color='black'><%=listnum %></font></TD>
				<TD align=left>
				<a href="review_write_output.jsp?num=<%=listnum%>&pd_num=<%=num%>"> <!-- output으로 넘김 -->
						<font size=2 color="black"><%=title %></font></a></TD>
				<TD align=center><font size=2><%=name %></font></TD>
				<TD align=center><font size=2><%=writedate %></font></TD>
				<TD align=center><font size=2><%=readcount %></font>
			</TR>

			<%
		if(count++ == checking) break;
		}    
	

%>

		</TABLE>

		<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
			<TR>
				<TD><hr color='green' size='1' noshade></TD>
			</TR>
		</TABLE>

		<%
}
		
// 1 2 3 [] 뭐이런거 찍는부분

if(lastRow > 0) {
	int setPage = 1;
	int lastPage = 5; //한 페이지에 들어갈 글의 수
	if(lastRow % listSize == 0) //나머지가 0이면
		lastPage = lastRow / listSize;
	else //나머지가 있으면 +1 해줌
		lastPage = lastRow / listSize + 1;

	if(currentPage > 1) { //현재 페이지가 1보다 크면 [이전]보여줌
%>
		<a href="product_detail.jsp?rv_page=<%=currentPage-1%>&pd_num=<%=num%>">[이전]</a>
		<%	
	}
	for(i=setPage; i<=lastPage; i++) {
		if (i == Integer.parseInt(pageNum)){
%>
		[<%=i%>]
		<%		
		}else{
%>
		<a href="product_detail.jsp?rv_page=<%=i%>&pd_num=<%=num%>">[<%=i%>]
		</a>
		<%
		}
	}
	if(lastPage > currentPage) { //마지막페이지가 현재페이지보다 클때 [다음] 보여줌
%>
		<a href="product_detail.jsp?rv_page=<%=currentPage+1%>&pd_num=<%=num%>">[다음]</a>
		<%
	}
}
if(user != null){
%>

		<TABLE border=0 width=600>
			<TR>
				<TD align='right'>
				<input type="button" value="등록" onclick="goWrite(<%=num%>)" class="button">
				</TD>
			</TR>
		</TABLE>
<%} %>
</BODY>
</HTML>