package com.zheling.sup.query.vo;

/**
 * 使用状况视图对象
 * 
 * @author WGJ
 */
public class SyzkVo {

	private String id;
	private String cnt;
	private String syzk;
	private String price;
	private String num;

	public SyzkVo() {
		super();
	}

	public SyzkVo(String syzk, String price, String num) {
		super();
		this.syzk = syzk;
		this.price = price;
		this.num = num;
	}

	public SyzkVo(String id, String cnt, String syzk, String price, String num) {
		super();
		this.id = id;
		this.cnt = cnt;
		this.syzk = syzk;
		this.price = price;
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	public String getSyzk() {
		return syzk;
	}

	public void setSyzk(String syzk) {
		this.syzk = syzk;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

}