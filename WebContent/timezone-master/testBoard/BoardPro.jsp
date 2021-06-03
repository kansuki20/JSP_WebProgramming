<%@page import="memberPackege.MemberDAO"%>
<%@page import="boardPackege.BoardDAO"%>
<%@page import="memberPackege.MemberDTO"%>
<%@page import="boardPackege.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%	
	MemberDAO memberDao = new MemberDAO();
	BoardDAO boardDao = new BoardDAO();
	int check;
	//Login할 때 저장되있는 session값 불러옴
	String sessionId = (String)session.getAttribute("sessionId");

	request.setCharacterEncoding("utf-8");
	//memberId, productId, boardId, title, sysdate, content
	BoardDTO dto = new BoardDTO(  //productId 부분 수정, boardId 부분 수정
			sessionId, 1, 1, request.getParameter("title"),  "sysdate", request.getParameter("content")
			);
	
	//세션값 판별해서 
	if (memberDao.SessionCheck(sessionId)) {
		if(check == 0) { //
			
		}
		boardDao.boardInsert(dto);
		response.sendRedirect("BoardList.jsp"); //게시판 리스트로 이동
	} else {
		response.sendRedirect("BoardForm.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

</body>
</html>