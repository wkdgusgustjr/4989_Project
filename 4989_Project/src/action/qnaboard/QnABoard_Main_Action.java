package action.qnaboard;

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

import dao.QnABoardDAO;
import util.Paging;
import vo.QnABoardVO;

@WebServlet("/qnaboard_main.do")
public class QnABoard_Main_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String page = request.getParameter("page");
		
		int currentPage = 1;
		if( page != null && page.equals("") == false) {
			currentPage = Integer.parseInt(page);
		}
		
		int pageSize = 5; // 한 화면에 보여질 항목 수
		
		// 전체 게시글 개수
		int totalSize = QnABoardDAO.getInstance().selectCount(); 
		
		Paging paging = new Paging( pageSize, totalSize, currentPage );
		
		HashMap<String, String> map = new HashMap<>();
		map.put("startNo", paging.getStartNo() + "");	// int를 문자열로 만들었음
		map.put("endNo", paging.getEndNo() + "");
		
		List<QnABoardVO> list = QnABoardDAO.getInstance().select( map );
		
		request.setAttribute("paging", paging);
		request.setAttribute("total", list.size());	// 전체 게시물 수
		request.setAttribute("list", list); 	 	// 전체 게시물 내용
			
		RequestDispatcher disp = request.getRequestDispatcher("board/qnaboard_main.jsp");
		disp.forward(request, response);
	}

}
