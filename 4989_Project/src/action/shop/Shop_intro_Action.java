package action.shop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/shop_intro.do")
public class Shop_intro_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 서비스 소개 페이지로 이동하기 전 컨트롤러
		RequestDispatcher disp = request.getRequestDispatcher("shop/shop_intro.jsp");
		disp.forward(request, response);
	}

}
