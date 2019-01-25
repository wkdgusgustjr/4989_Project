package action.buyer;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TradingDAO;

@WebServlet("/deal_cancel.do")
public class Trading_Deal_Cancel_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 상품번호와 구매자아이디 받아옴
		int		  p_idx = Integer.parseInt( request.getParameter("p_idx") );
		String buyer_id = request.getParameter("buyer_id");
		
		System.out.println(p_idx);
		System.out.println(buyer_id);
		
		Map<String, Object> map = new HashMap<>();
		map.put("p_idx", p_idx);
		map.put("buyer_id", buyer_id);
		
		// 거래진행상황 -> 매입취소버튼 누르면 TRADING 테이블에서 해당 row 삭제
		TradingDAO.getInstance().dealCancel( map );
		
		response.sendRedirect("product_deal_progress_input.do");
	}

}
