package board;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;





public class BoardDAO {
	
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	
	public Connection getConnection() throws Exception{
		
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	public void closeDB() {
		if(rs!=null) try { rs.close(); } catch (Exception e2) {	}
		if(pstmt!=null) try { pstmt.close(); } catch (Exception e2) {	}
		if(con!=null) try { con.close(); } catch (Exception e2) {	}	
	}
	
	public void insertBoard(BoardDTO boardDTO) {
		
		
		try {
		
		con=getConnection();
		int num=0;
		String sql="select max(num) from board";
		
		pstmt=con.prepareStatement(sql);
		// 4단계 실행 => 실행결과 저장
		rs=pstmt.executeQuery();
		// 5단계 결과 행접근 
		if(rs.next()){
			// 가장 큰번호 +1
			num=rs.getInt("max(num)")+1;
		}
		sql="insert into board(num,name,pass,subject,content,readcount,date) values(?,?,?,?,?,?,now())";
		
		
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.setString(2, boardDTO.getName());
		pstmt.setString(3, boardDTO.getPass());
		pstmt.setString(4, boardDTO.getSubject());
		pstmt.setString(5, boardDTO.getContent());
		pstmt.setInt(6, boardDTO.getReadcount());
		

		
		pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		}//insertBoard
	
}// class
