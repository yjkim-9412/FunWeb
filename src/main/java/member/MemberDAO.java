package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardDTO;
import comment.CommentDTO;

public class MemberDAO {
	// 데이터베이스 작업 객체,주제
	// 특징(속성) 저장하는 변수 => 멤버변수
	// 기능을 정의한 함수 => 멤버함수 => 메서드
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	//디비연결 메서드 정의
	public Connection getConnection() throws Exception{
		// throws Exception : 예외처리는 함수호출하는 곳에서 하겠다
		
//		// //1단계  JDBC 프로그램 드라이버 로더 
//		Class.forName("com.mysql.cj.jdbc.Driver");
//
//		// //2단계  디비연결  DriverManager 디비주소, 디비접속아이디, 디비접속비밀번호 
//		// //      연결정보 저장 => Connection
//		String dbUrl="jdbc:mysql://localhost:3306/jspdb7?serverTimezone=Asia/Seoul";
//		String dbUser="root";
//		String dbPass="1234";
//		Connection con =DriverManager.getConnection(dbUrl, dbUser, dbPass);
//		return con;
		
		// Connection Pool : 미리 디비연결을 서버에서 하고 디비연결 자원을 불러다가 사용
		//                 : 서버에서 하나만 정의하고 자원의 이름을 불러다가 사용, 수정 최소화
		
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
	// 회원가입하는 기능 => 함수정의
	// 리턴할 형 없음
	// 전달받은 값을 저장하는 변수=>매개변수
//	public void insertMember(String id,String pass,String name) {
	// MemberDTO 주소를 저장하는 변수
	public void insertMember(MemberDTO memberDTO) {
		System.out.println("MemberDAO클래스 파일 insertMember()메서드");
		
		System.out.println("폼에서 전달해온 아이디 : "+memberDTO.getId());
		System.out.println("폼에서 전달해온 비밀번호 : "+memberDTO.getPass());
		System.out.println("폼에서 전달해온 이름 : "+memberDTO.getName());
		System.out.println("폼에서 전달해온 이메일 : "+memberDTO.getEmail());
		System.out.println("폼에서 전달해온 주소 : "+memberDTO.getAddress());
		System.out.println("폼에서 전달해온 집전화 : "+memberDTO.getPhone());
		System.out.println("폼에서 전달해온 개인번호 : "+memberDTO.getMobile());
		
		System.out.println("메서드 시작");
	
		try {
			// 에러 발생 가능성이 높은 명령
//			System.out.println("나누기 : "+ a/b);
//			1, 2, 3, 4 단계
			//1, 2단계 디비연결 메서드 호출
			con =getConnection();
	
			// //3단계  연결정보를 이용해서 sql구문 만들기 =>  PreparedStatement
			// // String sql="insert into 테이블이름(열이름,열이름) values(값,'값')";
			// // String sql="insert into member(id,pass,name,date) values(?,?,?,?)";
			String sql = "insert into member(id,pass,name,email,address,phone,mobile,rating,date,date_cur) values(?,?,?,?,?,?,?,?,now(),now())";
			pstmt=con.prepareStatement(sql);
			// // 객체생성 후 첫번째 ? 정수형 num 값 넣기, 두번째 ? 문자열 name 값 넣기
			pstmt.setString(1, memberDTO.getId());
			pstmt.setString(2, memberDTO.getPass());
			pstmt.setString(3, memberDTO.getName());
			pstmt.setString(4, memberDTO.getEmail());
			pstmt.setString(5, memberDTO.getAddress());
			pstmt.setString(6, memberDTO.getPhone());
			pstmt.setString(7, memberDTO.getMobile());
			pstmt.setInt(8, 6);
			
			
	
			// //4단계   PrepardStatement sql구문 실행 (insert,update,delete)=>executeUpdate()
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			// 에러 발생시 메시지 출력
//			System.out.println("0으로 나눔 에러 발생");
			e.printStackTrace();
		}finally {
			// 에러 발생 여부 상관없이 마무리작업=> 내장객체 기억장소 해제
			System.out.println("마무리작업");
			closeDB();	
		}
		
		System.out.println("메서드 종료");
		return;
	}// 회원가입메서드

	// 리턴할형 MemberDTO   getMember(String id) 메서드 정의
	public MemberDTO getMember(String id) {
		MemberDTO memberDTO=null;
		
		try {
			//1, 2단계 디비연결 메서드 호출
			con =getConnection();
			
			//3단계  연결정보를 이용해서 sql구문 만들기 =>  PreparedStatement
			// 문자열 => sql구문 변경, 실행할수 있는 내장객체 => PreparedStatement
			String sql="select member.*, rate.rating_name from member join rate ON member.rating = rate.rating where id=?";
//			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계   PreparedStatement sql구문 실행 (insert,update,delete) ,
//			        select 결과 저장 => ResultSet
			rs=pstmt.executeQuery();
			// 5단계  ResultSet 저장된 내용을 출력, 저장
			// 결과값 행접근 다음행 next() 다음행 => 데이터 있으면 true / 데이터 없으면 false
			// 열접근 => 출력
			if(rs.next()){
				// 다음행 첫번째 행 데이터 있으면 true => 열접근
				// memberDTO 객체생성 => 기억장소 할당
				memberDTO = new MemberDTO();
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPass(rs.getString("pass"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setDate(rs.getTimestamp("date"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setMobile(rs.getString("mobile"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setDate_cur(rs.getTimestamp("date_cur"));
				memberDTO.setPoint_cur(rs.getInt("point_cur"));
				memberDTO.setPoint_max(rs.getInt("point_max"));
				memberDTO.setRating(rs.getInt("rating"));
				memberDTO.setRating_name(rs.getString("rate.rating_name"));
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return memberDTO;
	}//getMember()
	
	// 리턴할형 MemberDTO   userCheck(String id, String pass) 메서드 정의
	public MemberDTO userCheck(String id) {
		MemberDTO memberDTO=null;
		
		try {
			//1, 2단계 디비연결 메서드 호출
			con =getConnection();

			//3단계  연결정보를 이용해서 sql구문 만들기 =>  PreparedStatement
			// sql 폼에서 입력한 아이디 디비에 아이디 일치하고 ,
//			     폼에서 입력한 비밀번호 디비에  비밀번호 일치
			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			

			// 4단계   PreparedStatement sql구문 실행, select 결과 저장 => ResultSet
			rs=pstmt.executeQuery();

			// 5단계  ResultSet 저장된 내용을 출력, 저장
			// 결과값 행접근 다음행 next() 다음행 => 데이터 있으면 true / 데이터 없으면 false
			// 데이터 있으면 true 아이디 비밀번호 일치 => 세션값 생성 => main.jsp 이동
			// 데이터 없으면 false 아이디 비밀번호 틀림 => 아이디 비밀번호 틀림 메시지 출력 , 뒤로이동
			if(rs.next()) {
				// 다음행 첫번째 행 데이터 있으면 true => 열접근
				// memberDTO 객체생성 => 기억장소 할당
				memberDTO=new MemberDTO();
				// set메서드 호출 열접근을 데이터 저장
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPass(rs.getString("pass"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setDate(rs.getTimestamp("date"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setMobile(rs.getString("mobile"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setPoint_cur(rs.getInt("point_cur"));
				memberDTO.setPoint_max(rs.getInt("point_max"));
				memberDTO.setDate_cur(rs.getTimestamp("date_cur"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();	
		}
		return memberDTO;
	}
	
	// 리턴할형 없음  updateMember(MemberDTO updateDTO) 수정작업 메서드 정의
	public void updateMember(MemberDTO updateDTO,String id) {
			System.out.println(id);
		try {
			//1, 2단계 디비연결 메서드 호출
			con =getConnection();
			
			//3단계  연결정보를 이용해서 sql구문 만들기 =>  PreparedStatement
			// 문자열 => sql구문 변경, 실행할수 있는 내장객체 => PreparedStatement
			// update 테이블이름 set 수정열=값 where 조건열=값;
			String sql="update member set id=?, name=?, email=?, address=?, phone=?, mobile=?, pass=? where id=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, updateDTO.getId());
			pstmt.setString(2, updateDTO.getName());
			pstmt.setString(3, updateDTO.getEmail());
			pstmt.setString(4, updateDTO.getAddress());
			pstmt.setString(5, updateDTO.getPhone());
			pstmt.setString(6, updateDTO.getMobile());
			pstmt.setString(7, updateDTO.getPass());
			pstmt.setString(8, id);
			//4단계   PrepardStatement sql구문 실행 (insert,update,delete)		
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();	
		}
	}//
	
	// 리턴할형 없음  deleteMember(String id) 수정작업 메서드 정의
	public void deleteMember(String id) {
			
		try {
			//1, 2단계 디비연결 메서드 호출
			con =getConnection();
			
			//3단계  연결정보를 이용해서 sql구문 만들기 =>  PreparedStatement
			// 문자열 => sql구문 변경, 실행할수 있는 내장객체 => PreparedStatement
			String sql="delete from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			//4단계   PrepardStatement sql구문 실행 (insert,update,delete)		
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();	
		}
	}//
	
	public int joinIdCheck(String id) {
		
		int result = -1;
		try {
			con = getConnection();
			String sql = "select id from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = 0;
			}else {
				result = 1;
			}
			
			System.out.println("아이디 중복체크결과 : " + result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();	
		}
		return result;
	}//joinIdCheck
	
	public MemberDTO userLogin(String id, String pass) {
		MemberDTO memberDTO=null;
		
		try {
			//1, 2단계 디비연결 메서드 호출
			con =getConnection();

			//3단계  연결정보를 이용해서 sql구문 만들기 =>  PreparedStatement
			// sql 폼에서 입력한 아이디 디비에 아이디 일치하고 ,
//			     폼에서 입력한 비밀번호 디비에  비밀번호 일치
			String sql="select *,DATE_FORMAT(date_cur,'%Y/%m/%d'),DATE_FORMAT(now(),'%Y/%m/%d') from member where id=? and pass=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);

			// 4단계   PreparedStatement sql구문 실행, select 결과 저장 => ResultSet
			rs=pstmt.executeQuery();

			// 5단계  ResultSet 저장된 내용을 출력, 저장
			// 결과값 행접근 다음행 next() 다음행 => 데이터 있으면 true / 데이터 없으면 false
			// 데이터 있으면 true 아이디 비밀번호 일치 => 세션값 생성 => main.jsp 이동
			// 데이터 없으면 false 아이디 비밀번호 틀림 => 아이디 비밀번호 틀림 메시지 출력 , 뒤로이동
			if(rs.next()) {
				// 다음행 첫번째 행 데이터 있으면 true => 열접근
				// memberDTO 객체생성 => 기억장소 할당
				memberDTO=new MemberDTO();
				// set메서드 호출 열접근을 데이터 저장
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPass(rs.getString("pass"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setDate(rs.getTimestamp("date"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setMobile(rs.getString("mobile"));
				memberDTO.setPhone(rs.getString("phone"));
				
				String date_cur = rs.getString("DATE_FORMAT(date_cur,'%Y/%m/%d')");
				String now = rs.getString("DATE_FORMAT(now(),'%Y/%m/%d')");
				
				if(date_cur.equals(now)) {
					
					}else{
						sql="update member set date_cur=now(), point_cur= point_cur+(select login_point from point), point_max= point_max+(select login_point from point) where id=?"; 
						pstmt=con.prepareStatement(sql);
						pstmt.setString(1, id);
						pstmt.executeUpdate();
					}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();	
		}
		return memberDTO;
	}// userLogin
	
	public void writePoint(BoardDTO boardDTO) throws Exception{
			MemberDAO memberDAO = null;
			memberDAO = new MemberDAO();
			MemberDTO memberDTO = null;
			memberDTO = new MemberDTO();
			con =getConnection();
			memberDTO=memberDAO.getMember(boardDTO.getName());
			String sql="update member set point_cur= point_cur+(select write_point from point), point_max= point_max+(select write_point from point) where id=?"; 
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, boardDTO.getName());
			
			pstmt.executeUpdate();
			pstmt.close();
			memberDAO.updateRating(memberDTO);
			
	}//writePoint
	public void commentPoint(CommentDTO commentDTO) throws Exception {
			MemberDAO memberDAO = null;
			memberDAO = new MemberDAO();
			MemberDTO memberDTO = null;
			memberDTO = new MemberDTO();
			memberDTO=memberDAO.getMember(commentDTO.getId());
			con =getConnection();
			
			String sql="update member set point_cur= point_cur+(select comment_point from point), point_max= point_max+(select comment_point from point) where id=?"; 
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getId());
			memberDAO.updateRating(memberDTO);
			pstmt.executeUpdate();
			pstmt.close();
			
			
		
	}//writePoint
	public void updateRating(MemberDTO memberDTO)throws Exception {
		int rating = 0;
		  if(memberDTO.getPoint_max()>=5000) {
			rating=3;
		}else if(memberDTO.getPoint_max() >= 3000) {
			rating=4;
		}else if(memberDTO.getPoint_max() >= 1000) {
			rating=5;
		}else if(memberDTO.getRating() == 1 ) {
			rating = 1;
		}else if(memberDTO.getRating() == 2 ) {
			rating = 2;
		}
			con =getConnection();
			
			String sql="update member set rating=? where id=?"; 
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, rating);
			pstmt.setString(2, memberDTO.getId());
			pstmt.executeUpdate();
		
	}//updateRating
	
	public MemberDTO getRating(int rateNum) {
		MemberDTO memberDTOR = null;
		memberDTOR = new MemberDTO();
		try {
			con =getConnection();
			
			String sql="select * from rate rating=?"; 
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, rateNum);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				
				memberDTOR.setRating_name(rs.getString("rating_name"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return memberDTOR;
		
	}
	public void usePoint(int price, MemberDTO memberDTO, MemberDTO MmemberDTO) {
		
		try {
			
			System.out.println(memberDTO.getRating());
			System.out.println(memberDTO.getId());
			System.out.println(price);
			System.out.println(MmemberDTO.getId());
			double VAT =price - price*0.1;
			con =getConnection();
			
			String sql="update member set point_cur=ROUND(point_cur + ?), point_max=(point_max + ?) where id=?"; 
			pstmt=con.prepareStatement(sql);
			pstmt.setDouble(1, VAT);
			pstmt.setDouble(2, VAT);
			
			pstmt.setString(3, MmemberDTO.getId());
			
			pstmt.executeUpdate();
			pstmt.close();
			MemberDAO memberDAO = new MemberDAO();
			memberDAO.updateRating(MmemberDTO);
			
			sql="update member set point_cur = ROUND(point_cur - (? - ? * (select discount_num from rate where rating = ?))) where id = ? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, price);
			pstmt.setInt(2, price);
			pstmt.setInt(3, memberDTO.getRating());
			pstmt.setString(4, memberDTO.getId());
			
			pstmt.executeUpdate();
			pstmt.close();
			
			sql = "update shop set dibs= dibs+1 where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, MmemberDTO.getId());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}//usePoint
	
	public List<MemberDTO> getMemberList() {
		
		List<MemberDTO>  memberList = new ArrayList<MemberDTO>();
		
		try {
			//1, 2단계 디비연결 메서드 호출
			con =getConnection();
			
			//3단계  연결정보를 이용해서 sql구문 만들기 =>  PreparedStatement
			// 문자열 => sql구문 변경, 실행할수 있는 내장객체 => PreparedStatement
			String sql="select * from member";
//			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			
			// 4단계   PreparedStatement sql구문 실행 (insert,update,delete) ,
//			        select 결과 저장 => ResultSet
			rs=pstmt.executeQuery();
			// 5단계  ResultSet 저장된 내용을 출력, 저장
			// 결과값 행접근 다음행 next() 다음행 => 데이터 있으면 true / 데이터 없으면 false
			// 열접근 => 출력
			while(rs.next()){
				// 다음행 첫번째 행 데이터 있으면 true => 열접근
				// memberDTO 객체생성 => 기억장소 할당
				MemberDTO memberDTO = new MemberDTO();
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPass(rs.getString("pass"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setDate(rs.getTimestamp("date"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setMobile(rs.getString("mobile"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setDate_cur(rs.getTimestamp("date_cur"));
				memberDTO.setPoint_cur(rs.getInt("point_cur"));
				memberDTO.setPoint_max(rs.getInt("point_max"));
				memberDTO.setRating(rs.getInt("rating"));
				
				
				memberList.add(memberDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return memberList;
	}//getMemberList
	
	
}//클래스
