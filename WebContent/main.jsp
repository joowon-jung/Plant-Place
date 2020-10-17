<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<META HTTP-EQUIV="contentType" CONTENT="text/html;charset=UTF-8">
<title>식물공간</title>
<link rel="stylesheet" type="text/css" href="style-size.css"/>
<link rel="stylesheet" type="text/css" href="style-layout.css"/>
<link rel="stylesheet" type="text/css" href="style-presentation.css"/>
<link rel="stylesheet" type="text/css" href="style-selection.css"/>
<script>

function clickSignup() {
	width = 465;
	height = 470;
	pop_w = (screen.availWidth - width) / 2;
	pop_h = (screen.availHeight - height) / 2;
	
	window.open('signup.html', '회원가입', 'width='+width+', height='+height+', location=no, resizable=no, toolbar=no, left='+pop_w+', top='+pop_h);
}

</script>
</head>
<body>
<%
Object user = session.getAttribute("user");
Object name = session.getAttribute("name");
%>
<div class="wrap">
<header>
    <a id="logo" href="main.jsp"> <img src="images/name.jpg" height="100"></a>
    <span class="right" style="padding: 30px 10px;">
    <% if(user == null) { %>
    	<a href="member.jsp" target="display_area">로그인</a> |
        <a href="javascript:clickSignup()">회원가입</a>
    <% } else { %>
    	<% if(user.equals("admin")) { %>
    	<b>관리자</b> | 
    	<a href="logout.jsp" target="display_area">로그아웃</a> |
    	<a href="member_page.jsp" target="display_area">관리자페이지</a>
    	<% } else { %>
    	<b><%= name %></b> 님 안녕하세요! |
        <a href="logout.jsp" target="display_area">로그아웃</a> |
        <a href="member_page.jsp" target="display_area">마이페이지</a> |
        <a href="order.jsp" target="display_area">장바구니</a>
            <%} 
    	} %>
    </span>
</header>

<nav>
    <ul>
        <li><a href="menu_view.jsp?group=1" target="display_area">씨앗</a></li>
        <li><a href="menu_view.jsp?group=2" target="display_area">식물</a></li>
        <li><a href="menu_view.jsp?group=3" target="display_area">원예도구</a></li>
        <li><a href="menu_view.jsp?group=4" target="display_area">자갈/모래/흙</a></li>
        <li><a href="menu_view.jsp?group=5" target="display_area">영양제/비료</a></li>
    </ul>
</nav>

<hr/>

<article class="left" border="1">

    <iframe id="mainframe" name="display_area" src="main_image.html">
    </iframe>
    
</article>

<aside class="right">
    <div id="SNS">
       <a href="http://facebook.com" target="_blank">
           <img src="images/facebook.png" height="30" alt="Facebook" class="sns">
       </a>
       <br>
       <a href="http://twitter.com" target="_blank">
           <img src="images/twitter.png" height="30" alt="Twitter" class="sns">
       </a>
       <br>
       <a href="http://plus.google.com" target="_blank">
           <img src="images/googleplus-icon.png" height="30" alt="Google Plus" class="sns">
       </a>
    </div>
</aside>

<hr/>

<footer>  
   <div id="copyright">
       Copyright (c) 2019 Plant Place Inc. All rights reserved
   </div>
</footer>
</div>
</body>
</html>