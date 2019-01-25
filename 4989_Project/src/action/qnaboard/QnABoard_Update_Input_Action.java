package action.qnaboard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QnABoardDAO;
import vo.QnABoardVO;

@WebServlet("/qnaboard_update_input.do")
public class QnABoard_Update_Input_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int qna_idx = 0;
		
		// 수정할 게시물 번호
		if ( request.getParameter("qna_idx") != null ) {
			qna_idx = Integer.parseInt(request.getParameter("qna_idx"));
		}
		
		// 게시물 번호로 수정할 게시글 내용 가져옴
		QnABoardVO board = QnABoardDAO.getInstance().select_One( qna_idx );
		
		request.setAttribute("board", board);
		
		RequestDispatcher disp = request.getRequestDispatcher("board/qnaboard_update.jsp");
		disp.forward(request, response);
	}

}
