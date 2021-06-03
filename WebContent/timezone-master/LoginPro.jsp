<%@page import="memberPackege.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	// 수정 alert 비밀번호, 아이디 틀린거
	int checkMember;	// 로그인 id,pwd 체크
	boolean checkSession;	// 세션값 체크

	MemberDAO dao = new MemberDAO();

	String id = request.getParameter("login_id");
	String pwd = request.getParameter("login_pwd");
	
	String sessionId = (String)session.getAttribute("sessionId");
	checkSession = dao.SessionCheck(sessionId); // true면 세션있음(로그인되있음)
	if(checkSession) {
		response.sendRedirect("index.jsp");
	} else {
		checkMember = dao.Login(id, pwd);
		
		if(checkMember == 1) {	// 로그인 성공
			// 세션에 id 저장
			session.setAttribute("sessionId", id);
			response.sendRedirect("index.jsp");
		} else if(checkMember == 0) { // 비밀번호 틀림 %>
			<script type="text/javascript">
				alert("비밀번호를 확인해주세요");
				location.href = "login.jsp";
			</script>
<%		} else { //아이디도 맞지않을 때 %>
			<script type="text/javascript">
				alert("아이디를 확인해주세요");
				location.href = "login.jsp";
			</script>
<%		}
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