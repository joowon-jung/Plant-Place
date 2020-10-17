<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />
</head>
<body id="login">
<SCRIPT language="JavaScript">
function goMain() 
{
	location.href = 'main.jsp';
} 
function goProduct() 
{
	location.href = 'product_list.jsp';
}
function goMember()
{
	location.href = 'member_view.jsp'
}

</SCRIPT>

<TABLE cellSpacing='0' cellPadding='30' align='center' border='0'>
<%
try{
String strSession = session.getAttribute("user").toString();
String strName = session.getAttribute("name").toString();
	if(strName.equals("admin")){
		%>
		<tr>
		<td align='left'>
		<p><b>관리자 페이지입니다.</b></p>
		</td>
		<td> <input class="button" type='button' value='상품관리' onClick='goProduct()'><br><br>
		<input class="button" type='button' value='회원정보' onClick='goMember()'>
		</td>
		</tr>

		</TABLE>
	<jsp:include page = "order_view.jsp"/>
		<%
	}
	else {
%>

<TR>
	<TD align='left' style="font-size:14px;">
	<p><b><%= strName %></b> 님, 안녕하세요! </p>
	<p> 오늘도 식물공간에서 좋은 시간 보내세요! </p>
	<!-- 시간 남으면 개인 정보 수정도 넣을까 -->
	</TD>
</TR>
</TABLE>
<jsp:include page = "order_view_c.jsp"/>
<br><br>
<jsp:include page = "review_view.jsp">
	<jsp:param value="<%=strSession%>" name="name"/>
</jsp:include>

<%
	}
} catch(NullPointerException e){
%>
<script>
		alert("잘못된 접근입니다.");
		location.href = 'main_image.html';
</script>

</TABLE>

<%
}
%>



</body>
</html>