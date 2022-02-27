package Self;

import java.sql.*;

public class SelfDAO {
	private static SelfDAO instance = new SelfDAO();
	public static SelfDAO getInstance() {
		if(instance == null) {
			synchronized(SelfDAO.class) {
				instance = new SelfDAO();
			}
		}
		return instance;
	}
	
	private Connection conn;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	
	public SelfDAO() {		
		String sql = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			String jdbcDriver = "jdbc:mysql://localhost:3306/ddoraeeworld?serverTimezone=UTC";
			String dbuser = "root";
			String dbpw = "971130";
			conn = DriverManager.getConnection(jdbcDriver,dbuser,dbpw);			
			System.out.println("Connection success!");
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("fail Connection..");
		}
	}
	
	public int upload(String user_id, String self_comment) {
		int result = 0;
		String sql = "update user set profil = ? where user_id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, self_comment);
			pstmt.setString(2, user_id);
			pstmt.executeUpdate();
			result = 1;
			return result;//���ε� ����
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;//���ε� ����
		
	}
	
}
