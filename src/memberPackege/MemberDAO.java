package memberPackege;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDAO {
	Connection con = null;
	
	//dbcp 커넥션
	public Connection getConnection() throws SQLException, NamingException {
		
		Context initctx = new InitialContext();
		Context ctx = (Context)initctx.lookup("java:comp/env");
		DataSource ds = (DataSource)ctx.lookup("jdbc/ditweb03");
		con = ds.getConnection();

		return con;
	}
	
	public boolean SessionCheck(String sessionId) {
		if(sessionId != null)
			return true;	// 로그인 중 (세션있음)
		else
			return false;	// 세션없음
	}
	
	public int SignUpCheck(String id) throws SQLException, NamingException {
		con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from MEMBER where id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
				return 0;	// 이미 존재하는 회원
			else
				return 1;	// 가입 가능한 회원
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return -1;	// 오류
	}
	
	public int SignUp(MemberDTO dto) throws SQLException, NamingException {
		con = getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "insert into MEMBER values(?, ?, ?, ?, ?, ?)";
									//id, pwd, name, email, address, 관리자판별
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getAddress());
			pstmt.setInt(6, 0);	// 수정 - 관리자는 1 관리자 아니면 0
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return -1;	// 오류
	}
	
	public int Login(String id, String pwd) throws SQLException, NamingException {
		String checkPwd;
		
		con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select pwd from MEMBER where id=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				checkPwd = rs.getString("pwd");
				if(checkPwd.equals(pwd))
					return 1;	// 다 맞으면
				else
					return 0;	// 비밀번호 틀리면
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
				try {
					if(rs != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(con != null) con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return -1;	// DB 오류
	}
	
	public MemberDTO SetEditProfile(String id) throws SQLException, NamingException {	// EditProfile에 세팅
		con = getConnection();
		Statement st = null;
		ResultSet rs = null;
		
		MemberDTO dto = new MemberDTO();
		String sql = "select * from MEMBER where id="+"'"+id+"'";
		
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			
			while(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPwd(rs.getString("pwd"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setAddress(rs.getString("address"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(st != null) st.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	
	public int EditProfile(MemberDTO dto) throws SQLException, NamingException {	// EditProfile을 토대로 개인정보 수정
		con = getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "update MEMBER set pwd=?, name=?, email=?, address=? "
				+ "where id=?";	// pwd, name, email, address, id 
		
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getPwd());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getAddress());
			pstmt.setString(5, dto.getId());
			
			return pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return -1;	// 오류
	}
	
	public int DeleteAccount(String id) throws SQLException, NamingException {
		con = getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "delete from MEMBER where id=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			return pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return -1;	// 오류
	}
}
