package com.zheling.sup.query.controller;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.zheling.base.component.GlobalComponent;
import com.zheling.base.controller.BaseController;
import com.zheling.base.util.Page;
import com.zheling.sup.query.service.CzqkService;

@Controller
@RequestMapping("/Query/Czqk")
public class CzqkController extends BaseController {

	@Autowired
	private CzqkService czqkService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(HttpServletRequest request) {
		// 处置情况查询（年度）- 条件组装
		Map<String, Object> czqkYearCondition = new HashMap<String, Object>(
				baseCondition);

		// 处置情况查询（月度）- 条件组装
		Map<String, Object> czqkMonthCondition = new HashMap<String, Object>(
				baseCondition);
		czqkMonthCondition.put("year", formatDate(new Date(), "yyyy"));

		// 总查询条件组装
		Map<String, Map<String, Object>> conditionMap = new HashMap<String, Map<String, Object>>();
		conditionMap.put("czqkYearCondition", czqkYearCondition);
		conditionMap.put("czqkMonthCondition", czqkMonthCondition);

		try {
			czqkService.findCzqk(conditionMap);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		/* 处置情况查询（年度）—— BEGIN */
		// 查询返回的游标
		List<Object> czqkYearCursor = (List<Object>) conditionMap.get(
				"czqkYearCondition").get("P_DS");

		// 年度集合
		List<Object> czqkYearList = new ArrayList<Object>();
		// 卡片数量集合
		List<Object> czqkYearCntList = new ArrayList<Object>();
		// 卡片价值集合
		List<Object> czqkYearPriceList = new ArrayList<Object>();

		if (czqkYearCursor != null && czqkYearCursor.size() > 0) {
			for (Object czqkYear : czqkYearCursor) {
				Map<String, Object> map = (Map<String, Object>) czqkYear;
				czqkYearList.add(map.get("NF") + " 年");
				czqkYearCntList.add(map.get("CNT"));

				String jiaz = map.get("JIAZ") != null ? map.get("JIAZ")
						.toString() : "0.0";
				Double czqkYearPrice = Double.valueOf(jiaz);
				BigDecimal czqkYearPriceDecimal = new BigDecimal(
						czqkYearPrice / 10000).setScale(2,
						BigDecimal.ROUND_HALF_UP);
				czqkYearPriceList.add(czqkYearPriceDecimal);
			}
		}

		request.setAttribute("czqkYearList", JSON.toJSONString(czqkYearList));
		request.setAttribute("czqkYearCntList",
				JSON.toJSONString(czqkYearCntList));
		request.setAttribute("czqkYearPriceList",
				JSON.toJSONString(czqkYearPriceList));
		/* 处置情况查询（年度）—— END */

		/* 处置情况查询（月度）—— BEGIN */
		// 查询返回的游标
		List<Object> czqkMonthCursor = (List<Object>) conditionMap.get(
				"czqkMonthCondition").get("P_DS");

		// 月份集合
		List<Object> czqkMonthList = new ArrayList<Object>();
		// 卡片数量集合
		List<Object> czqkMonthCntList = new ArrayList<Object>();
		// 卡片价值集合
		List<Object> czqkMonthPriceList = new ArrayList<Object>();

		if (czqkMonthCursor != null && czqkMonthCursor.size() > 0) {
			for (Object czqkMonth : czqkMonthCursor) {
				Map<String, Object> map = (Map<String, Object>) czqkMonth;
				czqkMonthList.add(map.get("YF") + " 月");
				czqkMonthCntList.add(map.get("CNT"));

				String jiaz = map.get("JIAZ") != null ? map.get("JIAZ")
						.toString() : "0.0";
				Double czqkYearPrice = Double.valueOf(jiaz);
				BigDecimal czqkYearPriceDecimal = new BigDecimal(
						czqkYearPrice / 10000).setScale(2,
						BigDecimal.ROUND_HALF_UP);
				czqkMonthPriceList.add(czqkYearPriceDecimal);
			}
		}

		request.setAttribute("czqkMonthList", JSON.toJSONString(czqkMonthList));
		request.setAttribute("czqkMonthCntList",
				JSON.toJSONString(czqkMonthCntList));
		request.setAttribute("czqkMonthPriceList",
				JSON.toJSONString(czqkMonthPriceList));
		/* 处置情况查询（月度）—— END */
		return "sup/query/czqk/main";
	}

	@RequestMapping(value = "/czdsp", method = RequestMethod.POST)
	public String czdsp(
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "keyvalueStr", defaultValue = "") String keyvalueStr,
			@RequestParam(value = "sortpartStr", defaultValue = "") String sortpartStr,
			HttpServletRequest request) {
		// 处置方式
		request.setAttribute("czfsList", GlobalComponent.czfsList);

		// 接收处置待审批模块的特别参数并直接回传
		String shenbdh = request.getParameter("shenbdh");
		String czfsid = request.getParameter("czfsid");
		String shenqsj_begin = request.getParameter("shenqsj_begin");
		String shenqsj_end = request.getParameter("shenqsj_end");
		String shul_min = request.getParameter("shul_min");
		String shul_max = request.getParameter("shul_max");
		String jingz_min = request.getParameter("jingz_min");
		String jingz_max = request.getParameter("jingz_max");
		request.setAttribute("shenbdh", shenbdh);
		request.setAttribute("czfsid", czfsid);
		request.setAttribute("shenqsj_begin", shenqsj_begin);
		request.setAttribute("shenqsj_end", shenqsj_end);
		request.setAttribute("shul_min", shul_min);
		request.setAttribute("shul_max", shul_max);
		request.setAttribute("jingz_min", jingz_min);
		request.setAttribute("jingz_max", jingz_max);

		// 拼接 condsql
		String condsql = "";
		if (StringUtils.isNotBlank(shenbdh)) {
			condsql += " AND A.SHENBDH LIKE '%" + shenbdh + "%'";
		}
		if (StringUtils.isNotBlank(czfsid)) {
			condsql += " AND A.CHUZFSID = '" + czfsid + "'";
		}
		if (StringUtils.isNotBlank(shenqsj_begin)) {
			condsql += " AND TO_CHAR (A.SHENQSJ, 'YYYY-MM-DD') >= '"
					+ shenqsj_begin + "'";
		}
		if (StringUtils.isNotBlank(shenqsj_end)) {
			condsql += " AND TO_CHAR (A.SHENQSJ, 'YYYY-MM-DD') <= '"
					+ shenqsj_end + "'";
		}
		if (StringUtils.isNotBlank(shul_min)) {
			condsql += " AND A.SHUL >= " + shul_min;
		}
		if (StringUtils.isNotBlank(shul_max)) {
			condsql += " AND A.SHUL <= " + shul_max;
		}
		if (StringUtils.isNotBlank(jingz_min)) {
			condsql += " AND A.JINGZ >= " + jingz_min;
		}
		if (StringUtils.isNotBlank(jingz_max)) {
			condsql += " AND A.JINGZ <= " + jingz_max;
		}

		/* 待审批处置数量查询 —— BEGIN */
		// 查询条件组装
		Map<String, Object> dspczNumCondition = new HashMap<String, Object>(
				baseCondition);
		dspczNumCondition.put("pifzt", "1");
		dspczNumCondition.put("dengzzt", "-1");
		dspczNumCondition.put("keyvalue", keyvalueStr);
		dspczNumCondition.put("condsql", condsql);

		try {
			czqkService.getDspczNum(dspczNumCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> dspczNumCursor = (List<Object>) dspczNumCondition
				.get("P_DS");
		/* 待审批处置数量查询 —— END */

		/* 待审批处置信息查询 —— BEGIN */
		// 分页模型封装
		int totalCount = 0;
		if (dspczNumCursor != null && dspczNumCursor.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) dspczNumCursor
					.get(0);
			totalCount = Integer.parseInt(map.get("CNT").toString());
		}
		Page<Object> page = new Page<Object>(Page.PAGE_SIZE, pageNo, totalCount);
		int fromIndex = (page.getPageNo() - 1) * Page.PAGE_SIZE + 1;
		int endIndex = fromIndex + Page.PAGE_SIZE - 1;

		// 查询条件组装
		Map<String, Object> dspczCondition = new HashMap<String, Object>(
				dspczNumCondition);
		dspczCondition.put("snum", fromIndex);
		dspczCondition.put("enum", endIndex);
		dspczCondition.put("sortpart", sortpartStr);

		try {
			czqkService.findDspcz(dspczCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> dspczCursor = (List<Object>) dspczCondition.get("P_DS");
		page.setResults(dspczCursor);
		request.setAttribute(Page.PAGE_NAME, page);
		/* 待审批处置信息查询 —— END */
		request.setAttribute("keyvalueStr", keyvalueStr);
		request.setAttribute("sortpartStr", sortpartStr);
		return "sup/query/czqk/czdsp";
	}

	@RequestMapping(value = "/symx", method = RequestMethod.POST)
	public String symx(
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "keyvalueStr", defaultValue = "") String keyvalueStr,
			@RequestParam(value = "sortpartStr", defaultValue = "") String sortpartStr,
			HttpServletRequest request) {
		// 处置方式
		request.setAttribute("czfsList", GlobalComponent.czfsList);

		// 接收处置执行中、处置完成模块的特别参数并直接回传
		String shenbdh = request.getParameter("shenbdh");
		String czfsid = request.getParameter("czfsid");
		String pifsl_min = request.getParameter("pifsl_min");
		String pifsl_max = request.getParameter("pifsl_max");
		String pifdh = request.getParameter("pifdh");
		request.setAttribute("shenbdh", shenbdh);
		request.setAttribute("czfsid", czfsid);
		request.setAttribute("pifsl_min", pifsl_min);
		request.setAttribute("pifsl_max", pifsl_max);
		request.setAttribute("pifdh", pifdh);

		// 拼接 condsql
		String condsql = "";
		if (StringUtils.isNotBlank(shenbdh)) {
			condsql += " AND B.SHENBDH LIKE '%" + shenbdh + "%'";
		}
		if (StringUtils.isNotBlank(czfsid)) {
			condsql += " AND B.CHUZFSID = '" + czfsid + "'";
		}
		if (StringUtils.isNotBlank(pifsl_min)) {
			condsql += " AND B.PIFSL >= " + pifsl_min;
		}
		if (StringUtils.isNotBlank(pifsl_max)) {
			condsql += " AND B.PIFSL <= " + pifsl_max;
		}
		if (StringUtils.isNotBlank(pifdh)) {
			condsql += " AND B.PIFDH LIKE '%" + pifdh + "%'";
		}

		/* 收益明细数量查询 —— BEGIN */
		// 查询条件组装
		Map<String, Object> symxNumCondition = new HashMap<String, Object>(
				baseCondition);
		// chuzzt：0 = 处置执行中，1 = 处置完成
		symxNumCondition.put("chuzzt", extra);
		symxNumCondition.put("keyvalue", keyvalueStr);
		symxNumCondition.put("condsql", condsql);

		try {
			czqkService.getSymxNum(symxNumCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> symxNumCursor = (List<Object>) symxNumCondition
				.get("P_DS");
		/* 收益明细数量查询 —— END */

		/* 收益明细查询 —— BEGIN */
		// 分页模型封装
		int totalCount = 0;
		if (symxNumCursor != null && symxNumCursor.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) symxNumCursor
					.get(0);
			totalCount = Integer.parseInt(map.get("CNT").toString());
		}
		Page<Object> page = new Page<Object>(Page.PAGE_SIZE, pageNo, totalCount);
		int fromIndex = (page.getPageNo() - 1) * Page.PAGE_SIZE + 1;
		int endIndex = fromIndex + Page.PAGE_SIZE - 1;

		// 查询条件组装
		Map<String, Object> symxCondition = new HashMap<String, Object>(
				symxNumCondition);
		symxCondition.put("snum", fromIndex);
		symxCondition.put("enum", endIndex);
		symxCondition.put("sortpart", sortpartStr);

		try {
			czqkService.findSymx(symxCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> symxCursor = (List<Object>) symxCondition.get("P_DS");
		page.setResults(symxCursor);
		request.setAttribute(Page.PAGE_NAME, page);
		/* 收益明细查询 —— END */
		request.setAttribute("keyvalueStr", keyvalueStr);
		request.setAttribute("sortpartStr", sortpartStr);
		request.setAttribute("extra", extra);

		if ("0".equals(extra)) {
			return "sup/query/czqk/czzxz";
		} else {
			return "sup/query/czqk/czwc";
		}
	}

}