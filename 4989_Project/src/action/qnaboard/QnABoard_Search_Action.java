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
import vo.QnABoardVO;

@WebServlet("/qnaboard_search.do")
public class QnABoard_Search_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	
       	String col 		= request.getParameter("col");  // 검색조건 파라미터
       	String word	 	= request.getParameter("word"); // 검색란에 입력한 파라미터
       	
       	// 검색조건과 내용을 Map에 담는다.
       	Map<String, String> map = new HashMap<String, String>();
       	map.put("col", col);
       	map.put("word", word);
       	
       	List<QnABoardVO> search_list = QnABoardDAO.getInstance().select_Search_Board( map );
       	
       	request.setAttribute("search_list", search_list);	// 검색된 게시물
       	request.setAttribute("total", search_list.size());	// 전체 게시물 수
	
		RequestDispatcher disp = request.getRequestDispatcher("board/qnaboard_search_result.jsp");
		disp.forward(request, response);
	}

}
