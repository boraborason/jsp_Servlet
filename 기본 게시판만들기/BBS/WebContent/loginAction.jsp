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
		//세션이 있으면(로그인이 되어있으면) 회원가입 페이지가 보이지 않도록 한다.
		String userID = null;
		if(session.getAttribute("userID") != null){			//"userID"가 null이 아니라는것 == 로그인 되어있다는것(로그인시,회원가입시 부여받음) 
			userID = (String)session.getAttribute("userID"); //"userID"가 자신에게 할당된 세션을 userID에 담을 수 있도록한다.
		}  
		if(user != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("이미 로그인 되어 있습니다.");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); //사용자가 입력한 값을 get하여 매게변수로
		if(user.getUserID()==null || user.getUserPassword()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == 1){
			//현재 접속한 회원의 고유아이디(세션)
			//로그인성공시 세션부여해 관리시작
			//userID값을 세션값으로 "userID"에 부여한다.
			//세션으로 로그인 여부를 확인할 수 있다.
			//로그아웃 페이지에서 세션해제
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}else if(result == 0){
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