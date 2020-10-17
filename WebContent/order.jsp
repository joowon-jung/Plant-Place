<%@page import="java.sql.*, java.util.*, menu.OrderBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="cartmanager" class="menu.CartManager" scope="session" />
<!DOCTYPE HTML>
<html>
<head>
<META HTTP-EQUIV="contentType" CONTENT="text/html;charset=UTF-8">
<title>Order Page</title>
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />
<script>
function cartDelete(form){
	form.flag.value="delete";
	form.submit();
}

function cartUpdate(form) {
	if(form.amount.value != null && form.amount.value <= 0) {
		alert("유효하지 않은 값입니다.");
		return;
	}
	form.flag.value="update";
	form.submit();
}

function Check(form) {
	if(form.amount.value != null && form.amount.value <= 0) {
		alert("유효하지 않은 값입니다.");
		return false;
	}
	else return true;
}

function goOrder() {
	var del = confirm("주문하시겠습니까?");
	if(del == true) {
		location.href = "order_ok.jsp";
	} else {
		return false;
	}
}
</script>
</head>

<body id="order">
	<fieldset>
		<legend align=left>
			<img src="images/head_cart.jpg">
		</legend>
		<br> <br>
		<%
			int totalPrice = 0, totalCount = 0;
			Hashtable<String, OrderBean> hCart = cartmanager.getCartList();
			Object user = session.getAttribute("user");
			boolean showBtn = true;
			if (user == null) {
		%><script>
		alert("잘못된 접근입니다.");
		location.href = 'main.jsp';
		</script>
		<%
			}
		%>
		<table>
			<tr>
				<th>이미지</th>
				<th>상품</th>
				<th>가격</th>
				<th>수량</th>
				<th>합계</th>
				<th>삭제</th>
			</tr>
		</table>
		<%
			if (hCart.size() == 0) {
		%>
		<div style="text-align:center;"><p style=" font-size:14px; font-weight: bold;">
		장바구니가 비어 있습니다.</p></div>
		<%	showBtn = false;
		
			} else {
				String strSQL = "";
				String driverName = "oracle.jdbc.driver.OracleDriver";
				String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";

				Class.forName(driverName);
				Connection conn = DriverManager.getConnection(dbURL, "root", "dongyang");
				Statement stmt = conn.createStatement();
				ResultSet rs = null;

				Enumeration<String> enu = hCart.keys();
				while (enu.hasMoreElements()) {
					OrderBean order = (OrderBean) hCart.get(enu.nextElement());
					String pd_num = order.getPd_num();

					strSQL = "SELECT * FROM tblproduct where pd_num=" + pd_num;
					rs = stmt.executeQuery(strSQL);
					rs.next();

					String name = rs.getString("pd_name");
					int price = rs.getInt("pd_price");
					String file = rs.getString("pd_file");
					String amount = order.getAmount();
					int price_result = Integer.parseInt(order.getAmount()) * price;
					totalPrice += price_result;
					totalCount += Integer.parseInt(amount);
		%>
		<form method='post' action='product_add.jsp'
			onsubmit='return Check(this.form)'>
			<table class="ordert">
				<tr>
					<td><a href="product_detail.jsp?pd_num=<%=pd_num%>&rv_page=1"> <img
							src="images_pd/<%=file%>" width="80" height="70"></a></td>
					<td><a href="product_detail.jsp?pd_num=<%=pd_num%>&rv_page=1"><b><%=name%></b></a></td>
					<td><%=price%></td>
					<td><input type="text" value="<%=order.getAmount()%>" size=1
						style="border: none; text-align: center;" readonly><br>
					<br> <input type="text" name="amount" size=1
						style="border: 1; text-align: center;"> 
						<input type="button" value="변경"
						style="color: #fff; background-color: green; font-weight: bold; font-size: 11px; border: none; border-radius: 10px; padding-top: 5px; padding-bottom: 5px;"
						onclick=cartUpdate(this.form)></td>
					<td><%=price_result%> 원</td>
					<td><input type="hidden" name="flag" value="update">
					<input type="hidden" name="num" value="<%=pd_num%>">
					<input type="hidden" name="price" value="<%=price_result%>">
					<input type="button" value="X"
						style="color: #fff; background-color: green; font-weight: bold; font-size: 9px; border: none; border-radius: 10px; padding-top: 5px; padding-bottom: 5px;"
						onclick=cartDelete(this.form);></td>
				</tr>
			</table>
		</form>
		<%
			}
				rs.close();
		%><br>
		<div align=right
			style="font-size: 18px; font-weight: bold; letter-spacing: 1px;">
			총
			<%=totalCount%>개 ···
			<%=totalPrice%>
			원 &nbsp;&nbsp;
		</div>
		<%
			
			}
		%><br /> <br>
		<% if(showBtn) {%>
		<div align=center>
			<input class="button" type="button" value="더 담기"
				onclick="history.back(-2); return false;">
			<input class="button" type="button" value="주문하기" onclick="goOrder()">
		</div>
		<%} %>
		<br> <br>
	</fieldset>
</body>
</html>
