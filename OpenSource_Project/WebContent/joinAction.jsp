<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%> 
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />   
<jsp:setProperty name="user" property="userName" /> 
<jsp:setProperty name="user" property="userGender" /> 
<jsp:setProperty name="user" property="userEmail" /> 
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%	
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	
	
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
			|| user.getUserGender() == null || user.getUserEmail() ==null){ // 회원가입 정보에 null 값이 들어갈 경우 처리
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
		
			if(result == -1){ // db에 userID를 primary key 값을 줘서 이미 존재하면 해당 조건 발생
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			
			else{ // 나머지 다 입력이 재대로 완성될경우 
				session.setAttribute("userID" , user.getUserID()); // 웹서버에 로그인한 유저들에게 각각 session값을 줘야함
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href= 'main.jsp'");
				script.println("</script>");
			}
			
		}
	%>

</body>
</html>