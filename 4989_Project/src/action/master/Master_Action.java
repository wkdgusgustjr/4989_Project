package action.master;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MasterDAO;
import util.Paging;
import vo.BuyerVO;
import vo.LeavingMemberVO;
import vo.ProductVO;
import vo.SellerVO;


@WebServlet("/master.do")
public class Master_Action extends HttpServlet {
	
	// 페이징 값 구하는 함수
	private Map<String, String> createPaging( Paging paging, String paramType ) {
		
		Map<String, String> map = new HashMap<>();
		map.put("startNo", paging.getStartNo() + "");
		map.put("endNo", paging.getEndNo() + "");
		map.put("paramType", paramType);
		
		return map;
	}
	
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		/** 각 case문에 필요한 공통 멤버변수들을 멤버변수로 선언 */
		Map<String, String> map = null;	// createPaging 결과를 담아서 가져올 map
		int 		  tempCount = 0;	// 해당 파라미터타입의 데이터 개수(count(*))를 담을때 필요한 변수
		List<?> 		   list = null;	// 해당 파라미터타입의 모든 데이터를 담을때 필요한 변수
		String 		   location = "";	// 이동할 jsp페이지를 지정할 변수 
		Paging 			 paging = null; // 페이징 시 필요한 변수
		int		       pageSize = 0; 	// 페이징 시 한 화면에 보여줄 항목 개수
		
		// 파라미터 타입에 따라 넘어갈 페이지 지정
		String paramType = request.getParameter("type");
		
		// 파라미터 없이 호출되면 기본 페이지를 '상품목록' 페이지로 지정
		if ( paramType == null || paramType.isEmpty() ) {
			paramType = "product";
		}
		
		// 현재 페이지 번호
		String page = request.getParameter("page");
		
		int currentPage = 1; // 현재 페이지 번호 (기본 1페이지)
		
		// 페이지 번호가 없으면 현재 페이지를 1페이지로 지정
		if( page != null && page.equals("") == false ){
			currentPage = Integer.parseInt( page );
		}
		
		
		/** 파라미터 타입에 따른 switch문 */
		/** 들어간 case문 안에서 멤버변수들을 초기화해준다 */
		switch( paramType ) {
		
		case "seller" :
			// SELLER 카운트
			tempCount = MasterDAO.getInstance().sellerCount();
			
			// 한 화면에 보여줄 데이터 개수 지정
			pageSize = 5;
			
			// 매개변수 -> (한 화면에 보여줄 데이터 개수, seller 카운트, 현재 페이지 번호)
			paging = new Paging( pageSize, tempCount, currentPage );
			
			// 매개변수 -> (가져온 paging 변수 값, 파라미터 타입)
			map = createPaging( paging, paramType );
			
			// SELLER 리스트 전체
			list = (List<SellerVO>)MasterDAO.getInstance().sellerList( map );
			
			// 이동할 페이지 지정
			location = "master/master_list_seller.jsp";
			break;
			
		case "buyer" :
			tempCount = MasterDAO.getInstance().buyerCount();
			pageSize  = 5;
			paging    = new Paging( pageSize, tempCount, currentPage );
			map 	  = createPaging( paging, paramType );
			list 	  = (List<BuyerVO>)MasterDAO.getInstance().buyerList( map );
			location  = "master/master_list_buyer.jsp";
			break;
			
		case "leaving" :
			tempCount = MasterDAO.getInstance().leavingMemberCount();
			pageSize  = 5;
			paging 	  = new Paging( pageSize, tempCount, currentPage );
			map 	  = createPaging( paging, paramType );
			list  	  = (List<LeavingMemberVO>)MasterDAO.getInstance().leavingMemberList( map );
			location  = "master/master_list_leavingmember.jsp";
			break;
			
		case "product" :
			tempCount = MasterDAO.getInstance().productCount();
			pageSize  = 10;
			paging    = new Paging( pageSize, tempCount, currentPage );
			map 	  = createPaging( paging, paramType );
			list 	  = (List<ProductVO>)MasterDAO.getInstance().productList( map );
			location  = "master/master_list_product.jsp";
			break;
			
		case "qnaboard" :
			System.out.println("질문답변 게시판 페이지");
			break;
			
		default :
			System.out.println("파라미터가 비정상적으로 호출됨");
		}
		
		request.setAttribute("list", list);				// 각 테이블 row 개수
		request.setAttribute("paging", paging);			// 각 테이블 페이징 수
		request.setAttribute("totalSize", tempCount);	// 각 테이블 총 row 개수
		
		RequestDispatcher disp = request.getRequestDispatcher( location );
		disp.forward(request, response);
	}
	
}





