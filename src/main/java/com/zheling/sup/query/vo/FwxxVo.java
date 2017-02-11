package com.zheling.sup.query.vo;

import java.math.BigDecimal;
import java.util.List;

/**
 * 房屋信息视图对象
 * 
 * @author WGJ
 */
public class FwxxVo {

	private String rwid; // ID
	private String objcode; // 编号
	private String zicmc; // 资产名称
	private String danwjc; // 单位简称
	private String fwztmc; // 状态名称
	private BigDecimal mianj; // 面积
	private List<Double> position; // 经纬度

	public FwxxVo() {
		super();
	}

	public FwxxVo(String rwid, String objcode, String zicmc, String danwjc,
			String fwztmc, BigDecimal mianj, List<Double> position) {
		super();
		this.rwid = rwid;
		this.objcode = objcode;
		this.zicmc = zicmc;
		this.danwjc = danwjc;
		this.fwztmc = fwztmc;
		this.mianj = mianj;
		this.position = position;
	}

	public String getRwid() {
		return rwid;
	}

	public void setRwid(String rwid) {
		this.rwid = rwid;
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

	public String getDanwjc() {
		return danwjc;
	}

	public void setDanwjc(String danwjc) {
		this.danwjc = danwjc;
	}

	public String getFwztmc() {
		return fwztmc;
	}

	public void setFwztmc(String fwztmc) {
		this.fwztmc = fwztmc;
	}

	public BigDecimal getMianj() {
		return mianj;
	}

	public void setMianj(BigDecimal mianj) {
		this.mianj = mianj;
	}

	public List<Double> getPosition() {
		return position;
	}

	public void setPosition(List<Double> position) {
		this.position = position;
	}

}