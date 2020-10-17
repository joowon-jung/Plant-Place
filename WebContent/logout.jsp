<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
if(session.getAttribute("user")!=null || session.getAttribute("name") !=null) 
{
		session.invalidate();
		out.print("<script>");
		out.print("parent.location.href = 'main.jsp';");
		out.print("</script>");
}
%>
</body>
</html>