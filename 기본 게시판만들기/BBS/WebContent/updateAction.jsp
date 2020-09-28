<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP게시판 만들기</title>
</head>
<body>
<!--글수정 처리페이지-->
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){			//"userID"가 null이 아니라는것 == 로그인 되어있다는것(로그인시,회원가입시 부여받음) 
			userID = (String)session.getAttribute("userID"); //"userID"가 자신에게 할당된 세션을 userID에 담을 수 있도록한다.
			System.out.println(userID);
		}  
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		//bbsID값이 잘 넘어왔을때 
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
			
		}
		
		//bbsID가 잘 넘어오지 않았을때
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
			System.out.println(bbsID);
		}
		
		//현재 수정하려는글이 본인의 글인지 확인 (세션있는 값과 글 작성ID값이 같은지 비교)
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정할 수 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}else {
		if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null//자바빈즈를 사용하지 않기때문에 update.jsp에서 넘어온 내용을 받아 확인
			|| request.getParameter("bbsTitle").equals("") ||request.getParameter("bbsContent").equals("") ){
		System.out.println();
		PrintWriter script = response.getWriter();														
		script.println("<script>");
		script.println("alert('입력 안된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		} else {
		//본인확인과 bbsID가 잘 넘어왔다면
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.update(request.getParameter("getBbsTitle"),request.getParameter("bbsContent"), bbsID); //사용자가 입력한 값을 get하여 매게변수로
		if(result >= 0){
			//session.setAttribute("userID", bbs.getUserID()); 글쓰기시 세션필요없음 이미 부여됨
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		} else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert(글수정에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		}
		}
	%>
</body>
</html>