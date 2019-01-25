package vo;

public class CommentVO {
	private int			com_idx;			// 댓글(comment)의 고유번호, key
	private int			qna_idx;			// 댓글을 달 원글의 글번호, (QnABOARD 테이블의 글번호(fb_idx)) 
	private String		com_text;			// 댓글 내용
	private String 		com_register;		// 댓글 작성자(현재 로그인한 sessionScope.memberID 값)
	private String 		com_regidate;		// 댓글 작성일

	public CommentVO() {
		
	}

	public int getCom_idx() {
		return com_idx;
	}

	public void setCom_idx(int com_idx) {
		this.com_idx = com_idx;
	}

	public int getQna_idx() {
		return qna_idx;
	}

	public void setQna_idx(int qna_idx) {
		this.qna_idx = qna_idx;
	}

	public String getCom_text() {
		return com_text;
	}

	public void setCom_text(String com_text) {
		this.com_text = com_text;
	}

	public String getCom_register() {
		return com_register;
	}

	public void setCom_register(String com_register) {
		this.com_register = com_register;
	}

	public String getCom_regidate() {
		return com_regidate;
	}

	public void setCom_regidate(String com_regidate) {
		this.com_regidate = com_regidate;
	}


	
}

