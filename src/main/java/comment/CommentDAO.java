 package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentDAO {
	
		
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
	
	public void insertComment(CommentDTO commentDTO) {
		
		try {
			
			con=getConnection();
			String sql = "insert into comment (num, id, name, comment, date) value(?,?,?,?,now())";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, commentDTO.getNum());
			pstmt.setString(2, commentDTO.getId());
			pstmt.setString(3, commentDTO.getName());
			pstmt.setString(4, commentDTO.getComment());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	} // insertComment
}
