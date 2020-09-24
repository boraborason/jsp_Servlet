package user;
//데이터 베이스 접근객체(실제적으로 db에서 정보를 불러오거나 넣을때 사용)

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//생성자로 객체 생성시 자동 db연결 하도록
	public UserDAO () {
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
	
	//아이디를 입력받아 존재하면 비번을 가져옴
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;  //로그인성공
				} else {
					return 0;  //비번오류
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("접속안됨2");
		}
		return -2;  //db오류(try-catch문 자체실행이 안됨)
	}
	
	//한명의 사용자를 입력받아 회원가입처리
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();  //insert문은 성공시 반드시 1이상 숫자가 반환
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("join메서드 확인");
		}
		return -1;  //db오류(아이디중복시)
	}
}
