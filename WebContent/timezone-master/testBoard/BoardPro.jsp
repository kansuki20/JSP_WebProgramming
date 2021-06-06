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
	BoardDTO dto = new BoardDTO(  //productId 부분 수정, || boardId, sysdate는 DAO에서 처리(여기선 아무거나 들어가도 상관없음)
			sessionId, 1, 1, "sysdate", request.getParameter("content")
			);
	
	boardDao.boardInsert(dto);
	response.sendRedirect("BoardList.jsp");
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