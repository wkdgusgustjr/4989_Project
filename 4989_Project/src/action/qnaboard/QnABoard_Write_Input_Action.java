package action.qnaboard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/qnaboard_write_input.do")
public class QnABoard_Write_Input_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 글 작성 페이지로 가기전에 할일 여기서 함
		
		RequestDispatcher disp = request.getRequestDispatcher("board/qnaboard_write.jsp");
		disp.forward(request, response);
	}

}
