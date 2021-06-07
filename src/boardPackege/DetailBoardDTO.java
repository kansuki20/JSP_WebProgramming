package boardPackege;

public class DetailBoardDTO {
	private String memberId;
	private String regtime;
	private String content;
	private String productName;
	private String productImageLink;
	
	public DetailBoardDTO() {}
	public DetailBoardDTO(String memberId, String regtime, String content, String productName,
			String productImageLink) {
		super();
		this.memberId = memberId;
		this.regtime = regtime;
		this.content = content;
		this.productName = productName;
		this.productImageLink = productImageLink;
	}
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getRegtime() {
		return regtime;
	}
	public void setRegtime(String regtime) {
		this.regtime = regtime;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductImageLink() {
		return productImageLink;
	}
	public void setProductImageLink(String productImageLink) {
		this.productImageLink = productImageLink;
	}
}
