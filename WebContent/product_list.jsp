<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style-size.css"/>
<link rel="stylesheet" type="text/css" href="style-layout.css"/>
<link rel="stylesheet" type="text/css" href="style-presentation.css"/>
<link rel="stylesheet" type="text/css" href="style-selection.css"/>
<SCRIPT>
function Check()
{
if (Form.keyword.value.length < 1) {
	alert("검색어를 입력하세요.");
	Form.keyword.focus(); 
         return false;
	}
}
</SCRIPT>
</head>
<body>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
Object user = session.getAttribute("user");

if(user==null || !user.equals("admin")) {
	%><script>
	alert("잘못된 접근입니다.");
	location.href = 'main.jsp';
	</script><%
}

String pageNum = request.getParameter("pageNum");
String showKey = request.getParameter("showKey");

if(pageNum == null){
	pageNum = "1";	
}


String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
String strSQL = "";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");

int listSize = 9;
int currentPage = Integer.parseInt(pageNum);

Statement stmt = conn.createStatement();
ResultSet rs = null;
if(showKey != null) {
	strSQL = "SELECT count(*) FROM tblproduct WHERE pd_group = "+showKey;
} else {
	strSQL = "SELECT count(*) FROM tblproduct";
}
rs = stmt.executeQuery(strSQL);
rs.next();


int startRow = (currentPage - 1) * listSize + 1;
int endRow = startRow + listSize - 1;
int lastRow = 0;
int i = 0;

lastRow = rs.getInt(1);

rs.close();

%>
<center>
<br><br>
<center><font size='3'><b>상품 관리 화면</b></font>
<br><Br>

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr color='green' size='1' noshade>
		</TD>
 	</TR>
</TABLE>
             <br>                       
<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
 	<tr>
 	<td>
 	<form method='get' action='product_list.jsp'>
		<select name='showKey' style="background-color:cccccc;" onchange="this.form.submit()">
			<option value='0' selected>==분류 전체 보기==</option>
			<option value='1'>씨앗</option>
			<option value='2'>식물</option>
			<option value='3'>원예도구</option>
			<option value='4'>자갈/모래/흙</option>
			<option value='5'>영양제/비료</option>
		</select>
 	</form>
 	</td>
 	</tr>
</TABLE>    

<TABLE border='0' cellspacing=1 cellpadding=2 width='600'>             

<%
if(lastRow > 0) {
	if(showKey != null && !showKey.equals("0")) {
		strSQL = "SELECT * FROM tblproduct WHERE pd_group = "+showKey;
	}else{
		strSQL = "SELECT * FROM tblproduct WHERE pd_num BETWEEN " + startRow + " and " + endRow;
	}
	rs = stmt.executeQuery(strSQL);

	for (i = 0; i < listSize; i++){	
		int j = 0;
%>
		<TR>
<%
		for(j = 0; j < 3; j++){		
			if(rs.next()){

			int pd_num = rs.getInt("pd_num");
			String pd_name = rs.getString("pd_name");
			int pd_price = rs.getInt("pd_price");
			int pd_group = rs.getInt("pd_group");
			String pd_file = rs.getString("pd_file");
%>
			<TD>
	
			<TABLE border='1' bgcolor='white'>
			<TR>
				<TD align=center width='170'>    
				<font size=2 color="black" style="font-weight: bold;">
                                    <%=pd_name %> / <%=pd_price %></a></font> 
				</TD>  
			</TR>
			<TR> 
				<TD align=center>
					<a href="product_listview.jsp?num=<%=pd_num %>">
					<img src=<%="images_pd/" + pd_file %> width="160" height="160"></a>
				</TD>  
			</TR>
			</TABLE> 
	
		</TD>   
<% 
			}else{
			break;	
			}
		}
		i = i + j;  
%>
		</TR>
<%  
	}	
%>
<Br>
<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr color='green' size='1' noshade>
		</TD>
 	</TR>
</TABLE>
                  	                   
<%
rs.close();
stmt.close();
conn.close();
}

if(lastRow > 0) {
	int setPage = 1;
	int lastPage = 0;
	if(lastRow % listSize == 0)
		lastPage = lastRow / listSize;
	else
		lastPage = lastRow / listSize + 1;

	if(currentPage > 1) {
%>	
		<a href="product_list.jsp?pageNum=<%=currentPage-1%>">[이전]</a>	
<%	
	}										//&keyword=<%=keyword&>&key=<=key>
	for(i=setPage; i<=lastPage; i++) {
		if (i == Integer.parseInt(pageNum)){
%>
		[<%=i%>]
<%		
		}else{
%>
		<a href="product_list.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%
		}
	}
	if(lastPage > currentPage) {
%>
		<a href="product_list.jsp?pageNum=<%=currentPage+1%>">[다음]</a>
<%
	}
}
%>  

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr color='green' size='1' noshade>
		</TD>
 	</TR>
</TABLE>                  

<TABLE border=0 width=600>
	<TR>
		<TD align='right'>		
		<a href="product_list.jsp">[새로고침]</a>
		<a href='product_write.jsp'>[등록]</a>	
					
		</TD>
	</TR>
</TABLE>

</body>
</html>