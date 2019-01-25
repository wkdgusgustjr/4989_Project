package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import service.MyBatisConnector;
import vo.TradingVO;

public class TradingDAO {
	private static TradingDAO single = null;
	SqlSessionFactory factory = null;
	
	public static TradingDAO getInstance() {
		if(single == null)
			single = new TradingDAO();
		return single;
	}
	
	public TradingDAO() {
		factory = MyBatisConnector.getInstance().getSqlSessionFactory();
	}
	
	/** ----------------------- 클릭한 제조회사 모델 리스트 조회 (완성) ----------------------- */
	public List<TradingVO> select ( int idx ) {
		List<TradingVO> list = null;
		
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList( "trading.p_listall2", idx );
		sqlSession.close();
		
		return list;
	}
	
	/** --- 매입신청 --- */
	public void insertTrading ( TradingVO vo ) {
		SqlSession sqlSession = factory.openSession();
		sqlSession.insert( "trading.insertTrading", vo );
		sqlSession.commit();
		sqlSession.close();
	}

	/** --- 상품번호로 제품 현재 클릭한상품의 매입자 리스트 획득 --- */
	public List<TradingVO> setectBuyerAll ( int p_idx ) {
		List<TradingVO> list = null;
		
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList( "trading.selectBuyerAll", p_idx );
		sqlSession.close();
		
		return list;
	}
	
	/**--- 판매자가 입금요청 버튼누르면 TRADING 테이블의 현재 거래의 상태를 '입금대기'로 변경 ---*/
	public void depositWaiting ( TradingVO vo ) {
		SqlSession sqlSession = factory.openSession();
		sqlSession.update( "trading.depositwaiting", vo );
		sqlSession.commit();
		sqlSession.close();
	}
	
	/**--- 거래가 성사되지 못한 나머지 매입자들의 상태를 '미체결' 로 변경 ---*/
	public void dealFail ( TradingVO vo ) {
		SqlSession sqlSession = factory.openSession();
		sqlSession.update( "trading.dealFail", vo );
		sqlSession.commit();
		sqlSession.close();
	}

	/** --- TRADING 테이블에서 해당 거래의 상태를 '완료' 로 변경 --- */
	public void dealComplete ( Map<String, Object> map ) {
		SqlSession sqlSession = factory.openSession();
		sqlSession.update( "trading.dealComplete", map );
		sqlSession.commit();
		sqlSession.close();
	}
	
	/** --- [Seller] '입금대기', '대기' 인 거래 건의 모든정보 --- */
	public List<TradingVO> seller_transactionProgress ( String seller_id ) {
		List<TradingVO> vo = null;
		
		SqlSession sqlSession = factory.openSession();
		HashMap<String,String> map = new HashMap<>();
		map.put("seller_id", seller_id);
		map.put("w1", "입금대기");
		map.put("w2", "대기");
		
		vo = sqlSession.selectList( "trading.seller_history", map );
		sqlSession.close();
		
		return vo;
	}
	
	/** --- [Buyer] '입금대기', '대기' 인 거래 건의 모든정보 --- */
	public List<TradingVO> buyer_transactionProgress ( String buyer_id ) {
		List<TradingVO> vo = null;
		
		SqlSession sqlSession = factory.openSession();
		HashMap<String,String> map = new HashMap<>();
		map.put("buyer_id", buyer_id);
		map.put("w1", "입금대기");
		map.put("w2", "대기");
		map.put("w3", "대기");
		
		vo = sqlSession.selectList( "trading.buyer_history", map );
		sqlSession.close();
		
		return vo;
	}
	
	/** --- [Seller] '완료' 인 거래 건의 모든정보 --- */
	public List<TradingVO> seller_dealHistory ( String seller_id ) {
		List<TradingVO> vo = null;
		
		SqlSession sqlSession = factory.openSession();
		HashMap<String,String> map = new HashMap<>();
		map.put("seller_id", seller_id);
		map.put("w1", "완료");
		map.put("w2", "완료");
		
		vo = sqlSession.selectList( "trading.seller_history", map );
		sqlSession.close();
		
		return vo;
	}
	
	/** --- [Buyer] '완료', '미체결', '삭제됨' 인 거래 건의 모든정보 --- */
	public List<TradingVO> buyer_dealHistory ( String buyer_id ) {
		List<TradingVO> vo = null;
		
		SqlSession sqlSession = factory.openSession();
		HashMap<String,String> map = new HashMap<>();
		map.put("buyer_id", buyer_id);
		map.put("w1", "완료");
		map.put("w2", "미체결");
		map.put("w3", "삭제됨");
		
		vo = sqlSession.selectList( "trading.buyer_history", map );
		sqlSession.close();
		
		return vo;
	}

	/** --- [Buyer] 거래진행상황 -> 매입취소버튼 누르면 TRADING 테이블에서 해당 row 삭제 --- */
	public void dealCancel( Map<String, Object> map ) {
		SqlSession sqlSession = factory.openSession();
		sqlSession.delete( "trading.dealCancel", map );
		sqlSession.commit();
		sqlSession.close();
	}
	
}
