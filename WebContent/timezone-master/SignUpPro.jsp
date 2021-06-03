<%@page import="memberPackege.MemberDAO"%>
<%@page import="memberPackege.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	// 
	request.setCharacterEncoding("utf-8");
	
	MemberDTO dto = new MemberDTO(
			request.getParameter("singup_id"), request.getParameter("singup_pwd")
			, request.getParameter("singup_name"), request.getParameter("singup_email")
			, request.getParameter("singup_address")
			);

	MemberDAO dao = new MemberDAO();
	//아이디가 중복이면
 	if(dao.SignUpCheck(dto.getId()) != 1)
		out.println("중복");
	else {//중복이 아니면 가입
		dao.SignUp(dto);
		response.sendRedirect("login.jsp");
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