package notice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class NoticeDAO {
	private Connection conn;
	private ResultSet rs;
	
	public NoticeDAO() {
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
	
	// 현재 시간
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
	
	// 글번호 생성 (seq)
	public int getNext() {
		String SQL = "select notice_seq from notice order by notice_seq desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 게시글 작성
	public int write(String noticeTitle, String noticeWriter, String noticeContent) {
		String SQL = "insert into notice(notice_title, notice_writer, notice_date, notice_content, notice_available) values(?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, noticeTitle);
			pstmt.setString(2, noticeWriter);
			pstmt.setString(3, getDate());
			pstmt.setString(4, noticeContent);
			pstmt.setInt(5, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// List
	public ArrayList<Notice> getList(int pageNumber) {
		String SQL = "select * from notice where notice_seq <= ? and notice_available = 1 order by notice_seq desc limit 10";
		ArrayList<Notice> list = new ArrayList<Notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Notice notice = new Notice();
				notice.setNotice_seq(rs.getInt(1));
				notice.setNotice_title(rs.getString(2));
				notice.setNotice_writer(rs.getString(3));
				notice.setNotice_date(rs.getString(4));
				notice.setNotice_content(rs.getString(5));
				notice.setNotice_available(rs.getInt(6));
				list.add(notice);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 페이징 처리
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from notice where notice_seq <= ? and notice_available = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// notice view 페이지, 게시글 보기
	public Notice getNotice(int notice_seq) {
		String SQL = "select * from notice where notice_seq = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, notice_seq);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Notice notice = new Notice();
				notice.setNotice_seq(rs.getInt(1));
				notice.setNotice_title(rs.getString(2));
				notice.setNotice_writer(rs.getString(3));
				notice.setNotice_date(rs.getString(4));
				notice.setNotice_content(rs.getString(5));
				notice.setNotice_available(rs.getInt(6));
				return notice;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// notice 삭제
	public int delete(int notice_seq) {
		String SQL = "UPDATE notice SET notice_available = 0 WHERE notice_seq = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, notice_seq);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}
	
	// notice 수정
	public int update(int notice_seq, String notice_title, String notice_content) {
		String SQL = "update notice set notice_title = ?, notice_content = ? where notice_seq = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, notice_title);
			pstmt.setString(2, notice_content);
			pstmt.setInt(3, notice_seq);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
}
