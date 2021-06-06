<%@page import="memberPackege.MemberDAO"%>
<%@page import="boardPackege.BoardDAO"%>
<%@page import="boardPackege.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sessionId = (String)session.getAttribute("sessionId");
	
	BoardDAO dao = new BoardDAO();
	MemberDAO memberDao = new MemberDAO();

	ArrayList<BoardDTO> dtos = new ArrayList<>();
	
	dtos = dao.boardList();
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
	<br>
	<h1 class="text-center font-weight-bold">로그인 정보</h1>
	<br>
	<table class="table table-hover">
		<tr>
			<th>유저ID</th>
			<th>상품ID</th>
			<th>게시판ID</th>
			<th>등록일자</th>
			<th>내용</th>
		</tr>

	<!--5. 결과집합 처리--> 
<%	for(BoardDTO dto: dtos){%>
		<tr>
			<td><%=dto.getMemberId()%></td>
			<td><%=dto.getProductId()%></td>
			<td><%=dto.getBoardID()%></td>
			<td><%=dto.getRegtime()%></td>
			<td><%=dto.getContent()%></td>
		</tr>
<%}%>
	</table>
	</div>
	<button id="btnBoardInsert" onclick="location='BoardForm.jsp'">게시글 등록하기</button>
<%	if (memberDao.SessionCheck(sessionId)) { %>
		<script type="text/javascript">
			document.getElementById("btnBoardInsert").setAttribute("onClick", "pageMove()");
			function pageMove() { location.href="BoardForm.jsp"; }
		</script>
<%	} else { %>
		<script type="text/javascript">
		document.getElementById("btnBoardInsert").setAttribute("onClick", "alertLogin()");
		function alertLogin() { alert("로그인을 해주세요");	}
		</script>
<%}%>
		
</body>
</html>