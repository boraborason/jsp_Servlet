<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty property="userID" name="user"/>
<jsp:setProperty property="userPassword" name="user"/>   
<!--login페이지에서 넘어온 아이디,비번이 담김(이 페이지에서 사용가능)-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP게시판 만들기</title>
</head>
<body>
<!--로그인 처리작업 페이지-->
	<%
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); //db에 있는 아이디,비번을 넣어야 하기 때문에 get한다
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호 오류입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 존재하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('db오류')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>