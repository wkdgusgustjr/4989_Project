package action.product;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.ProductDAO;
import vo.ProductVO;

@WebServlet("/product_update_output.do")
public class Product_Update_Output_Action extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		String path = request.getServletContext().getRealPath("/productimages/");
		// System.out.println( "파일이 업로드 될 경로 : " + path );
		
		int max_size = 1024 * 1024 * 100;
		
		MultipartRequest mr =
				new MultipartRequest( request, // request 객체
									     path, // 저장될 경로
								     max_size, // 파일 최대 사이즈
								      "utf-8", // 인코딩 방식
			  new DefaultFileRenamePolicy() ); // 파일명 어떻게할것인지 정책
						
		// 변경될 이미지파일 변수들의 초기값을, 파라미터에서 받아온 현재 이미지파일의 파일명으로 초기화한다.
		String change_p_image_s = mr.getParameter("p_image_s");
		String change_p_image_1 = mr.getParameter("p_image_1");
		String change_p_image_2 = mr.getParameter("p_image_2");
		String change_p_image_3 = mr.getParameter("p_image_3");
		String change_p_image_4 = mr.getParameter("p_image_4");
		
		// 업로드된 이미지파일이 있다면, 변경될 이미지파일의 변수값을 업로드된 파일명으로 바꾼다.
		// 파일이 없으면 현재 이미지파일명 그대로 둔다.
		File f = mr.getFile("change_p_image_s");
		if ( f != null )
			change_p_image_s = f.getName();
		
		f = mr.getFile("change_p_image_1");
		if ( f != null )
			change_p_image_1 = f.getName();
		
		f = mr.getFile("change_p_image_2");
		if ( f != null )
			change_p_image_2 = f.getName();	
		
		// 3번째 4번째 이미지파일은 상품 등록시 필수첨부가 아님.
		// 상품수정 할 때에도 파일을 첨부하지 않았으면 null값으로 넘어오기때문에
		// 변수값을 "no_file"로 지정해준다.
		f = mr.getFile("change_p_image_3");
		if ( f != null ) {
			change_p_image_3 = f.getName();
		} else {
			change_p_image_3 = "no_file";
		}
		
		f = mr.getFile("change_p_image_4");
		if ( f != null ) {
			change_p_image_4 = f.getName();
		} else {
			change_p_image_4 = "no_file";
		}
		
		// 파일 외의 파라미터 (제조회사, 모델명은 어차피 수정불가능하므로 받지 않음)
		int 		p_idx = Integer.parseInt( mr.getParameter("p_idx") ); // 상품번호
		int 	  p_price = Integer.parseInt(mr.getParameter("p_price")); // 희망매입가
		String     p_text = mr.getParameter("p_text");					  // 내용
		
		// VO에 저장
		ProductVO vo = new ProductVO();
		vo.setP_idx (p_idx);
		vo.setP_price (p_price);
		vo.setP_text (p_text);
		vo.setP_image_s (change_p_image_s);
		vo.setP_image_1 (change_p_image_1);
		vo.setP_image_2 (change_p_image_2);
		vo.setP_image_3 (change_p_image_3);
		vo.setP_image_4 (change_p_image_4);
		
		// DB에서 update
		ProductDAO.getInstance().updateProduct( vo );
		
		// 추가한 제품의 카테고리 리스트로 페이지 리다이렉트 (추가된것 목록에서 바로 확인 가능)
		response.sendRedirect("product_list_input.do");

	}

}
