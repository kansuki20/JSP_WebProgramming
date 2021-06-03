<%@page import="memberPackege.MemberDTO"%>
<%@page import="memberPackege.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	MemberDTO dto = new MemberDTO(request.getParameter("edit_id"), request.getParameter("edit_pwd")
			, request.getParameter("edit_name"), request.getParameter("edit_email")
			, request.getParameter("edit_address")
			);
	MemberDAO dao = new MemberDAO();
	
	// null값이 넘어오면 -1이 뜸
	int check = dao.EditProfile(dto);
	
	if(check != -1) { %>
		<script type="text/javascript">
			alert("수정되었습니다");
			location.href = "index.jsp";
		</script>
<%	} else { %>
		<script type="text/javascript">
			alert("빈 칸을 확인해주세요");
			location.href = "editprofile.jsp";
		</script>
<%	}%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

</body>
</html>