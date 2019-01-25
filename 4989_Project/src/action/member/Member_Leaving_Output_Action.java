package action.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BuyerDAO;
import dao.SellerDAO;

@WebServlet("/member_leaving_output.do")
public class Member_Leaving_Output_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("utf-8");
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		String memberType = (String)session.getAttribute("memberType"); // 세션에서 회원타입 획득
		
		String 	 leaving_ages = request.getParameter("ages"); 		  // 연령대 파라미터
		String leaving_reason = request.getParameter("reason"); 	  // 탈퇴사유 파라미터
		String leaving_id = (String)session.getAttribute("memberId"); // 탈퇴할 회원 아이디
		
		Map<String, String> map = new HashMap<>();
		map.put("leaving_ages", leaving_ages);
		map.put("leaving_reason", leaving_reason);
		map.put("leaving_id", leaving_id);
		
		if ( memberType.equals("일반") ) {
			// 탈퇴 사유 저장
			SellerDAO.getInstance().insertLeavingReason( map );
			
			// 회원 삭제
			SellerDAO.getInstance().deleteUserData( leaving_id );
			
			/** 회원이 올렸던 게시글, 상품목록 삭제 만들어야함 */ 
			
			session.invalidate(); // 세션에 저장된 값 전부 제거
		}
		else if ( memberType.equals("사업자") ) {
			// 탈퇴 사유 저장
			BuyerDAO.getInstance().insertLeavingReason( map );
			
			// 회원 삭제
			BuyerDAO.getInstance().deleteUserData( leaving_id );
			
			/** 회원이 올렸던 게시글, 상품목록 삭제 만들어야함 */
			
			session.invalidate(); // 세션에 저장된 값 전부 제거
		}
		
		response.sendRedirect("product_list_input.do");
	}

}
