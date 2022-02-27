package Personal_bbs;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class Personal_bbsDAO {
	
	private static Personal_bbsDAO instance = null;
	public static Personal_bbsDAO getInstance() {
		if(instance == null) {
			synchronized (Personal_bbsDAO.class) {
				instance = new Personal_bbsDAO();
			}
		}
		return instance;
	}
	
	private Connection conn;
	private ResultSet rs = null;
	
	
	public Personal_bbsDAO() {//��񿬰�
		PreparedStatement pstmt = null;
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

	public String getDate() {
      String SQL = "select now()";
      try {
         PreparedStatement pstmt = conn.prepareStatement(SQL);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            return rs.getString(1);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }
      return "";
   }
	
	public String insert(String bbs_title, String bbs_writer, String bbs_content) {
		String sql = "insert into personal_bbs(bbs_title, bbs_writer, bbs_date, bbs_content) values(?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbs_title);
			pstmt.setString(2, bbs_writer);
			pstmt.setString(3, getDate());
			pstmt.setString(4, bbs_content);
			pstmt.executeUpdate();
			return "업로드 성공";
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "업로드 실패";
	}
	
	public List<Personal_bbsVO> bbs_list(){
		List<Personal_bbsVO> bbs_list = new ArrayList<Personal_bbsVO>();
		
		String sql = "select bbs_title, bbs_writer, bbs_date, bbs_content from personal_bbs order by bbs_seq desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Personal_bbsVO vo = new Personal_bbsVO();
				vo.setBbs_title(rs.getString("bbs_title"));
				vo.setBbs_writer(rs.getString("bbs_writer"));
				vo.setBbs_date(rs.getString("bbs_date"));
				vo.setBbs_content(rs.getString("bbs_content"));
				
				bbs_list.add(vo);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return bbs_list;
	}
	
	public int getArticleCount() {
		int count = 0;
		String sql = "select count(*) from personal_bbs";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			System.out.println(count);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}	
}