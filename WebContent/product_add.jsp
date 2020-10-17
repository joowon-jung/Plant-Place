<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); //한글처리 %>
<jsp:useBean id="cartmanager" class="menu.CartManager" scope="session"/>
<jsp:useBean id="bean" class="menu.OrderBean"/>
<jsp:setProperty property="*" name="bean"/>
<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Object s_user = session.getAttribute("user");

if(s_user == null) { %>
<script> 
	location.href = 'member.jsp';
</script>
<% } else {
	String user = s_user.toString();
	String pd_num = request.getParameter("num");
	String amount = request.getParameter("amount");
	String flag = request.getParameter("flag");
	String price =request.getParameter("price");
	
	bean.setPd_num(pd_num);
	bean.setAmount(amount);
	bean.setPrice(price);
	if(flag == null) {
	cartmanager.addCart(bean);
	} else if(flag.equals("update")) {
		cartmanager.updateCart(bean);
		%><script>alert("선택하신 상품의 수량을 변경했습니다.");
		location.href = "order.jsp";</script><%
	} else if(flag.equals("delete")) {
		cartmanager.deleteCart(bean);
		%><script>alert("선택하신 상품을 삭제했습니다.");
		location.href = "order.jsp";</script><%
	}
}
%>
<script>history.back();</script>

</body>
</html>