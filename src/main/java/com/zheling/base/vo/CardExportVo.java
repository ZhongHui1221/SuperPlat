package com.zheling.base.vo;

import java.math.BigDecimal;

/**
 * 卡片导出值对象
 * 
 * @author WGJ
 */
public class CardExportVo {

	private String isrz; // 登账状态
	private String objcode; // 资产编号
	private String yuanzcbh; // 原资产编号
	private String zicmc; // 资产名称
	private String zicdl;// 资产大类
	private String zicfl;// 资产分类
	private String gouzrq; // 购置日期
	private String caiwrzrq; // 财务入账日期
	private BigDecimal danj; // 单价
	private BigDecimal shul; // 数量
	private String jildw; // 计量单位
	private BigDecimal jiaz; // 价值
	private BigDecimal caizbtsr;// 财政补助收入
	private BigDecimal kejxmsr;// 科教项目收入
	private BigDecimal qitsr;// 其他收入
	private BigDecimal zhejnx;// 折旧年限
	private BigDecimal leijzj;// 累计折旧
	private BigDecimal jingz;// 净值
	private String jiazlx;// 价值类型
	private String kuaijpzh; // 会计凭证号
	private String faph;// 发票号
	private String qudfs; // 取得方式
	private String yongt;// 用途
	private String guanlbm; // 管理部门
	private String shiybm; // 使用部门
	private String shiyr; // 使用人
	private String shiyzk; // 使用状况
	private String cunfdd; // 存放地点
	private String guigxh; // 规格型号
	private String pinp; // 品牌
	private String yul1;// 预留字段1
	private String yul2;// 预留字段2
	private String yul3;// 预留字段3
	private String jingxs;// 供应商
	private String jingxsdh;// 联系电话
	private String caigzzxs;// 采购形式
	private String toursyrq;// 投入使用日期
	private String zuolwz;// 坐落位置
	private String jungrq;// 竣工日期
	private String chanqxs;// 产权形式
	private String quanszm;// 权属证明
	private String quanszh;// 权属证号
	private String quansxz;// 权属性质
	private String quansnx;// 权属年限
	private String shejyt;// 设计用途
	private String jianzjg;// 建筑结构
	private String tudsyqr;// 房屋所有权人
	private BigDecimal ziymj;// 自用面积
	private BigDecimal chujmj;// 出借面积
	private BigDecimal chuzmj;// 出租面积
	private BigDecimal duiwtzmj;// 对外投资面积
	private BigDecimal qitmj;// 其他面积
	private BigDecimal ziyjz;// 自用价值
	private BigDecimal chujjz;// 出借价值
	private BigDecimal chuzjz;// 出租价值
	private BigDecimal duiwtzjz;// 对外投资价值
	private BigDecimal qitjz;// 其他价值
	private String licencedate;// 发证日期
	private String bianzqk;// 编制情况
	private String yongtfl;// 车辆用途分类
	private String chelcd;// 车辆产地
	private String cheph;// 车牌号
	private String fadjh;// 发动机号
	private BigDecimal paiql;// 排气量
	private String haopzl;// 号牌种类
	private String chelxszzcrq;// 行驶证注册日期
	private String hetbh;// 采购合同编号
	private String dilyt;// 地类(用途)
	private String zhengsh;// 证书号
	private String shengccj;// 生产厂家
	private String chubs;// 出版社
	private String chubrq;// 出版日期
	private String dangah;// 档案号
	private String chuszznf;// 出生/栽种年份
	private String gangsk;// 纲属科
	private String laiyd;// 产地
	private BigDecimal yujsmzl;// 预计使用年限/寿命/种龄
	private String sdaibf;// 是否待报废
	private String beiz; // 备注

	public String getZicdl() {
		return zicdl;
	}

	public void setZicdl(String zicdl) {
		this.zicdl = zicdl;
	}

	public String getZicfl() {
		return zicfl;
	}

	public void setZicfl(String zicfl) {
		this.zicfl = zicfl;
	}

	public BigDecimal getCaizbtsr() {
		return caizbtsr;
	}

	public void setCaizbtsr(BigDecimal caizbtsr) {
		this.caizbtsr = caizbtsr;
	}

	public BigDecimal getKejxmsr() {
		return kejxmsr;
	}

	public void setKejxmsr(BigDecimal kejxmsr) {
		this.kejxmsr = kejxmsr;
	}

	public BigDecimal getQitsr() {
		return qitsr;
	}

	public void setQitsr(BigDecimal qitsr) {
		this.qitsr = qitsr;
	}

	public BigDecimal getZhejnx() {
		return zhejnx;
	}

	public void setZhejnx(BigDecimal zhejnx) {
		this.zhejnx = zhejnx;
	}

	public BigDecimal getLeijzj() {
		return leijzj;
	}

	public void setLeijzj(BigDecimal leijzj) {
		this.leijzj = leijzj;
	}

	public BigDecimal getJingz() {
		return jingz;
	}

	public void setJingz(BigDecimal jingz) {
		this.jingz = jingz;
	}

	public String getJiazlx() {
		return jiazlx;
	}

	public void setJiazlx(String jiazlx) {
		this.jiazlx = jiazlx;
	}

	public String getFaph() {
		return faph;
	}

	public void setFaph(String faph) {
		this.faph = faph;
	}

	public String getYongt() {
		return yongt;
	}

	public void setYongt(String yongt) {
		this.yongt = yongt;
	}

	public String getYul1() {
		return yul1;
	}

	public void setYul1(String yul1) {
		this.yul1 = yul1;
	}

	public String getYul2() {
		return yul2;
	}

	public void setYul2(String yul2) {
		this.yul2 = yul2;
	}

	public String getYul3() {
		return yul3;
	}

	public void setYul3(String yul3) {
		this.yul3 = yul3;
	}

	public String getJingxs() {
		return jingxs;
	}

	public void setJingxs(String jingxs) {
		this.jingxs = jingxs;
	}

	public String getJingxsdh() {
		return jingxsdh;
	}

	public void setJingxsdh(String jingxsdh) {
		this.jingxsdh = jingxsdh;
	}

	public String getCaigzzxs() {
		return caigzzxs;
	}

	public void setCaigzzxs(String caigzzxs) {
		this.caigzzxs = caigzzxs;
	}

	public String getToursyrq() {
		return toursyrq;
	}

	public void setToursyrq(String toursyrq) {
		this.toursyrq = toursyrq;
	}

	public String getZuolwz() {
		return zuolwz;
	}

	public void setZuolwz(String zuolwz) {
		this.zuolwz = zuolwz;
	}

	public String getJungrq() {
		return jungrq;
	}

	public void setJungrq(String jungrq) {
		this.jungrq = jungrq;
	}

	public String getChanqxs() {
		return chanqxs;
	}

	public void setChanqxs(String chanqxs) {
		this.chanqxs = chanqxs;
	}

	public String getQuanszm() {
		return quanszm;
	}

	public void setQuanszm(String quanszm) {
		this.quanszm = quanszm;
	}

	public String getQuanszh() {
		return quanszh;
	}

	public void setQuanszh(String quanszh) {
		this.quanszh = quanszh;
	}

	public String getQuansxz() {
		return quansxz;
	}

	public void setQuansxz(String quansxz) {
		this.quansxz = quansxz;
	}

	public String getQuansnx() {
		return quansnx;
	}

	public void setQuansnx(String quansnx) {
		this.quansnx = quansnx;
	}

	public String getShejyt() {
		return shejyt;
	}

	public void setShejyt(String shejyt) {
		this.shejyt = shejyt;
	}

	public String getJianzjg() {
		return jianzjg;
	}

	public void setJianzjg(String jianzjg) {
		this.jianzjg = jianzjg;
	}

	public String getTudsyqr() {
		return tudsyqr;
	}

	public void setTudsyqr(String tudsyqr) {
		this.tudsyqr = tudsyqr;
	}

	public BigDecimal getZiymj() {
		return ziymj;
	}

	public void setZiymj(BigDecimal ziymj) {
		this.ziymj = ziymj;
	}

	public BigDecimal getChujmj() {
		return chujmj;
	}

	public void setChujmj(BigDecimal chujmj) {
		this.chujmj = chujmj;
	}

	public BigDecimal getChuzmj() {
		return chuzmj;
	}

	public void setChuzmj(BigDecimal chuzmj) {
		this.chuzmj = chuzmj;
	}

	public BigDecimal getDuiwtzmj() {
		return duiwtzmj;
	}

	public void setDuiwtzmj(BigDecimal duiwtzmj) {
		this.duiwtzmj = duiwtzmj;
	}

	public BigDecimal getQitmj() {
		return qitmj;
	}

	public void setQitmj(BigDecimal qitmj) {
		this.qitmj = qitmj;
	}

	public BigDecimal getZiyjz() {
		return ziyjz;
	}

	public void setZiyjz(BigDecimal ziyjz) {
		this.ziyjz = ziyjz;
	}

	public BigDecimal getChujjz() {
		return chujjz;
	}

	public void setChujjz(BigDecimal chujjz) {
		this.chujjz = chujjz;
	}

	public BigDecimal getChuzjz() {
		return chuzjz;
	}

	public void setChuzjz(BigDecimal chuzjz) {
		this.chuzjz = chuzjz;
	}

	public BigDecimal getDuiwtzjz() {
		return duiwtzjz;
	}

	public void setDuiwtzjz(BigDecimal duiwtzjz) {
		this.duiwtzjz = duiwtzjz;
	}

	public BigDecimal getQitjz() {
		return qitjz;
	}

	public void setQitjz(BigDecimal qitjz) {
		this.qitjz = qitjz;
	}

	public String getLicencedate() {
		return licencedate;
	}

	public void setLicencedate(String licencedate) {
		this.licencedate = licencedate;
	}

	public String getBianzqk() {
		return bianzqk;
	}

	public void setBianzqk(String bianzqk) {
		this.bianzqk = bianzqk;
	}

	public String getYongtfl() {
		return yongtfl;
	}

	public void setYongtfl(String yongtfl) {
		this.yongtfl = yongtfl;
	}

	public String getChelcd() {
		return chelcd;
	}

	public void setChelcd(String chelcd) {
		this.chelcd = chelcd;
	}

	public String getCheph() {
		return cheph;
	}

	public void setCheph(String cheph) {
		this.cheph = cheph;
	}

	public String getFadjh() {
		return fadjh;
	}

	public void setFadjh(String fadjh) {
		this.fadjh = fadjh;
	}

	public BigDecimal getPaiql() {
		return paiql;
	}

	public void setPaiql(BigDecimal paiql) {
		this.paiql = paiql;
	}

	public String getHaopzl() {
		return haopzl;
	}

	public void setHaopzl(String haopzl) {
		this.haopzl = haopzl;
	}

	public String getChelxszzcrq() {
		return chelxszzcrq;
	}

	public void setChelxszzcrq(String chelxszzcrq) {
		this.chelxszzcrq = chelxszzcrq;
	}

	public String getHetbh() {
		return hetbh;
	}

	public void setHetbh(String hetbh) {
		this.hetbh = hetbh;
	}

	public String getDilyt() {
		return dilyt;
	}

	public void setDilyt(String dilyt) {
		this.dilyt = dilyt;
	}

	public String getZhengsh() {
		return zhengsh;
	}

	public void setZhengsh(String zhengsh) {
		this.zhengsh = zhengsh;
	}

	public String getShengccj() {
		return shengccj;
	}

	public void setShengccj(String shengccj) {
		this.shengccj = shengccj;
	}

	public String getChubs() {
		return chubs;
	}

	public void setChubs(String chubs) {
		this.chubs = chubs;
	}

	public String getChubrq() {
		return chubrq;
	}

	public void setChubrq(String chubrq) {
		this.chubrq = chubrq;
	}

	public String getDangah() {
		return dangah;
	}

	public void setDangah(String dangah) {
		this.dangah = dangah;
	}

	public String getChuszznf() {
		return chuszznf;
	}

	public void setChuszznf(String chuszznf) {
		this.chuszznf = chuszznf;
	}

	public String getGangsk() {
		return gangsk;
	}

	public void setGangsk(String gangsk) {
		this.gangsk = gangsk;
	}

	public String getLaiyd() {
		return laiyd;
	}

	public void setLaiyd(String laiyd) {
		this.laiyd = laiyd;
	}

	public BigDecimal getYujsmzl() {
		return yujsmzl;
	}

	public void setYujsmzl(BigDecimal yujsmzl) {
		this.yujsmzl = yujsmzl;
	}

	public String getSdaibf() {
		return sdaibf;
	}

	public void setSdaibf(String sdaibf) {
		this.sdaibf = sdaibf;
	}

	public String getIsrz() {
		return isrz;
	}

	public void setIsrz(String isrz) {
		this.isrz = isrz;
	}

	public String getObjcode() {
		return objcode;
	}

	public void setObjcode(String objcode) {
		this.objcode = objcode;
	}

	public String getYuanzcbh() {
		return yuanzcbh;
	}

	public void setYuanzcbh(String yuanzcbh) {
		this.yuanzcbh = yuanzcbh;
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

	public BigDecimal getDanj() {
		return danj;
	}

	public void setDanj(BigDecimal danj) {
		this.danj = danj;
	}

	public BigDecimal getShul() {
		return shul;
	}

	public void setShul(BigDecimal shul) {
		this.shul = shul;
	}

	public String getJildw() {
		return jildw;
	}

	public void setJildw(String jildw) {
		this.jildw = jildw;
	}

	public BigDecimal getJiaz() {
		return jiaz;
	}

	public void setJiaz(BigDecimal jiaz) {
		this.jiaz = jiaz;
	}

	public String getKuaijpzh() {
		return kuaijpzh;
	}

	public void setKuaijpzh(String kuaijpzh) {
		this.kuaijpzh = kuaijpzh;
	}

	public String getQudfs() {
		return qudfs;
	}

	public void setQudfs(String qudfs) {
		this.qudfs = qudfs;
	}

	public String getGuanlbm() {
		return guanlbm;
	}

	public void setGuanlbm(String guanlbm) {
		this.guanlbm = guanlbm;
	}

	public String getShiybm() {
		return shiybm;
	}

	public void setShiybm(String shiybm) {
		this.shiybm = shiybm;
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

	public String getPinp() {
		return pinp;
	}

	public void setPinp(String pinp) {
		this.pinp = pinp;
	}

	public String getBeiz() {
		return beiz;
	}

	public void setBeiz(String beiz) {
		this.beiz = beiz;
	}

}