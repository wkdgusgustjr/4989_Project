package action.qnaboard;

import java.io.IOException;

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


@WebServlet("/qnaboard_comment_regi.do")
public class QnABoard_Comment_Regi_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int 		qna_idx	= Integer.parseInt( request.getParameter("qna_idx") ); // 해당 게시글 번호
		String com_register = request.getParameter("com_register");		    	   // 댓글 작성자
		String 	   com_text = request.getParameter("com_text");		   			   // 댓글 내용
		
		// VO에 저장
		CommentVO vo = new CommentVO();
		vo.setQna_idx( qna_idx ) ;
		vo.setCom_text( com_text );
		vo.setCom_register( com_register );
		
		// DB에 insert
		CommentDAO.getInstance().insert_Comment( vo );
		
		response.sendRedirect("qnaboard_info.do?qna_idx=" + qna_idx);
		
		
	}

}
