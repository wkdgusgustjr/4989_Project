package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import service.MyBatisConnector;
import vo.BuyerVO;
import vo.LeavingMemberVO;
import vo.ProductVO;
import vo.QnABoardVO;
import vo.SellerVO;
import vo.TradingVO;

public class MasterDAO {
	private static MasterDAO single = null;
	SqlSessionFactory factory = null;
	
	public static MasterDAO getInstance() {
		if(single == null)
			single = new MasterDAO();
		return single;
	}
	
	public MasterDAO() {
		factory = MyBatisConnector.getInstance().getSqlSessionFactory();
	}
	
	
	/** --- SELLER COUNT --- */
	public int sellerCount() {
		SqlSession sqlSession = factory.openSession();
		int count = sqlSession.selectOne( "master.seller_count" );
		sqlSession.close();
		
		return count;
	}
	
	/** --- SELLER 목록 --- */
	public List<SellerVO> sellerList( Map<String, String> map ) {
		SqlSession sqlSession = factory.openSession();
		List<SellerVO> list = sqlSession.selectList( "master.seller_list", map );
		sqlSession.close();
		
		return list;
	}
	
	/****************************** 구분선 ******************************/
	
	/** --- BUYER COUNT --- */
	public int buyerCount() {
		SqlSession sqlSession = factory.openSession();
		int count = sqlSession.selectOne( "master.buyer_count" );
		sqlSession.close();
		
		return count;
	}
	
	/** --- BUYER 목록 --- */
	public List<BuyerVO> buyerList( Map<String, String> map ) {
		SqlSession sqlSession = factory.openSession();
		List<BuyerVO> list = sqlSession.selectList( "master.buyer_list", map );
		sqlSession.close();
		
		return list;
	}
	
	/****************************** 구분선 ******************************/
	
	/** --- PRODUCT COUNT --- */
	public int productCount() {
		SqlSession sqlSession = factory.openSession();
		int count = sqlSession.selectOne( "master.product_count" );
		sqlSession.close();
		
		return count;
	}
	
	/** --- PRODUCT 목록 --- */
	public List<ProductVO> productList( Map<String, String> map ) {
		SqlSession sqlSession = factory.openSession();
		List<ProductVO> list = sqlSession.selectList( "master.product_list", map );
		sqlSession.close();
		
		return list;
	}
	
	/****************************** 구분선 ******************************/

	/** --- LEAVING_MEMBER COUNT --- */
	public int leavingMemberCount() {
		SqlSession sqlSession = factory.openSession();
		int count = sqlSession.selectOne( "master.leavingMember_count" );
		sqlSession.close();
		
		return count;
	}
	
	/** --- LEAVING_MEMBER 목록 --- */
	public List<LeavingMemberVO> leavingMemberList( Map<String, String> map ) {
		SqlSession sqlSession = factory.openSession();
		List<LeavingMemberVO> list = sqlSession.selectList( "master.leavingMember_list", map );
		sqlSession.close();
		
		return list;
	}


}



