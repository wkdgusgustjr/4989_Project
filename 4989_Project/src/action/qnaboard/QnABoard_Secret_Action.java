package action.qnaboard;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommentDAO;
import dao.QnABoardDAO;
import vo.CommentVO;
import vo.QnABoardVO;

@WebServlet("/qnaboard_secret.do")
public class QnABoard_Secret_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int qna_idx = 0;
		
		// 클릭한 게시물 번호
		if( request.getParameter("qna_idx") != null ) {
			qna_idx = Integer.parseInt( request.getParameter("qna_idx") );
		}
		
		// 게시물 번호로 상세내용 조회 + 조회수 증가
		QnABoardVO board = QnABoardDAO.getInstance().select_One( qna_idx );

		// 해당 게시물 댓글 목록 구하기
		List<CommentVO> comment = CommentDAO.getInstance().select_AllComment(qna_idx);
		
		request.setAttribute("Total", comment.size());	// 해당 게시물 댓글 수
		request.setAttribute("comment", comment); 	 	// 해당 게시물 모든 댓글 리스트
		request.setAttribute("board", board);			// 해당 게시글 모든 정보
		
		RequestDispatcher disp = request.getRequestDispatcher("board/qnaboard_secret.jsp");
		disp.forward(request, response);
	}

}
