package action.product;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SellerDAO;
import vo.ProductVO;

@WebServlet("/product_myproduct_input.do")
public class Product_Myproduct_Input_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 내 상품관리 페이지로 가기전에 할일 여기서함
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		// 내 아이디 (판매자 아이디)
		String sellerId = (String)session.getAttribute("memberId");
		
		// 내 아이디로 PRODUCT 테이블에 있는 내 상품중 '대기' 상태인 상품만 가져온다.
		List<ProductVO> list = SellerDAO.getInstance().getMyProduct( sellerId );
		
		request.setAttribute("list", list);
		
		RequestDispatcher disp = request.getRequestDispatcher("shop/product_myproduct.jsp");
		disp.forward(request, response);
	}

}
