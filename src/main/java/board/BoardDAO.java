package board;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import member.MemberDAO;
import member.MemberDTO;





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
		sql="insert into board(num,name,pass,subject,content,readcount,file,recommend,date) values(?,?,?,?,?,?,?,?,now())";
		
		
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.setString(2, boardDTO.getName());
		pstmt.setString(3, boardDTO.getPass());
		pstmt.setString(4, boardDTO.getSubject());
		pstmt.setString(5, boardDTO.getContent());
		pstmt.setInt(6, boardDTO.getReadcount());
		
		//파일
		pstmt.setString(7, boardDTO.getFile());
		pstmt.setInt(8, 0);
		
		
		pstmt.executeUpdate();
		pstmt.close();
		MemberDAO memberDAO = new MemberDAO();
		memberDAO.writePoint(boardDTO);
		
		
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		}//insertBoard
	
	// BoardDTO 여러개를 담을수 있는 자바 배열형태의 내장객체 List 리턴값있음
	public List<BoardDTO> getBoardList(int startRow, int pageSize) {
		// List 객체 생성
		// 처음에는 10개 기억장소 할당 => 11개 부터 또 다른 10개 기억장소 할당 
		// List 배열내장객체 값을 저장 .add(DTO) 주소값 순서대로 한칸씩 저장
		// 값을 가져올때 .get(순서) 배열 한칸 값을 가져오기
		// 배열 크기 .size()
		List<BoardDTO> boardList = new ArrayList<BoardDTO>();
		try {
			// 1, 2 디비연결 메서드 호출
			con=getConnection();
			// 3 sql select 게시판 전체 글 가져오기
			String sql="select * from board order by num desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			// 4 실행 => 결과 저장
			rs=pstmt.executeQuery();
			// 5 결과 => 다음행 => 데이터 있으면 열접근 => 
			//			BoardDTO 객체생성 set메서드호출 열데이터 저장
			//			배열 한칸에 게시판글 BoardDTO주소값을 저장 .add(DTO주소값)
			while(rs.next()) {
				BoardDTO boardDTO = new BoardDTO();
				
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				boardDTO.setFile(rs.getString("file"));
				boardDTO.setRecommend(rs.getInt("recommend"));
				boardList.add(boardDTO);
				System.out.println(boardDTO);
				
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		// List 배열 내장객체 주소값 리턴
		return boardList;
	}//getBoardList
	
	public List<BoardDTO> getBestBoardList() {
			List<BoardDTO> bestBoardList = new ArrayList<BoardDTO>();
		try {
			
			
			con=getConnection();
			// 3 sql select 게시판 전체 글 가져오기
			String sql="select * from board where recommend >= 10 order by recommend desc limit ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, 5);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO boardDTO = new BoardDTO();
				
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				boardDTO.setFile(rs.getString("file"));
				boardDTO.setRecommend(rs.getInt("recommend"));
				bestBoardList.add(boardDTO);
				System.out.println(boardDTO);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return bestBoardList;
	}//getBestBoardList
	public List<BoardDTO> getSearchList(String ns, String search, int startRow, int pageSize) {
		List<BoardDTO> searchList = new ArrayList<BoardDTO>();
	try {
		
		System.out.println(ns);
		con=getConnection();
		// 3 sql select 게시판 전체 글 가져오
		String sql="select * from board where " +ns+ " LIKE ?";
		sql+="order by date desc limit ?,?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, "%"+search+"%");
		pstmt.setInt(2, startRow - 1);
		pstmt.setInt(3, pageSize);
		rs=pstmt.executeQuery();
		while(rs.next()) {
			BoardDTO boardDTO = new BoardDTO();
			
			boardDTO.setNum(rs.getInt("num"));
			boardDTO.setPass(rs.getString("pass"));
			boardDTO.setName(rs.getString("name"));
			boardDTO.setSubject(rs.getString("subject"));
			boardDTO.setContent(rs.getString("content"));
			boardDTO.setReadcount(rs.getInt("readcount"));
			boardDTO.setDate(rs.getTimestamp("date"));
			boardDTO.setFile(rs.getString("file"));
			boardDTO.setRecommend(rs.getInt("recommend"));
			searchList.add(boardDTO);
			System.out.println(boardDTO);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		closeDB();
	}
	
	return searchList;
}//getsearchList
	public BoardDTO getBoard(int num) {
		BoardDTO boardDTO = null;
		try {
			con=getConnection();
			// 3 sql select 게시판 전체 글 가져오기
			String sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
			
			boardDTO = new BoardDTO();
			boardDTO.setNum(rs.getInt("num"));
			boardDTO.setName(rs.getString("name"));
			boardDTO.setSubject(rs.getString("subject"));
			boardDTO.setContent(rs.getString("content"));
			boardDTO.setReadcount(rs.getInt("readcount"));
			boardDTO.setDate(rs.getTimestamp("date"));
			//파일
			boardDTO.setFile(rs.getString("file"));
			boardDTO.setRecommend(rs.getInt("recommend"));
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return boardDTO;
	} // getBoard
	
	public void updateReadcount(int num) {
		try {
			con=getConnection();
			
			String sql="update board set readcount = readcount +1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}// updateReadcount
	
	
	public void updateBoard(BoardDTO boardDTO) {
		
		try {
			con=getConnection();
			
			String sql = "update board set subject=?,content=?,file=? where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, boardDTO.getSubject());
			pstmt.setString(2, boardDTO.getContent());
			pstmt.setString(3, boardDTO.getFile());
			pstmt.setInt(4, boardDTO.getNum());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			closeDB();
		}
	}//updateBOard
	
	public void deleteBoard(int num) {
		
		try {
			con=getConnection();
			
			String sql = "delete from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			closeDB();
		}
	}//updateBOard
	
	public int getboardCount() {
		int count = 0;
		try {
			con=getConnection();
			String sql = "select count(*) from board ";
			pstmt=con.prepareStatement(sql);
			
			
			rs=pstmt.executeQuery();
			
			
			if(rs.next()) {
			
				count=rs.getInt("count(*)");
			
			}
		
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		return count;
	}//getboardCount
	
	public void updateRecommend(int num) {
		try {
			con=getConnection();
			
			String sql="update board set recommend = recommend +1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}// updateRecommend
	
	public BoardDTO getRecommend(int num) {
		BoardDTO boardDTO = new BoardDTO();
		try {
			con=getConnection();
			String sql="select recommend from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				boardDTO.setRecommend(rs.getInt("recommend"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return boardDTO;
	}//getRecommend
	
}// class
