<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.io.PrintWriter"%> 


<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page" />
<jsp:setProperty name="board" property="boardTitle" />
<jsp:setProperty name="board" property="boardContent" />   
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
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글을 작성하실 수 없습니다. 로그인을 하세요.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else{
	
			if(board.getBoardTitle() == null || board.getBoardContent() == null){ 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
			}
			else{
					BoardDAO boardDAO = new BoardDAO();
					int result = boardDAO.write(board.getBoardTitle(),userID,board.getBoardContent());
					if(result == -1){ 
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기 오류입니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					
					else{ 
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href= 'board.jsp'");
						script.println("</script>");
					}
					
				}
		
		}

	
	%>

</body>
</html>