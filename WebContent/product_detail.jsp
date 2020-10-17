<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>제품 상세 정보</title>
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />
<SCRIPT>
function check() //자바스크립트 함수 Check 
{
	Amount.submit();
	OD = confirm("장바구니에 추가되었습니다.\n장바구니로 이동하시겠습니까?");
	if(OD) {
		location.href = 'order.jsp';
	}	
} 
function goLogin()
{
	location.href = 'login.jsp'; 
}
</SCRIPT>
</head>
<body class="detail">

<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL,"root","dongyang");

String pd_num = request.getParameter("pd_num"); //제품번호 담음

PreparedStatement pstmt = null;
ResultSet rs = null;

String pd_name;
int pd_price;
String pd_file;

Object user = session.getAttribute("user");
String rv_page = request.getParameter("rv_page");

//모든걸 다 찾아옴
String strSQL = "SELECT * FROM tblproduct WHERE pd_num=?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(pd_num));

rs = pstmt.executeQuery();
rs.next();

//꺼내옴
pd_name = rs.getString("pd_name");
pd_price = rs.getInt("pd_price");
pd_file = rs.getString("pd_file");

request.setCharacterEncoding("UTF-8");
request.setAttribute("pd_num", pd_num);
rs.close();
%>
<center> 

<fieldset>
<br>
<legend><font size='3' style="font-weight:bold; color:green;">제품 상세 정보</font></legend>
<br><br>
	<table cellspacing=0>
		<tr>
			<td>
				<img src="images_pd/<%=pd_file%>" width="240" height="200">
			</td>
			<td>
				<table border="2" width="300" height="200">
					<tr align="center">
						<td><b>상품명</b></td>
						<td><%=pd_name%></td>
					</tr>
					<tr align="center">
						<td><b>가격</b></td>
						<td><%=pd_price%></td>
					</tr>
					<tr align="center">
						<td colspan="2">
							<form name='Amount' method='post' action='product_add.jsp'>
								<input type="hidden" name="num" value="<%=pd_num%>">
								<input type="number" name="amount" value="1" size="4" style="text-align:center;">&nbsp;개
								<input type="hidden" name="price" value="<%=pd_price%>">
								<%if(user != null) { %>
								<input class="button" onclick="javascript:check();" type='button' value='+ 장바구니'>
								<%} %>
							</form>
							
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br><br><br>
	<jsp:include page="review_list.jsp?pd_num<%=pd_num%>">
		<jsp:param value="<%=rv_page%>" name="pageNum"/>
	</jsp:include>
	<br>
	</fieldset>
</body>
</html>