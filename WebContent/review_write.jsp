<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<HTML>
<HEAD>
<TITLE> 게시판 </TITLE>
<link rel="stylesheet" type="text/css" href="style-size.css" />
<link rel="stylesheet" type="text/css" href="style-layout.css" />
<link rel="stylesheet" type="text/css" href="style-presentation.css" />
<link rel="stylesheet" type="text/css" href="style-selection.css" />

<SCRIPT>
function Check() //자바스크립트 함수 
{
if (Write.title.value.length < 1) {
	alert("글제목을 입력하세요.");
	Write.write_title.focus(); 
	return false;
        }

if (Write.contents.value.length < 1) {
	alert("글내용을 입력하세요.");
	Write.content.focus(); 
	return false;
        }

Write.submit();
}

</SCRIPT>
</HEAD>

<BODY class="board">
<%
Object user = session.getAttribute("user");
Object name = session.getAttribute("name");

int pd_num = Integer.parseInt(request.getParameter("pd_num"));
%>
<center><font size='3'><b> 리뷰 작성 </b></font>                   
<FORM Name='Write' Action='review_write_input.jsp' Method='get' OnSubmit='return Check()'>

<TABLE border='0' width='600' cellpadding='2' cellspacing='2'>
	<TR>
		<TD colspan='2'><hr size='1' noshade>
		</TD>
 	</TR>
	<TR>
		<TD class="head">
			<font size='2'><center><b>작성자</b></center></font> 
		</TD>
		<TD>
		<% if(user == null) { 
			 %><script>location.href("main_image.html");</script><%
		   } else { %>
			<p><%=user %></p>
		</TD>
		<% } %>
	</TR>


	<TR>
		<TD class="head">
			<font size='2'><center><b>글 제목</b></center></font>
		</TD>
		<TD>
			<font size='2'><input type='text' size='73' maxlength='50' name='title'></font>
			<input type="hidden" value="<%=pd_num%>" name="pd_num"> 
		</TD>
	</TR>

	<TR>
		<TD class="head">
			<font size='2'><center><b>글 내용</b></center></font>
		</TD>
		<TD>
         		<font size='2'>
         		<textarea cols='55' rows='15' wrap='virtual' name='contents' ></textarea>
         		</font>
      		</TD>
	</TR>

	<TR>
      		<TD colspan='2'>
         		<hr size='1' noshade>
      		</TD>
	</TR>

			<TR>
				<TD colspan='2' style="width:600px; text-align:center; margin:auto;">
					<input class="button" type = "reset" value = '다시쓰기'>
					<input class="button" type = "button" value = "등록하기" name='Page' onClick='Check();'>
				</TD>
			</TR>   
</TABLE>

</FORM>

</BODY>
</HTML>