package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

public class UserDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static UserDAO instance = new UserDAO(); 
	   public static UserDAO getInstance() {
	      if(instance == null) {
	         synchronized(UserDAO.class) {
	            instance = new UserDAO();
	         }
	      }      
	      return instance;
	   }
	   
	public UserDAO() {
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
	
	// ID Duplicate Check
	public int registerCheck(String user_id) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		String SQL = "select * from user where user_id = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			if(rs.next() || user_id.equals("")) {
				return 0;
			}else {
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	} 
	
	// Register
	public int register(String user_id, String user_password, String user_email) {
		PreparedStatement pstmt = null;
		String SQL = "insert into user(user_id, user_password, user_email, permission) values(?, ?, ?, 0)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_password);
			pstmt.setString(3, user_email);
			return pstmt.executeUpdate(); // Success
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // DB Error
	} 
	
	// Login
	public int login(HttpServletRequest request) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		String SQL = "select user_password from user where user_id = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, request.getParameter("user_id"));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(request.getParameter("user_password").equals(rs.getString(1))) {
					return 1; // Login Success
				}else {
					return 0; // Wrong password
				}
			}else {
				return 0; // Wrong ID
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // DB Error
	}
	
	// User max count
	public int countSeq() {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		String SQL = "select count(*) from user";
		int result = 0;
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	// Random matching
	public String matching() {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		String SQL = "select user_id from user where user_seq = ?";
		String mat = "";
		Random rand = new Random();
		int random = rand.nextInt(countSeq()) + 1;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, random);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mat = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mat;
	}
	
	// Follow List
	public List<String> followList(String user_id) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		String SQL = "select following from follow where follower = ?";
		List<String> list = new ArrayList<String>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public int follow(String following, String follower) {
	      PreparedStatement pstmt = null;
	      String SQL = "insert into follow values(? , ?)";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, following);
	         pstmt.setString(2, follower);
	         return pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	            if(pstmt != null) pstmt.close();
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	      }
	      return -1;
	   }
	   
	   // UnFollow
	   public int unFollow(String following, String follower) {
	      PreparedStatement pstmt = null;
	      String SQL = "delete from follow where following = ? and follower = ?";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, following);
	         pstmt.setString(2, follower);
	         return pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	            if(pstmt != null) pstmt.close();
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	      }
	      return -1;
	   }
	   
	   // Follow Status
	   public boolean followStat(String following , String follower) {
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      boolean flag = false;
	      String SQL = "select following from follow where follower = ?";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, follower);
	         rs = pstmt.executeQuery();
	         while(rs.next()) {
	            if(rs.getString(1).equals(following)) {
	               flag = true;
	            }
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	            if(rs != null) rs.close();
	            if(pstmt != null) pstmt.close();
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	      }
	      return flag;
	   }
	
	// Permission Check
	public boolean permission(String user_id) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		String SQL = "select permission from user where user_id = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt(1) == 1) {
					flag = true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	public String getEmail(String user_id) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
	      String user_email = null;
	      String SQL = "select user_email from user where user_id = ?";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, user_id);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            user_email = rs.getString(1);
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return user_email;
	   }
	   
	   public int updateUser(User vo) {
		   ResultSet rs = null;
			PreparedStatement pstmt = null;
	      String SQL = "update user set user_password = ? where user_id = ?";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, vo.getUser_password());
	         pstmt.setString(2, vo.getUser_id());
	         return pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         try {
	            if(rs != null) rs.close();
	            if(pstmt != null) pstmt.close();
	            if(conn != null) conn.close();
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	      }
	      return -1;
	 }
	   
	   public int upload(String user_id, String self_comment) {
			int result = 0;
			String sql = "update user set profile = ? where user_id=?";
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
	   
	   public String select(String user_id) {
		   String sql = "select profile from user where user_id = ?";
		   try {
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1, user_id);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   return rs.getString(1);
			   }
		   }catch(Exception e) {
			   e.printStackTrace();
		   }
		   return "";
	   }
}
