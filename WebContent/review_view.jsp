<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />
</head>
<script>
function modify(rv_num, pd_num) { //리뷰 수정
	location.href = "review_modify.jsp?num="+rv_num+"&pd_num="+pd_num;
}

function goDelete(rv_num, pd_num) {
	location.href = "review_delete.jsp?num="+rv_num+"&pd_num="+pd_num;
}
</script>
<body style="width: 600px; margin: 0 auto; padding-bottom: 40px;">
	<%
String user = request.getParameter("name");

if(user == null) {
	%>
	<script>
		alert("잘못된 접근입니다.");
		location.href = 'main_image.html';
	</script>
	<%
	}

String driverName = "oracle.jdbc.driver.OracleDriver";
String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";

Class.forName(driverName);
Connection conn = DriverManager.getConnection(dbURL, "root", "dongyang");
Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE); 
Statement stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
ResultSet rs = null, rs2 = null;
String strSQL = "SELECT * FROM tblreview WHERE rv_userid='"+user+"'";
rs = stmt.executeQuery(strSQL);
%><p style="font-size: 14px; font-weight: bold;">내가 작성한 리뷰</p>
	<fieldset><%
if(rs.next()) {
	//dd
%>
		<table style="width: 600px; padding: 10px; text-align: center;">
			<tr style="width: 120px; height: 50px; border: 0px; background-color: green; color: white; font-weight: bold;">
				<th>제품 정보</th>
				<th>리뷰</th>
			</tr>
			<%
do {
	int pd_num = rs.getInt("rv_pdnum");
	int rv_num = rs.getInt("rv_num");
	String title = rs.getString("rv_title");
	String content = rs.getString("rv_contents");
	String date = rs.getString("rv_writedate");
	
	strSQL = "SELECT pd_file, pd_name FROM tblproduct WHERE pd_num = '"+pd_num+"'";
	rs2 = stmt2.executeQuery(strSQL);

	if(rs2.next()) {
		while(true) {
			String file = rs2.getString("pd_file");
			String name = rs2.getString("pd_name");
%>
			<tr style="font-size: 14px; height: 170px;">
				<td><a href="product_detail.jsp?pd_num=<%=pd_num%>&rv_page=1"><img
						src="images_pd/<%=file%>" width=100px style="padding-bottom: 5px;"><br><%= name %></a></td>
				<td>
					<table style="width: 460px; padding: 10px; text-align: left;">
						<tr>
							<td><a
								onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';"
								href="javascript:void(0)"><%=title%></a><div
									style="display: none; background: rgba(255, 255, 255, 0.7); padding: 10px;">
									<%=content%>
									<br>
									<br><%=date%>
									작성 <br>
									<br>
									<input type="button" class="button" value="수정하기" onClick="modify(<%=rv_num%>, <%=pd_num%>)"> 
									<input type="button" class="button" value="삭제하기" onClick="goDelete(<%=rv_num%>, <%=pd_num%>)">
								</div></td>
						</tr>
					</table>
				</td>
			</tr>
			<%
			if(rs2.isLast()) break;
			else rs2.next();
		}
	} 
} while(rs.next());
			%></table><%
} else {
%><p style="font-weight:bold; font-size:14px;">작성한 리뷰가 없습니다.</p><%
}
%>
</fieldset>
</body>
</html>