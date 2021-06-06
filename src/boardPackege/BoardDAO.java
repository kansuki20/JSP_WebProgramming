package boardPackege;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
//import java.util.ArrayList;
import javax.sql.DataSource;


public class BoardDAO {
	Connection con = null;
	
	public Connection getConnection() throws SQLException, NamingException {
		Context initctx = new InitialContext();
		Context ctx = (Context)initctx.lookup("java:comp/env");
		DataSource ds = (DataSource)ctx.lookup("jdbc/ditweb03");
		con = ds.getConnection();
		
		return con;
	}
	
	// 06/02 수정해야함 : productId 받아야함
	public int boardInsert(BoardDTO dto) throws SQLException, NamingException {
		con = getConnection();
		PreparedStatement pstmt = null;
		
		// 멤버id, 상품id, 게시판id, title, sysdate, content
		String sql = "insert into BOARD values(?, ?, board_seq_auto.nextval, sysdate, ?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, dto.getMemberId());
		pstmt.setInt(2, dto.getProductId());
		pstmt.setString(3, dto.getContent());
		
		return pstmt.executeUpdate();
	}
	
	//select memberId, productId, boardId, title, to_char(regtime, 'yyyy/mm/dd hh24:mi'), content from board;
	public ArrayList<BoardDTO> boardList() throws SQLException, NamingException {
		con = getConnection();
		ArrayList<BoardDTO> dtos = new ArrayList<BoardDTO>();
		
		String sql = "select memberId, productId, boardId, title, to_char(regtime, 'yyyy/mm/dd hh24:mi') regtime, content from board";
		Statement st = null;
		ResultSet rs = null;
		
		st = con.createStatement();
		rs = st.executeQuery(sql);
		
		while(rs.next()) {
			BoardDTO dto = new BoardDTO(
					rs.getString("memberId"), rs.getInt("productId")
					, rs.getInt("boardId"), rs.getString("regtime")
					, rs.getString("content"));
			dtos.add(dto);
		}
		
		rs.close();
		st.close();
		con.close();
		
		return dtos;
	}
	

}