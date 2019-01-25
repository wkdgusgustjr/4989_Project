package action.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TradingDAO;
import vo.TradingVO;

@WebServlet("/member_dealhistory_input.do")
public class Member_Histoy_Input_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/** -------------- 내 거래내역보기 --------------*/
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		
		String memberType = (String) session.getAttribute("memberType");
		
		if ( memberType.equals("일반") ) {
			String seller_id = (String) session.getAttribute("memberId");
			System.out.println("현재 접속한 회원의 아이디 : " + seller_id);
			
			List<TradingVO> list = TradingDAO.getInstance().seller_dealHistory( seller_id );
			
			request.setAttribute("list", list);
			
			RequestDispatcher disp = request.getRequestDispatcher("member/member_dealhistory_seller.jsp");
			disp.forward(request, response);
		}
		
		else if ( memberType.equals("사업자") ) {
			String buyer_id = (String) session.getAttribute("memberId");
			System.out.println("현재 접속한 회원의 아이디 : " + buyer_id);

			List<TradingVO> list = TradingDAO.getInstance().buyer_dealHistory( buyer_id );
			
			request.setAttribute("list", list);
			
			RequestDispatcher disp = request.getRequestDispatcher("member/member_dealhistory_buyer.jsp");
			disp.forward(request, response);
		}

	}

}
