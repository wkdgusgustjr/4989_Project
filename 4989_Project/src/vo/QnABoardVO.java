package vo;

public class QnABoardVO {
	private int qna_idx;				// QnA 게시판 고유번호
	private String qna_answertype;		// QnA 게시판 타입(질문분류)
	private String qna_publictype;		// QnA 게시판 타입(공개/비공개)
	private String qna_title;			// QnA 게시판 게시글 제목
	private String qna_register;		// QnA 게시판 게시글 작성자
	private String qna_text;			// QnA 게시판 게시글 내용
	private String qna_pwd;				// QnA 게시판 게시글 비밀번호
	private int qna_views;				// QnA 게시판 게시글 조회수
	private String qna_regidate;		// QnA 게시판 게시글 등록일
	private String qna_status;			// QnA 게시판  답변 여부
	private int qna_parent;				// QnA 게시판 부모 글 번호
	
	public QnABoardVO() {}
	
	
	public int getQna_idx() {
		return qna_idx;
	}

	public void setQna_idx(int qna_idx) {
		this.qna_idx = qna_idx;
	}

	public String getQna_answertype() {
		return qna_answertype;
	}

	public void setQna_answertype(String qna_answertype) {
		this.qna_answertype = qna_answertype;
	}

	public String getQna_publictype() {
		return qna_publictype;
	}

	public void setQna_publictype(String qna_publictype) {
		this.qna_publictype = qna_publictype;
	}

	public String getQna_register() {
		return qna_register;
	}

	public void setQna_register(String qna_register) {
		this.qna_register = qna_register;
	}

	public String getQna_text() {
		return qna_text;
	}

	public void setQna_text(String qna_text) {
		this.qna_text = qna_text;
	}

	public String getQna_pwd() {
		return qna_pwd;
	}

	public void setQna_pwd(String qna_pwd) {
		this.qna_pwd = qna_pwd;
	}

	public int getQna_views() {
		return qna_views;
	}

	public void setQna_views(int qna_views) {
		this.qna_views = qna_views;
	}

	public String getQna_regidate() {
		return qna_regidate;
	}

	public void setQna_regidate(String qna_regidate) {
		this.qna_regidate = qna_regidate;
	}

	public String getQna_status() {
		return qna_status;
	}

	public void setQna_status(String qna_status) {
		this.qna_status = qna_status;
	}

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public int getQna_parent() {
		return qna_parent;
	}

	public void setQna_parent(int qna_parent) {
		this.qna_parent = qna_parent;
	}

}

