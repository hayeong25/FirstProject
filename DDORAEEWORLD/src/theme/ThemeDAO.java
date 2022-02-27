package theme;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ThemeDAO {
	private Connection conn;
	private ResultSet rs;
	private PreparedStatement pstmt;
	
	public ThemeDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/test?serverTimezone=UTC&useSSL=false";
			String dbID = "root";
			String dbPassword = "tiger";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int themeMax() {
		String SQL = "select count(*) from theme";
		int max = 0;
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				max = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return max;
	}
	
	public String todayTheme() {
		String SQL = "select theme_content from theme where theme_seq = ?";
		String result = "";
		long lt = System.currentTimeMillis();
		int t = (int)(lt / 1000 / 60 / 60 / 24);
		int max = themeMax();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (t % max) + 1);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
