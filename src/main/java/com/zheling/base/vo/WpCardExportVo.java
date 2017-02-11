package com.zheling.base.vo;

import java.math.BigDecimal;

/**
 * 未盘卡片导出值对象
 * 
 * @author hugo
 */
public class WpCardExportVo extends PdExportVo {

	private String objcode; // 资产编号
	private String zicmc; // 资产名称
	private String guigxh; // 规格型号
	private BigDecimal shul; // 数量
	private BigDecimal pandsl;// 盘点数量
	private BigDecimal jiaz; // 价值
	private String cunfdd; // 存放地点
	private String caiwrzrq; // 财务入账日期
	private String gouzrq; // 购置日期
	private String shiyzk; // 使用状况
	private String pandr;// 盘点人
	private String shiyr; // 使用人

	public BigDecimal getPandsl() {
		return pandsl;
	}

	public void setPandsl(BigDecimal pandsl) {
		this.pandsl = pandsl;
	}

	public String getPandr() {
		return pandr;
	}

	public void setPandr(String pandr) {
		this.pandr = pandr;
	}

	public String getObjcode() {
		return objcode;
	}

	public void setObjcode(String objcode) {
		this.objcode = objcode;
	}

	public String getZicmc() {
		return zicmc;
	}

	public void setZicmc(String zicmc) {
		this.zicmc = zicmc;
	}

	public String getGouzrq() {
		return gouzrq;
	}

	public void setGouzrq(String gouzrq) {
		this.gouzrq = gouzrq;
	}

	public String getCaiwrzrq() {
		return caiwrzrq;
	}

	public void setCaiwrzrq(String caiwrzrq) {
		this.caiwrzrq = caiwrzrq;
	}

	public BigDecimal getShul() {
		return shul;
	}

	public void setShul(BigDecimal shul) {
		this.shul = shul;
	}

	public BigDecimal getJiaz() {
		return jiaz;
	}

	public void setJiaz(BigDecimal jiaz) {
		this.jiaz = jiaz;
	}

	public String getShiyr() {
		return shiyr;
	}

	public void setShiyr(String shiyr) {
		this.shiyr = shiyr;
	}

	public String getShiyzk() {
		return shiyzk;
	}

	public void setShiyzk(String shiyzk) {
		this.shiyzk = shiyzk;
	}

	public String getCunfdd() {
		return cunfdd;
	}

	public void setCunfdd(String cunfdd) {
		this.cunfdd = cunfdd;
	}

	public String getGuigxh() {
		return guigxh;
	}

	public void setGuigxh(String guigxh) {
		this.guigxh = guigxh;
	}

}