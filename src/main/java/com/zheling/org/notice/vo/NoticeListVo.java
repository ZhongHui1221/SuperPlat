package com.zheling.org.notice.vo;

/**
 * 公告列表值对象
 * 
 * @author WGJ
 */
public class NoticeListVo {

	private String id;
	private String title;
	private String author;
	private String createDate;
	private String expiryDate;

	public NoticeListVo() {
		super();
	}

	public NoticeListVo(String id, String title, String author, String createDate, String expiryDate) {
		super();
		this.id = id;
		this.title = title;
		this.author = author;
		this.createDate = createDate;
		this.expiryDate = expiryDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}

}