package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userRegisterServlet")
public class UserRegisterServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String user_id = request.getParameter("user_id");
		String user_password1 = request.getParameter("user_password1");
		String user_password2 = request.getParameter("user_password2");
		String user_email = request.getParameter("user_email");
		
		if(user_id == null || user_id.equals("") || user_password1 == null || user_password1.equals("") || user_password2 == null || user_password2.equals("") || user_email == null || user_email.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "입력되지 않은 항목이 있습니다.");
			response.sendRedirect("sign.jsp");
			return;
		}
		if(!user_password1.equals(user_password2)) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "비밀번호가 일치하지 않습니다.");
			response.sendRedirect("sign.jsp");
			return;
		}
		int result = new UserDAO().register(user_id, user_password1, user_email);
		if(result == 1) {
			request.getSession().setAttribute("messageType", "성공 메세지");
			request.getSession().setAttribute("messageContent", "성공적으로 회원가입이 완료되었습니다.");
			request.getSession().setAttribute("user_id", user_id);
			response.sendRedirect("index.jsp");
			return;
		}else {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "가입에 오류가 발생했습니다.");
			response.sendRedirect("sign.jsp");
			return;
		}
	}
}
