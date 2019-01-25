package action.qnaboard;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QnABoardDAO;
import vo.QnABoardVO;

@WebServlet("/qnaboard_update_output.do")
public class QnABoard_Update_Output_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		int qna_idx = 0;
		
		if ( request.getParameter("qna_idx") != null ) {
			qna_idx = Integer.parseInt( request.getParameter("qna_idx") );
		}
		
		String qna_title		 = request.getParameter("qna_title");		// 변경될 제목
		String qna_answertype 	 = request.getParameter("qna_answertype");  // 변경될 질문유형
		String qna_text			 = request.getParameter("qna_text");		// 변경될 내용
		
		QnABoardVO vo = new QnABoardVO();
		vo.setQna_idx( qna_idx );
		vo.setQna_title( qna_title );
		vo.setQna_answertype( qna_answertype );
		vo.setQna_text( qna_text );
		
		QnABoardDAO.getInstance().update_Board( vo );
		
		response.sendRedirect("qnaboard_main.do");
	}

}
