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

@WebServlet("/qnaboard_write_output.do")
public class QnABoard_Write_Output_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String  qna_publictype 	= request.getParameter("qna_publictype"); // 공개여부
		String 	qna_answertype 	= request.getParameter("qna_answertype"); // 질문유형
		String  qna_title 		= request.getParameter("qna_title");	  // 제목
		String 	qna_register 	= request.getParameter("qna_register");   // 작성자
		String 	qna_text 		= request.getParameter("qna_text"); 	  // 내용
		String  qna_pwd 		= request.getParameter("qna_pwd");		  // 비밀번호
		/*
		System.out.println("공개여부 : " + qna_publictype);
		System.out.println("질문유형 : " + qna_answertype);
		System.out.println("제목 : " + qna_title);
		System.out.println("작성자 : " + qna_register);
		System.out.println("내용 : " + qna_text);
		System.out.println("비밀번호 : " + qna_pwd); */
		
		// VO에 저장
		QnABoardVO vo = new QnABoardVO();
		vo.setQna_publictype( qna_publictype );
		vo.setQna_answertype( qna_answertype );
		vo.setQna_title( qna_title );
		vo.setQna_register( qna_register );
		vo.setQna_text( qna_text );
		vo.setQna_pwd( qna_pwd );
		
		// DB에 insert
		QnABoardDAO.getInstance().insert_Board( vo );
		
		// 게시판 메인페이지로 이동
		response.sendRedirect("qnaboard_main.do");
	}
		
}
