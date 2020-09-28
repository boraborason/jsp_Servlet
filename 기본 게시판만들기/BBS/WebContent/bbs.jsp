<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="bbs.BbsDAO" %>
<%@page import="bbs.Bbs" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<title>JSP게시판 만들기</title>
<style type="text/css">
	a, a:hover {color: black; text-decoration: none;}
</style>
</head>
<body>
	<%	//로그인후 main페이지와 왔을 경우
		String userID = null;
		if(session.getAttribute("userID") != null){			//"userID"가 null이 아니라는것 == 로그인 되어있다는것(로그인시,회원가입시 부여받음) 
			userID = (String)session.getAttribute("userID"); //"userID"가 자신에게 할당된 세션을 userID에 담을 수 있도록한다.
		} 
		int pageNumber = 1;  //기본페이지
		if(request.getParameter("pageNumber") != null){//url로 파라미터 페이지번호가 넘어왔다면 
			pageNumber = Integer.parseInt(request.getParameter("pageNumber")); //int형으로 변환해 넣어준다.
		} 		
	%>
	<nav class="nav navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navar-collapse-1"
				area-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>	
			<a class="navbar-brand" href="main.jsp">JSP 게시판웹사이트</a>	
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			
		<%
		//userID에 세션값이 없을경우
		if(userID == null) {
		%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		<%
		}else {
		%>	
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logout.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		<%
		}
		%>	
		</div>
	</nav>
	<!-- 게시판 폼 만들기 -->
	<div class="container">
		<div class="row" style="margin-top:20px;">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<td style="background-color: #eeeeee; text-align: center;">번호</td>
						<td style="background-color: #eeeeee; text-align: center;">제목</td>
						<td style="background-color: #eeeeee; text-align: center;">작성자</td>
						<td style="background-color: #eeeeee; text-align: center;">작성일</td>
					</tr>
				</thead>
				<tbody><!-- 게시글 출력부분 -->
				<%
					BbsDAO bbsDAO = new BbsDAO();  //객체를 생성하고 메서드를 이용해 for문으로 값을 모두출력
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for(int i = 0; i < list.size(); i++){
				%>		
				<tr>
					<td><%= list.get(i).getBbsID() %></td>
					<td><a href = "view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle()%></a></td>
					<td><%= list.get(i).getUserID() %></td>
					<td><%= list.get(i).getBbsData().substring(0, 11) + list.get(i).getBbsData().substring(11, 13) +"시"+ list.get(i).getBbsData().substring(14, 16) +"분" %></td>
				</tr>
				<%		
					}
				%>
				</tbody>
			</table>
			<% 
				if(pageNumber != 1 ){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if(bbsDAO.nextPage(pageNumber + 1)){  //다음페이지가 존재하는지 물어봄
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
			<a href = "write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>