package action.product;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SellerDAO;
import vo.ProductVO;

@WebServlet("/product_delete.do")
public class Product_Delete_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 삭제할 상품번호 파라미터
		int p_idx = Integer.parseInt( request.getParameter("p_idx") );
		
		// 1. 상품 번호로 PRODUCT 테이블에있는 상품삭제
		SellerDAO.getInstance().myProductDelete_Product( p_idx );
		
		// 2. TRADING 테이블에서 삭제한 상품의 상태를 '삭제' 로 변경.
		SellerDAO.getInstance().myProductDelete_Trading( p_idx );
		
		RequestDispatcher disp = request.getRequestDispatcher("/product_myproduct_input.do");
		disp.forward(request, response);
	}

}
