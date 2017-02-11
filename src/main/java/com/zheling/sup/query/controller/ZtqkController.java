package com.zheling.sup.query.controller;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;
import com.zheling.base.controller.BaseController;
import com.zheling.sup.query.service.ZtqkService;

@Controller
@RequestMapping("/Query/Ztqk")
public class ZtqkController extends BaseController {

	@Autowired
	private ZtqkService ztqkService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(HttpServletRequest request) {
		// 总体情况查询（年度）- 条件组装
		Map<String, Object> ztqkYearCondition = new HashMap<String, Object>(
				baseCondition);
		ztqkYearCondition.put("chaxtype", "0");

		// 总体情况查询（月度）- 条件组装
		Map<String, Object> ztqkMonthCondition = new HashMap<String, Object>(
				baseCondition);
		ztqkMonthCondition.put("chaxtype", "1");
		ztqkMonthCondition.put("year", formatDate(new Date(), "yyyy"));

		// 总查询条件组装
		Map<String, Map<String, Object>> conditionMap = new HashMap<String, Map<String, Object>>();
		conditionMap.put("ztqkYearCondition", ztqkYearCondition);
		conditionMap.put("ztqkMonthCondition", ztqkMonthCondition);

		try {
			ztqkService.findZtqk(conditionMap);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		/* 总体情况查询（年度）—— BEGIN */
		// 查询返回的游标
		List<Object> ztqkYearCursor = (List<Object>) conditionMap.get(
				"ztqkYearCondition").get("P_DS");

		// 年度集合
		List<Object> ztqkYearList = new ArrayList<Object>();
		// 卡片数量集合
		List<Object> ztqkYearCntList = new ArrayList<Object>();
		// 卡片价值集合
		List<Object> ztqkYearPriceList = new ArrayList<Object>();

		if (ztqkYearCursor != null && ztqkYearCursor.size() > 0) {
			for (Object ztqkYear : ztqkYearCursor) {
				Map<String, Object> map = (Map<String, Object>) ztqkYear;
				ztqkYearList.add(map.get("ND") + " 年");
				ztqkYearCntList.add(map.get("XCNT"));

				String jiaz = map.get("XJIAZ") != null ? map.get("XJIAZ")
						.toString() : "0.0";
				Double ztqkYearPrice = Double.valueOf(jiaz);
				BigDecimal ztqkYearPriceDecimal = new BigDecimal(
						ztqkYearPrice / 10000).setScale(2,
						BigDecimal.ROUND_HALF_UP);
				ztqkYearPriceList.add(ztqkYearPriceDecimal);
			}
		}

		request.setAttribute("ztqkYearList", JSON.toJSONString(ztqkYearList));
		request.setAttribute("ztqkYearCntList",
				JSON.toJSONString(ztqkYearCntList));
		request.setAttribute("ztqkYearPriceList",
				JSON.toJSONString(ztqkYearPriceList));
		/* 总体情况查询（年度）—— END */

		/* 总体情况查询（月度）—— BEGIN */
		// 查询返回的游标
		List<Object> ztqkMonthCursor = (List<Object>) conditionMap.get(
				"ztqkMonthCondition").get("P_DS");

		// 月份集合
		List<Object> ztqkMonthList = new ArrayList<Object>();
		// 卡片数量集合
		List<Object> ztqkMonthCntList = new ArrayList<Object>();
		// 卡片价值集合
		List<Object> ztqkMonthPriceList = new ArrayList<Object>();

		if (ztqkMonthCursor != null && ztqkMonthCursor.size() > 0) {
			for (Object ztqkMonth : ztqkMonthCursor) {
				Map<String, Object> map = (Map<String, Object>) ztqkMonth;
				ztqkMonthList.add(map.get("YF") + " 月");
				ztqkMonthCntList.add(map.get("XCNT"));

				String jiaz = map.get("XJIAZ") != null ? map.get("XJIAZ")
						.toString() : "0.0";
				Double ztqkYearPrice = Double.valueOf(jiaz);
				BigDecimal ztqkYearPriceDecimal = new BigDecimal(
						ztqkYearPrice / 10000).setScale(2,
						BigDecimal.ROUND_HALF_UP);
				ztqkMonthPriceList.add(ztqkYearPriceDecimal);
			}
		}

		request.setAttribute("ztqkMonthList", JSON.toJSONString(ztqkMonthList));
		request.setAttribute("ztqkMonthCntList",
				JSON.toJSONString(ztqkMonthCntList));
		request.setAttribute("ztqkMonthPriceList",
				JSON.toJSONString(ztqkMonthPriceList));
		/* 总体情况查询（月度）—— END */
		return "sup/query/ztqk/main";
	}

}