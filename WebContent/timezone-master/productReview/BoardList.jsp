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

	int numOfRecords = 10;	// 한 page의 게시글 수
	int numOfPages = 10;	// 한 화면의 페이지 수
	int p = 1;				// 첫 페이지
	
	String p_ = request.getParameter("p");
	if(p_ != null && !p_.equals("")) {
		p = Integer.parseInt(p_);
	}

	BoardDAO dao = new BoardDAO();
	MemberDAO memberDao = new MemberDAO();
	ArrayList<BoardDTO> dtos = dao.getListBoard(p, numOfRecords);
	
	int count = dao.getCount();
	
	int startNum = p - (p-1) % numOfPages;
	int lastNum = (int) Math.ceil((double) count/numOfRecords);
	
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
	<h1 class="text-center font-weight-bold">후기</h1>
	<br>
	<table class="table table-hover">
		<tr>
			<th>유저ID</th>
			<th>등록일자</th>
			<th>내용</th>
		</tr>
	<!--5. 결과집합 처리--> 
<%	for(BoardDTO dto: dtos){%>
		<tr>
			<td><%=dto.getMemberId()%></td>
			<td><%=dto.getRegtime()%></td>
			<td><%=dto.getContent()%></td>
		</tr>
<%}%>
	</table>
	</div>
<div class="d-flex just justify-content-center">
		<ul class="pagination">
		<%if(startNum <= 1) { //Previous%>
  			<li class="page-item"><a class="page-link" style="color:gray" onclick="alert('앞 페이지가 더 이상 없음')">Previous</a></li>
  		<%} else { // startNum가 6, 11...일 경우%>
  			<li class="page-item"><a class="page-link" href="?p=<%=startNum - 1%>">Previous</a></li>
  		<%}%>
  		<%for(int i=0; i<numOfPages; i++) { //숫자 링크 부분%>
  		<%if(startNum + i <= lastNum) { 
  		  	if(p == (startNum+i)) {
  		%>
  			<li class="page-item active"><a class="page-link" href="?p=<%=startNum + i%>"><%=startNum + i %></a></li>
  		<%} else { %>
  			<li class="page-item"><a class="page-link" href="?p=<%=startNum + i%>"><%=startNum + i %></a></li>
  		<%}}}%>
  		<%if(startNum+numOfPages > lastNum) { %>
  			<li class="page-item"><a class="page-link" style="color:gray" onclick="alert('앞 페이지가 더 이상 없음')" href="#">Next</a></li>
  		<%} else { %>
  			<li class="page-item"><a class="page-link" href="?p=<%=startNum + numOfPages%>">Next</a></li>
  		<%}%>
 
		</ul>
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