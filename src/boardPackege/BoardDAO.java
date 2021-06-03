package boardPackege;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
//import java.util.ArrayList;
import javax.sql.DataSource;


public class BoardDAO {
	Connection con = null;
	
	ResultSet rs = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	
	public Connection getConnection() throws SQLException, NamingException {
		Context initctx = new InitialContext();
		Context ctx = (Context)initctx.lookup("java:comp/env");
		DataSource ds = (DataSource)ctx.lookup("jdbc/ditweb03");
		con = ds.getConnection();
		
		return con;
	}
	
	// 06/02 수정해야함 : memberId 다음에 productId 받아야함
	public int boardInsert(BoardDTO dto) throws SQLException, NamingException {
		con = getConnection();
		PreparedStatement pstmt = null;
		
		// 멤버id, 상품id, 게시판id, title, sysdate, content
		String sql = "insert into BOARD values(?, ?, board_seq_auto.nextval, ?, sysdate, ?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, dto.getMemberId());
		pstmt.setInt(2, dto.getProductId());
		pstmt.setString(3, dto.getTitle());
		pstmt.setString(4, dto.getContent());
		
		return pstmt.executeUpdate();
	}
	
	public void close() throws SQLException{
		if(rs!=null)rs.close();
		if(stmt!=null)rs.close();
		if(pstmt!=null)rs.close();
		if(con!=null)rs.close();
	}
	
	
	//새글 작성
	public int insert(BoardDTO dto) throws SQLException{
		String writer=dto.getMemberId();
		String title=dto.getTitle();
		String content=dto.getContent();
		
		return this.insert(writer, title, content);
	}

	
	public int insert(String writer, String title, String content) throws SQLException{
		int cnt=0;
		try {
			pstmt=con.prepareStatement("INSERT INTO BOARD"+ "(memberId, title, content) "+ "VALUES"+ "(?, ?, ?)");
			pstmt.setString(1, writer);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
		}finally {
			close();
		}
		
		return cnt;
	}
	
	//  ResultSet --> DTO 배열로 변환 리턴
	/*public BoardDTO[] createArray(ResultSet rs) throws SQLException{
		ArrayList<BoardDTO> list=new ArrayList<BoardDTO>();
		
		while (rs.next()) {
			int 
		}
		int size=list.size();
		BoardDTO[] arr=new BoardDTO[size];
		list.toArray(arr);
		return arr;
	}*/
	
	//글 목록 읽어오기
	
	//글 수정하기
	
	//글 삭제하기
}