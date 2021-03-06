<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
 <%@ page import="java.io.PrintWriter" %>  
 <%@ page import = "file.FileDAO" %>
<%@ page import = "java.io.File" %>
<%@ page import= "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
 
   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name = "viewport" content="width=device-width", initial-scale="1">
<link rel = "stylesheet" href="css/bootstrap.css">
<link rel = "stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	
	%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">게시판 웹 사이트</a>
		</div>
		
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li ><a href="main.jsp">메인</a></li>
				<li><a href="board.jsp">게시판</a></li>
				<li class="active"><a href="file.jsp">자료공유</a></li>
			</ul>
			
			<%
				if(userID == null){
			%>
			
			<ul class="nav narbar-nav narbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expaned="false">접속하기 <span class="caret"></span></a>
						
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
						
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav narbar-nav narbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expaned="false">회원관리 <span class="caret"></span></a>
						
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
						
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	<%
		String directory = application.getRealPath("/upload/");
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, encoding, 
				new DefaultFileRenamePolicy());
		
		String fileName = multipartRequest.getOriginalFileName("file");
		String fileRealName = multipartRequest.getFilesystemName("file");
		
		new FileDAO(). upload(fileName, fileRealName);
		out.write("파일명: " + fileName + "<br>");
		out.write("실제 파일명: " + fileRealName + "<br>");
		
		
	%>
 	<br><br><br><br>
 	<h3> 파일이 업로드 되었습니다!</h3>
	<a href="file.jsp" class="btn btn-primary">뒤로</a>
</body>
	
</body>
</html>