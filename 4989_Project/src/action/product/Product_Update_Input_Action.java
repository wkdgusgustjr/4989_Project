
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

@WebServlet("/product_update_input.do")
public class Product_Update_Input_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 수정할 상품번호 파라미터
		int p_idx = Integer.parseInt( request.getParameter("p_idx") );
		
		// 상품 번호로 상품 상세내용 가져옴
		ProductVO vo = SellerDAO.getInstance().getMyProductUpdate( p_idx );
		
		request.setAttribute("myproduct", vo);
		
		RequestDispatcher disp = request.getRequestDispatcher("shop/product_update.jsp");
		disp.forward(request, response);
	}

}
