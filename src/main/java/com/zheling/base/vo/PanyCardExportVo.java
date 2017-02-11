package com.zheling.base.vo;

import java.math.BigDecimal;

/**
 * 盘盈卡片导出值对象
 * 
 * @author hugo
 */
public class PanyCardExportVo extends PdExportVo {

	private String qcjzr;// 盘点基准日
	private String createtime;// 发现日期
	private String zicmc; // 资产名称
	private String zicfl;// 资产分类
	private BigDecimal pandsl;// 数量
	private String jildw; // 计量单位
	private String cunfdd; // 存放地点
	private String beiz; // 盈利说明
	private String shenbr;// 申报人
	private String isyans;// 生成验收表单

	public String getIsyans() {
		return isyans;
	}

	public void setIsyans(String isyans) {
		this.isyans = isyans;
	}

	public String getQcjzr() {
		return qcjzr;
	}

	public void setQcjzr(String qcjzr) {
		this.qcjzr = qcjzr;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getZicfl() {
		return zicfl;
	}

	public void setZicfl(String zicfl) {
		this.zicfl = zicfl;
	}

	public String getJildw() {
		return jildw;
	}

	public void setJildw(String jildw) {
		this.jildw = jildw;
	}

	public String getBeiz() {
		return beiz;
	}

	public void setBeiz(String beiz) {
		this.beiz = beiz;
	}

	public String getShenbr() {
		return shenbr;
	}

	public void setShenbr(String shenbr) {
		this.shenbr = shenbr;
	}

	public BigDecimal getPandsl() {
		return pandsl;
	}

	public void setPandsl(BigDecimal pandsl) {
		this.pandsl = pandsl;
	}

	public String getZicmc() {
		return zicmc;
	}

	public void setZicmc(String zicmc) {
		this.zicmc = zicmc;
	}

	public String getCunfdd() {
		return cunfdd;
	}

	public void setCunfdd(String cunfdd) {
		this.cunfdd = cunfdd;
	}

}