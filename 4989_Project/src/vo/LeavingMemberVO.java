package vo;

public class LeavingMemberVO {
	private int leaving_idx; 	   // 탈퇴한회원 고유번호		
	private int leaving_ages;	   // 탈퇴한회원 연령대
	private String leaving_reason; // 탈퇴한회원 탈퇴사유
	private String leaving_date;   // 탈퇴한회원 탈퇴일시
	private String leaving_id;	   // 탈퇴한회원 아이디
	
	public LeavingMemberVO() {
		
	}

	public int getLeaving_idx() {
		return leaving_idx;
	}

	public void setLeaving_idx(int leaving_idx) {
		this.leaving_idx = leaving_idx;
	}

	public int getLeaving_ages() {
		return leaving_ages;
	}

	public void setLeaving_ages(int leaving_ages) {
		this.leaving_ages = leaving_ages;
	}

	public String getLeaving_reason() {
		return leaving_reason;
	}

	public void setLeaving_reason(String leaving_reason) {
		this.leaving_reason = leaving_reason;
	}

	public String getLeaving_date() {
		return leaving_date;
	}

	public void setLeaving_date(String leaving_date) {
		this.leaving_date = leaving_date;
	}

	public String getLeaving_id() {
		return leaving_id;
	}

	public void setLeaving_id(String leaving_id) {
		this.leaving_id = leaving_id;
	}
	
	
	
}
