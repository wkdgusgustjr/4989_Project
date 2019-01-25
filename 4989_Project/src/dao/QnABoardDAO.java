package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import service.MyBatisConnector;
import vo.QnABoardVO;

public class QnABoardDAO {
private static QnABoardDAO single = null;
	
	public static QnABoardDAO getInstance() {
		if(single == null)
			single = new QnABoardDAO();
		return single;
	}
	
	SqlSessionFactory factory = null;
	
	public QnABoardDAO() {
		factory = MyBatisConnector.getInstance().getSqlSessionFactory();
	}
	
	/** --- 게시글 등록 --- */
	public void insert_Board( QnABoardVO board ) {
		SqlSession sqlSession = factory.openSession();
		sqlSession.insert( "qnaboard.qnaboard_insert", board );
		sqlSession.commit();
		sqlSession.close();
		
	}
	
	/**--- 게시물 검색 ---*/
	 public List<QnABoardVO> select_Search_Board ( Map<String, String> map ) {
		List<QnABoardVO> list = null;
		
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList( "qnaboard.qnaboard_list", map );
		sqlSession.close();
		
		return list;
	}
	
	/** --- 게시물 상세보기 + 조회수 증가 --- */
	public QnABoardVO select_One ( int qna_idx ) {
		QnABoardVO vo = null;
		SqlSession sqlSession = factory.openSession();
		
		// 게시물 상세 vo에 담고
		vo = sqlSession.selectOne( "qnaboard.qnaboard_selectOne", qna_idx );
		
		// 조회수 증가
		sqlSession.update( "qnaboard.qnaboard_views", qna_idx );
		
		sqlSession.commit();
		sqlSession.close();
		
		return vo;
	}

	/**--- 게시글 삭제 ---*/
	public void delete_qnaBoard ( int qna_idx ) {
		SqlSession sqlSession = factory.openSession();
		
		// QNABOARD 테이블에서 해당 게시글 ROW 삭제
		sqlSession.delete( "qnaboard.qnaboard_delete", qna_idx );
		sqlSession.commit();
		sqlSession.close();
	}
	
	/**--- 게시글 수정 ---*/
	public void update_Board ( QnABoardVO vo ) {
		SqlSession sqlSession = factory.openSession();
		sqlSession.update("qnaboard.qnaboard_update", vo );
		sqlSession.commit();
		sqlSession.close();
		
	}
	
	/**------------------------ 게시물 갯수 구하기 ------------------------*/
	public int selectCount() {
		SqlSession sqlSession = factory.openSession();
		int count = (int)sqlSession.selectOne("qnaboard_count");
		sqlSession.close();
		return count;
	}
	
	// 오버로딩된 select 메서드
	public List<QnABoardVO> select(HashMap<String, String> map) {
		List<QnABoardVO> list = null;
		
		SqlSession sqlSession = factory.openSession();
		
		list = sqlSession.selectList("qnaboard.qnaboard_list_page", map);
		sqlSession.close();
		
		
		return list;
	}


}

