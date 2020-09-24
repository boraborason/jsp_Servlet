<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty property="userID" name="user"/>
<jsp:setProperty property="userPassword" name="user"/>   
<jsp:setProperty property="userName" name="user"/>   
<jsp:setProperty property="userGender" name="user"/>   
<jsp:setProperty property="userEmail" name="user"/>   
<!--join페이지에서 넘어온 아이디,비번,이름,성별,이메일이 담김(이 페이지에서 사용가능)-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP게시판 만들기</title>
</head>
<body>
<!--회원가입 처리작업 페이지-->
	<%
		if(user.getUserID()==null || user.getUserPassword()==null || user.getUserName()==null || user.getUserGender()==null || user.getUserEmail()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user); //사용자로 부터 입력을 받는거기떄문에 (dbX) user로 한번에 
			if(result >= 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			} else if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('중복된 아이디 입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
	%>
</body>
</html>