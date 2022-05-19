 package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardDAO;
import board.BoardDTO;
import member.MemberDAO;

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
			BoardDAO boardDAO = new BoardDAO();
			BoardDTO boardDTO = boardDAO.getBoard(commentDTO.getNum());
			System.out.println(boardDTO.getNum());
			System.out.println(commentDTO.getNum());
			
			
				try {
			
			con=getConnection();
			int num=0;
			String sql="select max(comment_num) from comment";
			
			pstmt=con.prepareStatement(sql);
			// 4단계 실행 => 실행결과 저장
			
			rs=pstmt.executeQuery();
			// 5단계 결과 행접근 
			if(rs.next()){
				// 가장 큰번호 +1
				num=rs.getInt("max(comment_num)")+1;
			}
			sql="insert into comment(num, id, name, comment_cot, comment_num, date) values(?,?,?,?,?,now())";
			
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, boardDTO.getNum());
			pstmt.setString(2, commentDTO.getId());
			pstmt.setString(3, commentDTO.getName());
			pstmt.setString(4, commentDTO.getComment());
			
			pstmt.setInt(5, num);
			
			

			
			pstmt.executeUpdate();
			
			MemberDAO memberDAO = new MemberDAO();
			memberDAO.commentPoint(commentDTO);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
		}//insertComment
		
		public List<CommentDTO> getCommentList(BoardDTO boardDTO, int startRow, int pageSize) {
			// List 객체 생성
			// 처음에는 10개 기억장소 할당 => 11개 부터 또 다른 10개 기억장소 할당 
			// List 배열내장객체 값을 저장 .add(DTO) 주소값 순서대로 한칸씩 저장
			// 값을 가져올때 .get(순서) 배열 한칸 값을 가져오기
			// 배열 크기 .size()
			List<CommentDTO> commentList = new ArrayList<CommentDTO>();
				System.out.println(boardDTO);
			try {
				// 1, 2 디비연결 메서드 호출
				con=getConnection();
				// 3 sql select 게시판 전체 글 가져오기
				String sql="select * from comment where num=? order by comment_num limit ?,? ";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, boardDTO.getNum());
				pstmt.setInt(2, startRow-1);
				pstmt.setInt(3, pageSize);
				// 4 실행 => 결과 저장
				rs=pstmt.executeQuery();
				// 5 결과 => 다음행 => 데이터 있으면 열접근 => 
				//			BoardDTO 객체생성 set메서드호출 열데이터 저장
				//			배열 한칸에 게시판글 BoardDTO주소값을 저장 .add(DTO주소값)
				while(rs.next()) {
					CommentDTO commentDTO = new CommentDTO();
					
					commentDTO.setNum(rs.getInt("num"));
					commentDTO.setId(rs.getString("id"));
					commentDTO.setName(rs.getString("name"));										
					commentDTO.setComment(rs.getString("comment_cot"));
					commentDTO.setDate(rs.getTimestamp("date"));
					commentDTO.setComment_num(rs.getInt("comment_num"));
					
					
					System.out.println(commentDTO);
					
					
					
					
					
					commentList.add(commentDTO);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			// List 배열 내장객체 주소값 리턴
			return commentList;
		}//getBoardList
		
		public void deleteComment(int comment_num) {
			
			try {
				con=getConnection();
				
				String sql = "delete from comment where comment_num=? ";
				pstmt=con.prepareStatement(sql);
				
				
				pstmt.setInt(1, comment_num);
				
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
		}// deleteComment
		
		public CommentDTO getComment(int comment_num) {
			CommentDTO commentDTO = null;
			try {
				
				con=getConnection();
				String sql="select * from comment where comment_num=?";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setInt(1, comment_num);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					commentDTO = new CommentDTO();
					commentDTO.setComment(rs.getString("comment_cot"));
					commentDTO.setComment_num(rs.getInt("comment_num"));
					commentDTO.setId(rs.getString("id"));
					commentDTO.setName(rs.getString("name"));
					commentDTO.setNum(rs.getInt("num"));
					commentDTO.setDate(rs.getTimestamp("date"));
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
			return commentDTO;
		}//getComment
		
		public void updateComment(CommentDTO commentDTO) {
			try {
				con=getConnection();
				String sql = "update comment set comment_cot=? where comment_num = ?;";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, commentDTO.getComment());
				pstmt.setInt(2, commentDTO.getComment_num());
				
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
		}// updateComment
		
		public int getCommentCount(int num) {
			int countComment = 0;
			
			try {
				con=getConnection();
				String sql = "select count(*) from comment where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs=pstmt.executeQuery();
				
				
				if(rs.next()) {
				
					countComment=rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
			return countComment;
		}
		
			
			
			
	
}//comment class
