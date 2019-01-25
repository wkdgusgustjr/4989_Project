package action.buyer;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.TradingDAO;
import dao.ProductDAO;
import vo.TradingVO;

@WebServlet("/deposit_waiting.do")
public class Trading_Deposit_Waiting_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int 		  p_idx = Integer.parseInt( request.getParameter("p_idx") ); 		   // 상품 고유번호
		int buyer_hopeprice = Integer.parseInt( request.getParameter("buyer_hopeprice") ); // 체결될 가격
		String buyer_id = request.getParameter("buyer_id");
		
		System.out.println("상품번호 : " + p_idx);
		System.out.println("체결될 가격 : " + buyer_hopeprice);
		System.out.println("구매자 아이디 : " + buyer_id);
		
		TradingVO vo = new TradingVO();
		vo.setP_idx( p_idx );
		vo.setBuyer_hopeprice( buyer_hopeprice );
		vo.setBuyer_id( buyer_id );
		
		// 판매자가 입금요청 버튼을 눌렀을 때, TRADING 테이블의 현재 거래의 상태를 '입금대기'로 변경
		TradingDAO.getInstance().depositWaiting( vo );
		
		// 판매자가 입금요청 버튼을 눌렀을 때, PRODUCT 테이블의 현재 상품의 상태를 '거래중'으로 변경
		ProductDAO.getInstance().depositWaiting( p_idx );
				
		// 거래가 성사되지 못한 나머지 매입자들의 상태를 '미체결' 로 변경
		TradingDAO.getInstance().dealFail( vo );
		
		response.sendRedirect("product_deal_progress_input.do");
	}

}
