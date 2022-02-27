package fileupload;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;

public class FileUploadDAO {
	private static FileUploadDAO instance = new FileUploadDAO();
	public static FileUploadDAO getInstance() {
		if(instance == null) {
			synchronized(FileUploadDAO.class) {
				instance = new FileUploadDAO();
			}
		}
		return instance;
	}
	private Connection conn;
	
	public FileUploadDAO() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			Class.forName("com.mysql.jdbc.Driver"); 
			String jdbcDriver = "jdbc:mysql://localhost:3306/test?serverTimezone=UTC";
			String dbuser = "root";
			String dbpw = "tiger";
			conn = DriverManager.getConnection(jdbcDriver,dbuser,dbpw);			
			System.out.println("Connection success!");
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("fail Connection..");
		}
	}
	
	public int upload(String fileName, String fileRealName, String uploadpath) {
		String sql = "insert into profile values(?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uploadpath);
			pstmt.setString(2, fileName);
			pstmt.setString(3, fileRealName);
			return pstmt.executeUpdate();//��� ���ε� ������ ��� int������ ��ȯ
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;//��� ���ε� ����
	}
	
	public String profile(String fileName) {
		ResultSet rs = null;
		String sql = "select profile_url from profile where profile_name = ?";
		String profile_url = "";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fileName);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				profile_url = rs.getString(1);//sql ���� ��� ���� profile_url�� ����
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return profile_url;
	}
}