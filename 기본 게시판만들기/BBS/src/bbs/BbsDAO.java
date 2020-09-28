package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;
	//private PreparedStatement pstmt; bbsDAO는 여러 함수가 충돌가능성이 있기때문에 각 메서드마다 pstmt를 넣어 사용한다.
	private ResultSet rs;
	
	//생성자로 객체 생성시 자동 db연결 하도록
	public BbsDAO () {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "qhfkths0446";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID , dbPassword );
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("접속안됨1");
		}
	}
	//현재날짜와 시간을 가져오는 메서드
	public String getDate() {
		String SQL = "SELECT NOW()";	//현재 시간을 가져오는 문장
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1); //현재날짜 반환
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";	//db오류시
	}
	
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";	//bbsID를 내림차순으로 마지막에 쓰인 글번호를 가져오는 sql문
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1; //+1을해 마지막 번호 다음 번호를 가져온다
			}
			return 1;   //첫번째 게시물인 경우는 먼저 1반환 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//db오류시
	}
	//게시글을 입력받아 db에 입력하는 메서드
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)";	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1); //게시글을 쓰면 글이 존재하니까 1
			return pstmt.executeUpdate();//성공이면 1이상 숫자반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//db오류시
	}
	//db에서 글쓰기 내용을 가져와 게시판 페이지에 보여주는 메서드
	//페이지에 따라 10개씩 게시글을 가져오는 메서드
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";	//
											//bbsID가 특정값보다 작고, 글이 존재하는 모든것을 내림차순으로 10개만
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {								
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); //12개의 게시글일때 13-(2-1)*10 = 3이므로 -> 2번째 페이지는 3미만인 2개를 불러
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1)); //bbs에 담겼던 모든 속성을 빼온다.
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsData(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs); 		//해당인스턴스를 담아서 list에 반환한다.
			}
		} catch (Exception e) {
			e.printStackTrace();
			}
		return list; //10개의 내용을 담는 list를 반환
	}
	public boolean nextPage(int pageNumber) { //10단위로 끊기는 페이지는 다음 페이지가 없다는 것을 알려줘야함(페이징처리)
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";	
									//bbsID가 특정값보다 작고, 글이 존재하는 모든것을 가져옴 
		
		try {								
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); //12개의 게시글일때 13-(2-1)*10 = 3이므로 -> 2번째 페이지는 3미만인 2개를 불러
			rs = pstmt.executeQuery();
		if(rs.next()) {
			return true;   //결과가 하나라도 존재한다면 true
			}
		} catch (Exception e) {
		e.printStackTrace();
			}
		return false; //10개의 내용을 담는 list를 반환
	}
	//하나의 글을 클릭하면 볼 수 있는 메서드
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";	
		//bbsID가 특정값일때 같은 글을 불러옴 

	try {								
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1,bbsID); //bbsID 아이디를 넣고 같으면 글을 불러옴
		rs = pstmt.executeQuery();
	if(rs.next()) {
		Bbs bbs = new Bbs();
		bbs.setBbsID(rs.getInt(1)); //bbs에 담겼던 모든 속성을 빼온다.
		bbs.setBbsTitle(rs.getString(2));
		bbs.setUserID(rs.getString(3));
		bbs.setBbsData(rs.getString(4));
		bbs.setBbsContent(rs.getString(5));
		bbs.setBbsAvailable(rs.getInt(6));
		return bbs;  //다 넣어서 반환함
		
		}
	} catch (Exception e) {
		e.printStackTrace();
		}
		return null; //해당 글이 존재하지 않는 경우
		}
	//게시판 글을 수정하는 메서드
	public int update (String bbsTitle, String bbsContent, int bbsID) {
	String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";	//특정한 아이디에 해당하는 제목과 내용 수정
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, bbsTitle);
		pstmt.setString(2, bbsContent);
		pstmt.setInt(3, bbsID);
		return pstmt.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	}
		return -1;	//db오류시
	}
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
			return -1;	//db오류시
	}
}
