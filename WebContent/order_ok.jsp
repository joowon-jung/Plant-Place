<%@page import="java.sql.*, java.util.*, java.text.*, menu.OrderBean, menu.CartManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="cartmanager" class="menu.CartManager" scope="session" />
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
<body>
	<%
	Object us = session.getAttribute("user");
	if(us == null) {
		%>
		<script>
	alert("잘못된 접근입니다.");
	location.href = 'main.jsp';
	</script>
		<%
	}
	
	Hashtable<String, OrderBean> hCart = cartmanager.getCartList();
	String strSQL = "";
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/test";

    Class.forName(driverName);
    Connection conn = DriverManager.getConnection(dbURL, "root", "dongyang");
    Statement stmt = conn.createStatement();
    ResultSet rs = null;
    int plusnum = 0;
    
	SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmm");
	// 주문번호 형식: 1906062030+1, 1906062030+2 
    Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime());
	String date = strToday + "+" + Integer.toString(plusnum);
	
    Enumeration<String> enu = hCart.keys();
    while(enu.hasMoreElements()) {
    	OrderBean order= (OrderBean)hCart.get(enu.nextElement());
    	String user = us.toString();
    	String pd_num = order.getPd_num();
		String amount = order.getAmount();
		String price = order.getPrice();
		
		int intamt = Integer.parseInt(amount);
    	
    	strSQL = "SELECT * FROM tblproduct where pd_num="+pd_num;
		rs = stmt.executeQuery(strSQL);
		rs.next();
		String name = rs.getString("pd_name");
	
		strSQL = "SELECT * FROM tblorder where od_num="+date;
		rs = stmt.executeQuery(strSQL);
		if (!rs.wasNull()){
			rs.next();
			plusnum++;
		}
		
		date = strToday + "+" + Integer.toString(plusnum);
			
		strSQL ="INSERT INTO tblorder (od_num, od_user, od_pd, od_amount, od_price)";
		strSQL = strSQL +  "VALUES('" + date + "', '" + user + "', '" + pd_num + "', '" + amount + "', '"+price+"')";
		stmt.executeUpdate(strSQL);
    }
	rs.close();
    stmt.close();                	
	conn.close();
	session.setAttribute("cartmanager", new CartManager());
		%>
	<script>
	alert("주문 완료되었습니다!");
	location.href="main_image.html";
	</script>
		
</body>
</html>