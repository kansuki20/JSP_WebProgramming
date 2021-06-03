<%@page import="memberPackege.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	// 비밀번호 확인 추가 alert
	String sessionId = (String)session.getAttribute("sessionId");

	MemberDAO dao = new MemberDAO();
	dao.DeleteAccount(sessionId);
	
	session.removeAttribute("sessionId");	//탈퇴한 회원 세션값 삭제	
	response.sendRedirect("LoginForm.jsp");
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