package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {

	private Connection conn;
	private PreparedStatement pstmt;
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
}
