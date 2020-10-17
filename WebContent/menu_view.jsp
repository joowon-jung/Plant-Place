<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style-size.css"/>
<link rel="stylesheet" type="text/css" href="style-layout.css"/>
<link rel="stylesheet" type="text/css" href="style-presentation.css"/>
<link rel="stylesheet" type="text/css" href="style-selection.css"/>
</head>
<style>
</style>
<body class="booklist">
	<%@ page import="java.sql.*, java.util.*"%>
	<% request.setCharacterEncoding("UTF-8"); %>

	<%
		// 이미지 파일 이름을 배열로 저장하여 상단에 이미지 첨부할 때 사용함
		String[] head_images = new String[6];
		head_images[1] = "head_seed.jpg";
		head_images[2] = "head_plant.jpg";
		head_images[3] = "head_tools.jpg";
		head_images[4] = "head_others.jpg";
		head_images[5] = "head_nutrition.jpg";
		String path = "C:/Users/ppoxx/eclipse-workspace/Plant_Place/WebContent/";

		String strgroup = request.getParameter("group");
		if (strgroup == null)
			strgroup = "1";
		int group = Integer.parseInt(strgroup);

		int i = 0;

		String strSQL = "";

		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://localhost:3306/test";

		Class.forName(driverName);
		Connection conn = DriverManager.getConnection(dbURL, "root", "dongyang");

		Statement stmt = conn.createStatement();
		ResultSet rs = null;
		strSQL = "SELECT count(*) FROM tblproduct where pd_group=" + group;

		rs = stmt.executeQuery(strSQL);
		rs.next();

		int itemCount = rs.getInt(1);

		String image_path = path + "images/" + head_images[group];

		rs.close();
	%>
	<div class="head">
		<img src="<%=image_path%>" height=25px>
	</div>
	<!-- 상단 사진 출력 -->

	<ul class="pro_ul">
		<%
			if (itemCount > 0) {
				strSQL = "select * from tblproduct where pd_group=" + group;
				rs = stmt.executeQuery(strSQL);
			}

			for (i = 0; i < itemCount; i++) {
					if (rs.next()) {
						int num = rs.getInt("pd_num"); //제품 번호
						String name = rs.getString("pd_name");
						int price = rs.getInt("pd_price");
						String file = rs.getString("pd_file");

						image_path = path + "images_pd/" + file;
		%>
		<li class="pro_li">
		<a href="product_detail.jsp?pd_num=<%=num%>&rv_page=1">
		<img src="<%=image_path%>"><br />
		<b><%=name%></b><br /></a><%=price%>원<br />
		</li>
			<%
				} else {
							break;
						}
				}
			%>
	</ul>
</body>
</html>