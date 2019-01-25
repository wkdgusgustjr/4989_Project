package action.qnaboard;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommentDAO;
import dao.QnABoardDAO;

@WebServlet("/qnaboard_comment_delete.do")
public class QnABoard_Comment_Delete_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 삭제할 댓글 번호
		int com_idx = Integer.parseInt(request.getParameter("com_idx"));

		// 원 글 번호 
		int qna_idx = Integer.parseInt(request.getParameter("qna_idx"));
		
		// 댓글 삭제
		CommentDAO.getInstance().delete_Comment(com_idx);
		
		response.sendRedirect("qnaboard_info.do?qna_idx=" + qna_idx);
		
	}

}
