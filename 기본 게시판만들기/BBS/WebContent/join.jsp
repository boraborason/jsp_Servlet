<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<title>JSP게시판 만들기</title>
</head>
<body>
	<nav class="nav navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapsed" data-target="#bs-example-navar-collapsed-1"
				area-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>	
			<a class="navbar-brand" href="main.jsp">JSP 게시판웹사이트</a>	
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navar-collapsed-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li class="active"><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>  <!--네브바 고정-->
 	<div class="container">
 		<div class="col-lg-4"></div>
 		<div class="col-lg-4">
 			<div class="jumbotron" style="padding-top:20px;">
 				<form action="joinAction.jsp" method="post">
 					<h3 style="text-align: center;">회원가입화면</h3>
 					<div class="form-group">
 						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
 					</div>
 					<div class="form-group">
 						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
 					</div>
 					<div class="form-group">
 						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
 					</div>
 					<div class="form-group" style="text-align:center;">
 						<div class="btn-group" data-toggle="buttons">
 							<label class="btn btn-primary active">
 								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
 							</label>
 							<label class="btn btn-primary">
 								<input type="radio" name="userGender" autocomplete="off" value="여자">여자
 							</label>
 						</div>
 					</div>
 					<div class="form-group">
 						<input type="email" class="form-control" placeholder="email" name="userEmail" maxlength="20">
 					</div>
 					<input type="submit" class="btn btn-primary form-control" value="회원가입하기">
 				</form>
 			
 			</div>
 		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>