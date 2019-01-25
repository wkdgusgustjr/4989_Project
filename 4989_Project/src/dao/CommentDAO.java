package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import service.MyBatisConnector;
import vo.CommentVO;
import vo.QnABoardVO;

public class CommentDAO {
private static CommentDAO single = null;
	
	public static CommentDAO getInstance() {
		if(single == null)
			single = new CommentDAO();
		return single;
	}
	
	SqlSessionFactory factory = null;
	
	public CommentDAO() {
		factory = MyBatisConnector.getInstance().getSqlSessionFactory();
	}
	
	/** --- 클릭한 게시글 번호로 모든 댓글 불러오기 --- */
	public List<CommentVO> select_AllComment( int qna_idx ) {
		List<CommentVO> list = null;
		
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList( "comment.comment_commentAll", qna_idx );
		sqlSession.close();
		
		return list;
	}
	
	/** --- 댓글 등록 --- */
	public void insert_Comment( CommentVO vo ) {
		SqlSession sqlSession = factory.openSession();
		sqlSession.insert( "comment.comment_insert", vo );
		sqlSession.commit();
		sqlSession.close();
		
	}
	
	/** --- 댓글 삭제 --- */
	public void delete_Comment( int com_idx ) {
		SqlSession sqlSession = factory.openSession();
		sqlSession.delete("comment.comment_delete", com_idx);
		sqlSession.commit();
		sqlSession.close();
		
	}
////-----------------------------------------------댓글 수정---------------------------------------------------
	public void update_Comment(CommentVO comment) {
		SqlSession sqlSession = factory.openSession();
		
		sqlSession.update("comment.comment_update", comment );
		
		sqlSession.commit();
		sqlSession.close();
		
	}
////-----------------------------------------------댓글 내용 불러오기---------------------------------------------------
	public CommentVO select_One ( int com_idx ) {
		
		CommentVO vo = null;
		SqlSession sqlSession = factory.openSession();
		vo = sqlSession.selectOne( "comment.comment_one", com_idx );
		sqlSession.close();
		
		return vo;
	}

	/**--- 게시글을 삭제하면 해당 게시글에 달린 댓글 전부 삭제 ---*/
	public void comment_delete_in_qnaBoard( int qna_idx ) {
		SqlSession sqlSession = factory.openSession();
		// BOARD_COMMENT 테이블에서 해당 게시글에 달린 댓글 전부 삭제
		sqlSession.delete( "comment.comment_delete_in_qnaBoard", qna_idx );
		sqlSession.commit();
		sqlSession.close();
	}
} // class 끝

