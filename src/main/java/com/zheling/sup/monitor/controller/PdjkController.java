package com.zheling.sup.monitor.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.zheling.base.component.GlobalComponent;
import com.zheling.base.controller.BaseController;
import com.zheling.base.entity.BdDept;
import com.zheling.base.entity.BdOrg;
import com.zheling.base.service.BdDeptService;
import com.zheling.base.service.BdOrgService;
import com.zheling.base.service.CoreUserService;
import com.zheling.base.util.Page;
import com.zheling.base.vo.DefaultCardExportVo;
import com.zheling.base.vo.PanyCardExportVo;
import com.zheling.base.vo.PdExportVo;
import com.zheling.base.vo.PkCardExportVo;
import com.zheling.base.vo.WpCardExportVo;
import com.zheling.base.vo.WykCardExportVo;
import com.zheling.sup.monitor.service.PdjkService;
import com.zheling.sup.query.service.BsAstCardService;

@Controller
@RequestMapping("/Monitor/Pdjk")
public class PdjkController extends BaseController {

	// 本模块使用独立的 PAGE_SIZE
	private static final int PAGE_SIZE = 20;

	// 单位盘点基准日游标
	private List<Object> orgPdjzrCursor;

	@Autowired
	private PdjkService pdjkService;
	@Autowired
	private BsAstCardService bsAstCardService;
	@Autowired
	private BdOrgService bdOrgService;
	@Autowired
	private BdDeptService bdDeptService;
	@Autowired
	private CoreUserService coreUserService;

	/**
	 * 单位盘点基准日查询 by WGJ
	 * 
	 * @return
	 */
	private List<Object> findQcjzr(String orgid) {
		Map<String, Object> orgPdjzrCondition = new HashMap<String, Object>();
		orgPdjzrCondition.put("orgid", orgid);
		try {
			pdjkService.findOrgPdjzr(orgPdjzrCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 查询返回的游标
		return (List<Object>) orgPdjzrCondition.get("P_DS");
	}

	@RequestMapping(value = "/main/{qcjzrStr}/{typeStr}/{orgidStr}", method = RequestMethod.GET)
	public String main(@PathVariable("qcjzrStr") String qcjzrStr,
			@PathVariable("typeStr") String typeStr, @PathVariable("orgidStr") String orgidStr,
			HttpServletRequest request) {
		/* 组装路径导航 —— BEGIN */
		// 通过主菜单访问盘点监控时
		if ("0".equals(orgidStr)) {
			orgidStr = currentUser.getCurrentOrgId();
		}

		// 路径集合
		List<Object> pathList = new ArrayList<Object>();
		String deptidStr = "";
		// 如果穿透到部门层
		if ("3".equals(typeStr)) {
			// 此时单位 ID 即是部门 ID
			deptidStr = orgidStr;
			// 获取部门信息
			BdDept dept = bdDeptService.getEntity(deptidStr);
			// 将当前部门添加至路径集合
			pathList.add(dept);
			// 重新为单位 ID 赋值
			orgidStr = dept.getOrgid();
		}

		String topOrgid = currentUser.getCurrentOrgId();
		BdOrg org = bdOrgService.getEntity(orgidStr);
		recursion(topOrgid, org, pathList);
		// 反转路径集合
		Collections.reverse(pathList);
		request.setAttribute("orgs", pathList);
		request.setAttribute("pdjkOrgid", orgidStr);
		request.setAttribute("pdjkDeptid", deptidStr);
		/* 组装路径导航 —— END */

		// 单位盘点基准日查询
		orgPdjzrCursor = findQcjzr(orgidStr);
		request.setAttribute("orgPdjzrCursor", orgPdjzrCursor);

		/* 单位盘点动态查询 —— BEGIN */
		if ("0".equals(qcjzrStr)) {
			if (orgPdjzrCursor != null && orgPdjzrCursor.size() > 0) {
				Map<String, Object> map = (Map<String, Object>) orgPdjzrCursor.get(0);
				qcjzrStr = formatDate(map.get("QINGCJZR"), "yyyy-MM-dd");
			}
		}

		// 查询条件组装
		Map<String, Object> orgPddtCondition = new HashMap<String, Object>(baseCondition);
		orgPddtCondition.put("qcjzr", (!"0".equals(qcjzrStr)) ? qcjzrStr : "");
		// 1 = 人员，2 = 部门
		orgPddtCondition.put("stattype", "2");
		// 0 = 正常查询，1 = 使用状况，2 = 使用人，3 = 使用部门，4 = 管理部门
		orgPddtCondition.put("querytype", "0");
		orgPddtCondition.put("optorgid", orgidStr);

		if ("0".equals(typeStr)) {
			orgPddtCondition.put("rwid", orgidStr);
		} else if ("3".equals(typeStr)) {
			orgPddtCondition.put("stattype", "1");
			orgPddtCondition.put("querytype", "3");
			orgPddtCondition.put("rwid", deptidStr);
		}

		try {
			pdjkService.findOrgPddt(orgPddtCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> orgPddtCursor = (List<Object>) orgPddtCondition.get("P_DS");
		if (orgPddtCursor != null) {
			Integer wykTotalCount = 0; // 无盈亏总数量
			Integer pyTotalCount = 0; // 盘盈总数量
			Integer pkTotalCount = 0; // 盘亏总数量
			Integer wpdTotalCount = 0; // 未盘点总数量
			for (Object orgPddt : orgPddtCursor) {
				Map<String, Object> map = (Map<String, Object>) orgPddt;
				wykTotalCount += Integer.valueOf(map.get("WYKSL").toString());
				pyTotalCount += Integer.valueOf(map.get("PYSL").toString());
				pkTotalCount += Integer.valueOf(map.get("PKSL").toString());
				wpdTotalCount += Integer.valueOf(map.get("WPSL").toString());
			}
			request.setAttribute("wykTotalCount", wykTotalCount);
			request.setAttribute("pyTotalCount", pyTotalCount);
			request.setAttribute("pkTotalCount", pkTotalCount);
			request.setAttribute("wpdTotalCount", wpdTotalCount);
		}
		request.setAttribute("orgPddtCursor", orgPddtCursor);
		request.setAttribute("qcjzr", qcjzrStr);
		/* 单位盘点动态查询 —— END */
		return "sup/monitor/pdjk/main";
	}

	/**
	 * 递归算法查询上级单位 by WGJ
	 * 
	 * @param topOrgid
	 * @param org
	 * @param list
	 */
	private void recursion(String topOrgid, BdOrg org, List<Object> list) {
		if (org != null) {
			list.add(org);
			if (!topOrgid.equals(org.getRwid())) {
				String parentid = org.getParentid();
				BdOrg supOrg = bdOrgService.getEntity(parentid);
				recursion(topOrgid, supOrg, list);
			}
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public String list(@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "keyvalueStr", defaultValue = "") String keyvalueStr,
			@RequestParam(value = "sortpartStr", defaultValue = "") String sortpartStr,
			@RequestParam(value = "viewMode", required = false) String viewMode,
			HttpServletRequest request) {
		// 接收盘点监控模块的特别参数并直接回传
		String qcjzr = request.getParameter("qcjzr");
		String pdjkType = request.getParameter("pdjkType");
		String pdjkRwid = request.getParameter("pdjkRwid");
		String pdjkOrgid = request.getParameter("pdjkOrgid");
		String pdjkDeptid = request.getParameter("pdjkDeptid");
		request.setAttribute("qcjzr", qcjzr);
		request.setAttribute("pdjkType", pdjkType);
		request.setAttribute("pdjkRwid", pdjkRwid);
		request.setAttribute("pdjkOrgid", pdjkOrgid);
		request.setAttribute("pdjkDeptid", pdjkDeptid);

		// 接收高级查询的常用参数并直接回传
		String zicmc = request.getParameter("zicmc");
		String guigxh = request.getParameter("guigxh");
		String yuanzcbh_min = request.getParameter("yuanzcbh_min");
		String yuanzcbh_max = request.getParameter("yuanzcbh_max");
		String objcode_min = request.getParameter("objcode_min");
		String objcode_max = request.getParameter("objcode_max");
		String gouzrq_begin = request.getParameter("gouzrq_begin");
		String gouzrq_end = request.getParameter("gouzrq_end");
		String caiwrzrq_begin = request.getParameter("caiwrzrq_begin");
		String caiwrzrq_end = request.getParameter("caiwrzrq_end");
		String danj_min = request.getParameter("danj_min");
		String danj_max = request.getParameter("danj_max");
		request.setAttribute("zicmc", zicmc);
		request.setAttribute("guigxh", guigxh);
		request.setAttribute("yuanzcbh_min", yuanzcbh_min);
		request.setAttribute("yuanzcbh_max", yuanzcbh_max);
		request.setAttribute("objcode_min", objcode_min);
		request.setAttribute("objcode_max", objcode_max);
		request.setAttribute("gouzrq_begin", gouzrq_begin);
		request.setAttribute("gouzrq_end", gouzrq_end);
		request.setAttribute("caiwrzrq_begin", caiwrzrq_begin);
		request.setAttribute("caiwrzrq_end", caiwrzrq_end);
		request.setAttribute("danj_min", danj_min);
		request.setAttribute("danj_max", danj_max);

		// 拼接 condsql
		String condsql = " AND TO_CHAR (C.CAIWRZRQ, 'YYYY-MM-DD') <= '" + qcjzr + "'";
		if (StringUtils.isNotBlank(zicmc)) {
			condsql += " AND C.ZICMC LIKE '%" + zicmc + "%'";
		}
		if (StringUtils.isNotBlank(guigxh)) {
			condsql += " AND C.GUIGXH LIKE '%" + guigxh + "%'";
		}
		if (StringUtils.isNotBlank(yuanzcbh_min)) {
			condsql += " AND C.YUANZCBH >= '" + yuanzcbh_min + "'";
		}
		if (StringUtils.isNotBlank(yuanzcbh_max)) {
			condsql += " AND C.YUANZCBH <= '" + yuanzcbh_max + "'";
		}
		if (StringUtils.isNotBlank(objcode_min)) {
			condsql += " AND C.OBJCODE >= '" + objcode_min + "'";
		}
		if (StringUtils.isNotBlank(objcode_max)) {
			condsql += " AND C.OBJCODE <= '" + objcode_max + "'";
		}
		if (StringUtils.isNotBlank(gouzrq_begin)) {
			condsql += " AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') >= '" + gouzrq_begin + "'";
		}
		if (StringUtils.isNotBlank(gouzrq_end)) {
			condsql += " AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '" + gouzrq_end + "'";
		}
		if (StringUtils.isNotBlank(caiwrzrq_begin)) {
			condsql += " AND TO_CHAR (C.CAIWRZRQ, 'YYYY-MM-DD') >= '" + caiwrzrq_begin + "'";
		}
		if (StringUtils.isNotBlank(caiwrzrq_end)) {
			condsql += " AND TO_CHAR (C.CAIWRZRQ, 'YYYY-MM-DD') <= '" + caiwrzrq_end + "'";
		}
		if (StringUtils.isNotBlank(danj_min)) {
			condsql += " AND C.DANJ >= " + danj_min;
		}
		if (StringUtils.isNotBlank(danj_max)) {
			condsql += " AND C.DANJ <= " + danj_max;
		}

		/* 卡片总体情况查询 —— BEGIN */
		// 查询条件组装
		Map<String, Object> cardsTotalCondition = new HashMap<String, Object>(baseCondition);
		cardsTotalCondition.put("orgid", pdjkOrgid);
		cardsTotalCondition.put("querytype", pdjkType);
		cardsTotalCondition.put("rwid", pdjkRwid);
		cardsTotalCondition.put("keyvalue", keyvalueStr);
		cardsTotalCondition.put("condsql", condsql);

		// 如果穿透到员工层
		if ("2".equals(pdjkType)) {
			cardsTotalCondition.put("deptid", pdjkDeptid);
		}

		try {
			bsAstCardService.getCardsTotal(cardsTotalCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> cardsTotalCursor = (List<Object>) cardsTotalCondition.get("P_DS");
		/* 卡片总体情况查询 —— END */

		/* 卡片信息查询 —— BEGIN */
		// 分页模型封装
		int totalCount = 0;
		if (cardsTotalCursor != null && cardsTotalCursor.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) cardsTotalCursor.get(0);
			totalCount = Integer.parseInt(map.get("CNT").toString());
		}
		Page<Object> page = new Page<Object>(PAGE_SIZE, pageNo, totalCount);
		int fromIndex = (page.getPageNo() - 1) * PAGE_SIZE + 1;
		int endIndex = fromIndex + PAGE_SIZE - 1;

		// 查询条件组装
		Map<String, Object> cardsCondition = new HashMap<String, Object>(cardsTotalCondition);
		cardsCondition.put("snum", fromIndex);
		cardsCondition.put("enum", endIndex);
		cardsCondition.put("sortpart", sortpartStr);

		try {
			bsAstCardService.findCards(cardsCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> cardsCursor = (List<Object>) cardsCondition.get("P_DS");
		page.setResults(cardsCursor);
		request.setAttribute(Page.PAGE_NAME, page);
		/* 卡片信息查询 —— END */
		request.setAttribute("keyvalueStr", keyvalueStr);
		request.setAttribute("sortpartStr", sortpartStr);

		// 切换单位时仍保持当前的视图模式
		if (viewMode == null) {
			Object tmpViewMode = request.getSession().getAttribute(VIEW_MODE);
			viewMode = (tmpViewMode != null) ? tmpViewMode.toString() : CARD_MODE;
		}
		request.getSession().setAttribute(VIEW_MODE, viewMode);

		if (LIST_MODE.equals(viewMode)) {
			return "sup/monitor/pdjk/list_mode";
		} else {
			return "sup/monitor/pdjk/card_mode";
		}
	}

	@RequestMapping(value = "/pdCard", method = RequestMethod.POST)
	public String pdCard(@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "keyvalueStr", defaultValue = "") String keyvalueStr,
			@RequestParam(value = "sortpartStr", defaultValue = "") String sortpartStr,
			@RequestParam(value = "viewMode", required = false) String viewMode,
			HttpServletRequest request) {
		Map<String, Object> usersCondition = new HashMap<String, Object>();
		usersCondition.put("includechilddept", "1");
		try {
			coreUserService.findPdUsers(usersCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 查询返回的游标
		List<Object> usersCursor = (List<Object>) usersCondition.get("P_DS");
		request.setAttribute("usersCursor", usersCursor);

		// 使用状况
		request.setAttribute("syzkList", GlobalComponent.syzkList);

		// 接收盘点监控模块的特别参数并直接回传
		String qcjzr = request.getParameter("qcjzr");
		String pdjkType = request.getParameter("pdjkType");
		String pdjkRwid = request.getParameter("pdjkRwid");
		String pdjkOrgid = request.getParameter("pdjkOrgid");
		String pdjkDeptid = request.getParameter("pdjkDeptid");
		String colType = request.getParameter("colType");
		request.setAttribute("qcjzr", qcjzr);
		request.setAttribute("pdjkType", pdjkType);
		request.setAttribute("pdjkRwid", pdjkRwid);
		request.setAttribute("pdjkOrgid", pdjkOrgid);
		request.setAttribute("pdjkDeptid", pdjkDeptid);
		request.setAttribute("colType", colType);

		// 接收高级查询的常用参数并直接回传
		String zicmc = request.getParameter("zicmc");
		String guigxh = request.getParameter("guigxh");
		String shiyrid = request.getParameter("shiyrid");
		String syzkid = request.getParameter("syzkid");
		String jiaz_min = request.getParameter("jiaz_min");
		String jiaz_max = request.getParameter("jiaz_max");
		request.setAttribute("zicmc", zicmc);
		request.setAttribute("guigxh", guigxh);
		request.setAttribute("shiyrid", shiyrid);
		request.setAttribute("syzkid", syzkid);
		request.setAttribute("jiaz_min", jiaz_min);
		request.setAttribute("jiaz_max", jiaz_max);

		// 拼接 condsql
		String condsql = "";
		if (StringUtils.isNotBlank(zicmc)) {
			condsql += " AND C.ZICMC LIKE '%" + zicmc + "%'";
		}
		if (StringUtils.isNotBlank(guigxh)) {
			condsql += " AND C.GUIGXH LIKE '%" + guigxh + "%'";
		}
		if (StringUtils.isNotBlank(shiyrid)) {
			condsql += " AND BP.RWID = '" + shiyrid + "'";
		}
		if (StringUtils.isNotBlank(syzkid)) {
			condsql += " AND SBD.RWID = '" + syzkid + "'";
		}
		if (StringUtils.isNotBlank(jiaz_min)) {
			condsql += " AND C.JIAZ >= " + jiaz_min;
		}
		if (StringUtils.isNotBlank(jiaz_max)) {
			condsql += " AND C.JIAZ <= " + jiaz_max;
		}

		// 未盘
		if ("wp".equals(colType)) {
			condsql += "AND C.PDID IS NULL";
		}
		// 无盈亏
		else if ("wyk".equals(colType)) {
			condsql += "AND C.SHUL = C.PANDSL";
		}
		// 盘亏
		else if ("pk".equals(colType)) {
			condsql += "AND C.SHUL > C.PANDSL";
		}
		// 盘盈
		else if ("py".equals(colType)) {
			// 接收盘盈卡片的特别参数并直接回传
			String zicflid = request.getParameter("zicflid");
			String date_begin = request.getParameter("date_begin");
			String date_end = request.getParameter("date_end");
			request.setAttribute("zicflid", zicflid);
			request.setAttribute("date_begin", date_begin);
			request.setAttribute("date_end", date_end);

			// 清空 condsql 的原本内容
			condsql = "";
			if (StringUtils.isNotBlank(zicmc)) {
				condsql += " AND P.ZICMC LIKE '%" + zicmc + "%'";
			}
			if (StringUtils.isNotBlank(zicflid)) {
				condsql += " AND P.ZICFLID LIKE '%" + zicflid + "%'";
			}
			if (StringUtils.isNotBlank(date_begin)) {
				condsql += " AND TO_CHAR (P.CREATETIME, 'YYYY-MM-DD') >= '" + date_begin + "'";
			}
			if (StringUtils.isNotBlank(date_end)) {
				condsql += " AND TO_CHAR (P.CREATETIME, 'YYYY-MM-DD') <= '" + date_end + "'";
			}
			if (StringUtils.isNotBlank(shiyrid)) {
				condsql += " AND CU.RWID = '" + shiyrid + "'";
			}

			// 如果穿透到使用状况层
			if ("1".equals(pdjkType)) {
				condsql += " AND P.CREATERDEPTID IS NULL";
			}
			// 如果穿透到员工层
			else if ("2".equals(pdjkType)) {
				condsql += " AND P.CREATERID = '" + pdjkRwid + "' AND P.CREATERDEPTID = '"
						+ pdjkDeptid + "'";
			}
			// 如果穿透到部门层
			else if ("3".equals(pdjkType)) {
				condsql += " AND P.CREATERDEPTID = '" + pdjkRwid + "'";
			}
		}

		/* 盘点总体情况查询 —— BEGIN */
		// 查询条件组装
		Map<String, Object> pdTotalCondition = new HashMap<String, Object>(baseCondition);
		pdTotalCondition.put("orgid", pdjkOrgid);
		pdTotalCondition.put("qcjzr", qcjzr);
		pdTotalCondition.put("querytype", pdjkType);
		pdTotalCondition.put("rwid", pdjkRwid);
		pdTotalCondition.put("keyvalue", keyvalueStr);
		pdTotalCondition.put("condsql", condsql);

		// 如果穿透到员工层
		if ("2".equals(pdjkType)) {
			pdTotalCondition.put("deptid", pdjkDeptid);
		}

		try {
			if ("py".equals(colType)) {
				pdjkService.getPyTotal(pdTotalCondition);
			} else {
				pdjkService.getPdTotal(pdTotalCondition);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> pdTotalCursor = (List<Object>) pdTotalCondition.get("P_DS");
		/* 盘点总体情况查询 —— END */

		/* 盘点信息查询 —— BEGIN */
		// 分页模型封装
		int totalCount = 0;
		if (pdTotalCursor != null && pdTotalCursor.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) pdTotalCursor.get(0);
			if ("py".equals(colType)) {
				totalCount = Integer.parseInt(map.get("CNT").toString());
			} else {
				totalCount = Integer.parseInt(map.get("C").toString());
			}
		}
		Page<Object> page = new Page<Object>(PAGE_SIZE, pageNo, totalCount);
		int fromIndex = (page.getPageNo() - 1) * PAGE_SIZE + 1;
		int endIndex = fromIndex + PAGE_SIZE - 1;

		// 查询条件组装
		Map<String, Object> pdCondition = new HashMap<String, Object>(pdTotalCondition);
		pdCondition.put("snum", fromIndex);
		pdCondition.put("enum", endIndex);
		pdCondition.put("sortpart", sortpartStr);

		try {
			if ("py".equals(colType)) {
				pdjkService.findPy(pdCondition);
			} else {
				pdjkService.findPd(pdCondition);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> pdCursor = (List<Object>) pdCondition.get("P_DS");
		page.setResults(pdCursor);
		request.setAttribute(Page.PAGE_NAME, page);
		/* 盘点信息查询 —— END */
		request.setAttribute(PREFIX_PATH, prefixPath);
		request.setAttribute("keyvalueStr", keyvalueStr);
		request.setAttribute("sortpartStr", sortpartStr);

		// 单位盘点基准日查询
		orgPdjzrCursor = findQcjzr(pdjkOrgid);
		request.setAttribute("orgPdjzrCursor", orgPdjzrCursor);

		if ("py".equals(colType)) {
			return "sup/monitor/pdjk/py_card";
		} else {
			return "sup/monitor/pdjk/pd_card";
		}
	}

	@RequestMapping(value = "/exportExcel", method = RequestMethod.POST)
	public void exportExcel(@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "sortpartStr", defaultValue = "") String sortpartStr,
			@RequestParam(value = "keyvalueStr", defaultValue = "") String keyvalueStr,
			@RequestParam(value = "shzkcode", defaultValue = "") String shzkcode,
			@RequestParam(value = "pdjkOrgid", defaultValue = "") String pdjkOrgid,
			@RequestParam(value = "pdjkDeptid", defaultValue = "") String pdjkDeptid,
			@RequestParam(value = "pdjkType", defaultValue = "") String pdjkType,
			@RequestParam(value = "pdjkRwid", defaultValue = "") String pdjkRwid,
			@RequestParam(value = "colType", defaultValue = "") String colType,
			@RequestParam(value = "qcjzr", defaultValue = "") String qcjzr,
			@RequestParam(value = "checkedIdStr", required = false) String checkedIdStr,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		int fromIndex = (pageNo - 1) * Page.PAGE_SIZE + 1;
		int endIndex = fromIndex + Page.PAGE_SIZE - 1;
		// 行数据查询 - 条件组装
		Map<String, Object> rowsCondition = new HashMap<String, Object>(baseCondition);
		rowsCondition.put("orgid", pdjkOrgid);
		rowsCondition.put("snum", fromIndex);
		rowsCondition.put("enum", endIndex);
		rowsCondition.put("querytype", pdjkType);
		rowsCondition.put("rwid", pdjkRwid);
		rowsCondition.put("keyvalue", keyvalueStr);
		rowsCondition.put("sortpart", sortpartStr);
		String condsql = "";

		if ("2".equals(pdjkType)) {
			rowsCondition.put("deptid", pdjkDeptid);
		}

		if ("".equals(colType)) {
			// 单位,部门,人员所有卡片导出
			rowsCondition.put("shzkcode", shzkcode);
			rowsCondition.put("condsql", "and TO_CHAR(c.caiwrzrq,'YYYY-MM-DD') <= '" + qcjzr + "'");

		} else {
			// 未盘
			if ("wp".equals(colType)) {
				condsql += "AND C.PDID IS NULL";
			}
			// 无盈亏
			else if ("wyk".equals(colType)) {
				condsql += "AND C.SHUL = C.PANDSL";
			}
			// 盘亏
			else if ("pk".equals(colType)) {
				condsql += "AND C.SHUL > C.PANDSL";
			}
			// 盘盈
			else if ("py".equals(colType)) {
				// 接收盘盈卡片的特别参数
				String zicflid = request.getParameter("zicflid");
				String date_begin = request.getParameter("date_begin");
				String date_end = request.getParameter("date_end");

				String zicmc = request.getParameter("zicmc");
				String shiyrid = request.getParameter("shiyrid");

				// 清空 condsql 的原本内容
				condsql = "";
				if (StringUtils.isNotBlank(zicmc)) {
					condsql += " AND P.ZICMC LIKE '%" + zicmc + "%'";
				}
				if (StringUtils.isNotBlank(zicflid)) {
					condsql += " AND P.ZICFLID LIKE '%" + zicflid + "%'";
				}
				if (StringUtils.isNotBlank(date_begin)) {
					condsql += " AND TO_CHAR (P.CREATETIME, 'YYYY-MM-DD') >= '" + date_begin + "'";
				}
				if (StringUtils.isNotBlank(date_end)) {
					condsql += " AND TO_CHAR (P.CREATETIME, 'YYYY-MM-DD') <= '" + date_end + "'";
				}
				if (StringUtils.isNotBlank(shiyrid)) {
					condsql += " AND CU.RWID = '" + shiyrid + "'";
				}

				// 如果穿透到使用状况层
				if ("1".equals(pdjkType)) {
					condsql += " AND P.CREATERDEPTID IS NULL";
				}
				// 如果穿透到员工层
				else if ("2".equals(pdjkType)) {
					condsql += " AND P.CREATERID = '" + pdjkRwid + "' AND P.CREATERDEPTID = '"
							+ pdjkDeptid + "'";
				}
				// 如果穿透到部门层
				else if ("3".equals(pdjkType)) {
					condsql += " AND P.CREATERDEPTID = '" + pdjkRwid + "'";
				}
			}
			rowsCondition.put("qcjzr", qcjzr);
			rowsCondition.put("condsql", condsql);
		}

		// 查询行数据
		try {
			if ("".equals(colType)) {
				bsAstCardService.findCards(rowsCondition);
			} else if ("py".equals(colType)) {
				pdjkService.findPy(rowsCondition);
			} else {
				pdjkService.findPd(rowsCondition);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 行数据查询返回的游标
		List<Object> rowsCursor = (List<Object>) rowsCondition.get("P_DS");
		// 列数据查询返回的游标
		List<Object> colsCursor = new ArrayList<Object>();
		Field[] colFields = null;
		if ("".equals(colType)) {
			colFields = DefaultCardExportVo.class.getDeclaredFields();
		} else if ("wp".equals(colType)) {
			colFields = WpCardExportVo.class.getDeclaredFields();
		} else if ("wyk".equals(colType)) {
			colFields = WykCardExportVo.class.getDeclaredFields();
		} else if ("pk".equals(colType)) {
			colFields = PkCardExportVo.class.getDeclaredFields();
		} else if ("py".equals(colType)) {
			colFields = PanyCardExportVo.class.getDeclaredFields();
		}

		for (Field colField : colFields) {
			String fieldName = colField.getName();
			colsCursor.add(fieldName);
		}

		// 只要行（列）数据为空，即终止导出操作
		if (rowsCursor == null || rowsCursor.size() == 0) {
			throw new RuntimeException("行数据异常");
		}
		if (colsCursor == null || colsCursor.size() == 0) {
			throw new RuntimeException("列数据异常");
		}

		// 筛选出被选中的卡片
		List<Object> checkedCards = new ArrayList<Object>();
		String[] idArr = checkedIdStr.split(",");
		for (String idStr : idArr) {
			for (Object row : rowsCursor) {
				Map<String, String> rowMap = (Map<String, String>) row;
				if (idStr.equals(rowMap.get("RWID"))) {
					checkedCards.add(row);
					break;
				}
			}
		}

		// 抽取列数据中的关键项，并重新组装（即最终展示在 Excel 中的列数据）
		final List<String> fldNames = new ArrayList<String>();
		for (Object col : colsCursor) {
			String colStr = (String) col;
			fldNames.add(colStr);
		}

		// 值对象集合（即最终展示在 Excel 中的行数据）
		final List<PdExportVo> cardVos = new ArrayList<PdExportVo>();
		// 遍历行数据游标
		for (Object row : checkedCards) {
			// 每行数据都使用一个 Vo 进行包装
			PdExportVo cardVo = null;
			if ("".equals(colType)) {
				cardVo = new DefaultCardExportVo();
			} else if ("wp".equals(colType)) {
				cardVo = new WpCardExportVo();
			} else if ("wyk".equals(colType)) {
				cardVo = new WykCardExportVo();
			} else if ("pk".equals(colType)) {
				cardVo = new PkCardExportVo();
			} else if ("py".equals(colType)) {
				cardVo = new PanyCardExportVo();
			}

			// 遍历最终的列数据
			for (String fldName : fldNames) {
				Map<String, Object> rowMap = (Map<String, Object>) row;
				// 获取行数据中与本列对应的值
				Object fldValue = rowMap.get(fldName.toUpperCase());
				// 利用反射组装 Vo
				try {
					// 获取 Vo 中与本列对应的属性（属性名均采用了全小写的命名方式）
					Field field = cardVo.getClass().getDeclaredField(fldName.toLowerCase());
					// 突破访问权限
					field.setAccessible(true);
					// 为该属性赋值
					if (fldValue != null) {
						if ("py".equals(colType) && "isyans".equalsIgnoreCase(field.getName())) {
							if ("0".equals(fldValue.toString())) {
								fldValue = "未生成验收单";
							} else {
								fldValue = "已生成验收单";
							}
						} else if (fldValue instanceof BigDecimal) {
							fldValue = new BigDecimal(fldValue.toString());
						} else {
							if (("py".equals(colType) && "qcjzr".equalsIgnoreCase(field.getName()))
									|| "caiwrzrq".equalsIgnoreCase(field.getName())) {
								fldValue = fldValue.toString().substring(0, 10);
							} else {
								fldValue = fldValue.toString();
							}
						}
					} else {
						String className = field.getType().getSimpleName();
						if (className.equalsIgnoreCase("BigDecimal")) {
							fldValue = new BigDecimal("0");
						} else {
							fldValue = "";
						}
					}
					field.set(cardVo, fldValue);
				} catch (SecurityException e) {
					e.printStackTrace();
				} catch (NoSuchFieldException e) {
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}
			}
			// 将组装完成的 Vo 添加至值对象集合
			cardVos.add(cardVo);
		}

		// 设置模板文件
		String templateFileName = "";
		if ("".equals(colType)) {
			templateFileName = "FrameAl.xls";
		} else if ("wp".equals(colType)) {
			templateFileName = "BtnTab_WPF.xls";
		} else if ("wyk".equals(colType)) {
			templateFileName = "BtnTab_WYKF.xls";
		} else if ("pk".equals(colType)) {
			templateFileName = "BtnTab_PKF.xls";
		} else if ("py".equals(colType)) {
			templateFileName = "BtnTab_PanYF.xls";
		}

		// 读取 Excel 模版的输入流
		InputStream is = getClass().getClassLoader().getResourceAsStream(
				"excelTemplate/" + templateFileName);

		// 传递单位名
		String orgName = "";
		if ("".equals(colType)) {
			orgName = getDefaultValueFromCursor("DANWMC", rowsCursor);
		} else {
			BdOrg org = bdOrgService.getEntity(currentUser.getCurrentOrgId());
			orgName = org.getObjname();
		}

		// 设置输出文件名
		String fileName = "";
		if ("".equals(colType)) {
			fileName = "固定资产卡片";
		} else if ("wp".equals(colType)) {
			fileName = "未盘资产卡片";
		} else if ("wyk".equals(colType)) {
			fileName = "无盈亏资产卡片";
		} else if ("pk".equals(colType)) {
			fileName = "盘亏资产卡片";
		} else if ("py".equals(colType)) {
			fileName = "盘盈资产";
		}

		// 获取响应下载的输出流
		OutputStream os = getExcelOS(fileName, request, response);

		// Jxls 容器
		Context context = new Context();
		// 传递值对象集合
		context.putVar("cards", cardVos);
		// 传递单位名称
		context.putVar("orgName", orgName);
		// 传递当前日期
		context.putVar("currentDate", formatDate(new Date(), "yyyy-MM-dd"));

		// 根据模版生成 Excel 文件
		JxlsHelper.getInstance().processTemplate(is, os, context);
	}

}