package action.qnaboard;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommentDAO;
import dao.QnABoardDAO;

@WebServlet("/qnaboard_delete.do")
public class QnABoard_Delete_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String Strqna_idx = request.getParameter("qna_idx");
		int qna_idx = Integer.parseInt(Strqna_idx);
		
		System.out.println("삭제할 게시물번호 : " + Strqna_idx);
		
		// QNABOARD 테이블에서 해당 게시글 삭제
		QnABoardDAO.getInstance().delete_qnaBoard( qna_idx );
		
		// BOARD_COMMENT 테이블에서 해당 게시글에 달린 댓글 전부 삭제
		CommentDAO.getInstance().comment_delete_in_qnaBoard( qna_idx );
		
		response.sendRedirect("qnaboard_main.do");
	}

}
