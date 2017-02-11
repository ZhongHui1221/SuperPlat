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
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.zheling.base.controller.BaseController;
import com.zheling.base.vo.ChartVo;
import com.zheling.sup.query.service.WxqkService;

@Controller
@RequestMapping("/Query/Wxqk")
public class WxqkController extends BaseController {

	@Autowired
	private WxqkService wxqkService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(
			@RequestParam(value = "selectType", defaultValue = "all") String selectType,
			@RequestParam(value = "ndDataStr", required = false) String ndStr,
			HttpServletRequest request) {
		String yfStr = "";

		// 默认情况下查询本年全年
		String newYear = formatDate(new Date(), "yyyy");
		if (ndStr == null || ndStr == "") {
			ndStr = newYear;
			yfStr = "";
		} else if ((Integer.valueOf(ndStr) >= 1990)
				&& (Integer.valueOf(ndStr) <= Integer.valueOf(newYear))) {
			if (!"all".equals(selectType) && selectType.length() > 1) {
				yfStr = selectType;
			} else if (selectType.length() == 1) {
				yfStr = "0" + selectType;
			}
		}
		request.setAttribute("ndDataStr", ndStr);
		request.setAttribute("selectType", selectType);

		// 维修情况近十年情况数据组装
		Map<String, Object> tenYearsTotalCondition = new HashMap<String, Object>(
				baseCondition);
		tenYearsTotalCondition.put("year", ndStr);
		tenYearsTotalCondition.put("cxtype", 0);

		// 维修情况年度情况数据组装
		Map<String, Object> oneYearTotalCondition = new HashMap<String, Object>(
				tenYearsTotalCondition);
		oneYearTotalCondition.put("cxtype", 1);

		// 维修情况详情数据组装
		Map<String, Object> detailCondition = new HashMap<String, Object>(
				baseCondition);
		detailCondition.put("nd", ndStr);
		detailCondition.put("yf", yfStr);

		// 组装查询数据
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("tenYearsTotalCondition", tenYearsTotalCondition);
		map.put("oneYearTotalCondition", oneYearTotalCondition);
		map.put("detailCondition", detailCondition);

		// 查询数据
		try {
			wxqkService.queryWxqk(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回结果集
		List<Object> tenYearsTotalList = (List<Object>) map.get(
				"tenYearsTotalCondition").get("P_DS");
		List<Object> oneYearTotalList = (List<Object>) map.get(
				"oneYearTotalCondition").get("P_DS");
		List<Object> detailList = (List<Object>) map.get("detailCondition")
				.get("P_DS");

		// 图例
		List<Object> wxqkLegend = new ArrayList<Object>();
		// 近十年固定资产维修趋势图
		Map<String, List<Object>> tenYearsMap = new HashMap<String, List<Object>>();
		// 年度各月资产维修趋势图
		Map<String, List<Object>> oneYearMap = new HashMap<String, List<Object>>();
		// 维修情况趋势图（按卡片数量分析）
		List<ChartVo> shuLList = new ArrayList<ChartVo>();
		// 维修情况趋势图（按维修费用分析）
		List<ChartVo> feiYList = new ArrayList<ChartVo>();

		Map<String, Object> tempMap = null;
		Double tempDouble = null;
		BigDecimal tempDecimal = null;

		for (Object detailCursor : detailList) {
			tempMap = (Map<String, Object>) detailCursor;
			wxqkLegend.add(tempMap.get("FS"));
		}

		List<Object> tenYearsLegend = new ArrayList<Object>();
		List<Object> tenYearsData = new ArrayList<Object>();
		for (Object tenYearsCursor : tenYearsTotalList) {
			tempMap = (Map<String, Object>) tenYearsCursor;
			tenYearsLegend.add(tempMap.get("ND"));
			tempDouble = Double.valueOf(tempMap.get("FY").toString());
			tempDecimal = new BigDecimal(tempDouble / 10000).setScale(2,
					BigDecimal.ROUND_HALF_UP);
			tenYearsData.add(tempDecimal);
		}
		tenYearsMap.put("tenYearsLegend", tenYearsLegend);
		tenYearsMap.put("tenYearsData", tenYearsData);

		List<Object> oneYearLegend = new ArrayList<Object>();
		List<Object> oneYearData = new ArrayList<Object>();
		for (Object oneYearCursor : oneYearTotalList) {
			tempMap = (Map<String, Object>) oneYearCursor;
			oneYearLegend.add(tempMap.get("YF"));
			tempDouble = Double.valueOf(tempMap.get("FY").toString());
			tempDecimal = new BigDecimal(tempDouble / 10000).setScale(2,
					BigDecimal.ROUND_HALF_UP);
			oneYearData.add(tempDecimal);
		}
		oneYearMap.put("oneYearLegend", oneYearLegend);
		oneYearMap.put("oneYearData", oneYearData);

		for (Object detail : detailList) {
			ChartVo tempVo1 = new ChartVo();
			ChartVo tempVo2 = new ChartVo();

			tempMap = (Map<String, Object>) detail;
			tempVo1.setId(tempMap.get("WEIXFSID").toString());
			tempVo1.setName(tempMap.get("FS").toString());
			tempVo1.setValue(tempMap.get("SHUL").toString());
			shuLList.add(tempVo1);

			tempVo2.setId(tempMap.get("WEIXFSID").toString());
			tempVo2.setName(tempMap.get("FS").toString());
			tempDouble = Double.valueOf(tempMap.get("FY").toString());
			tempDecimal = new BigDecimal(tempDouble / 10000).setScale(2,
					BigDecimal.ROUND_HALF_UP);
			tempVo2.setValue(tempDecimal.toString());
			feiYList.add(tempVo2);
		}

		// 近十年固定资产维修趋势图有关请求
		request.setAttribute("tenYearsMap", JSON.toJSONString(tenYearsMap));
		// 年度各月资产维修趋势图有关请求
		request.setAttribute("oneYearMap", JSON.toJSONString(oneYearMap));
		// 维修情况趋势图（按卡片数量分析）有关请求
		request.setAttribute("wxqkLegend", JSON.toJSONString(wxqkLegend));
		request.setAttribute("shuLList", JSON.toJSONString(shuLList));
		// 维修情况趋势图（按维修费用分析）有关请求
		request.setAttribute("feiYList", JSON.toJSONString(feiYList));

		return "sup/query/wxqk/main";
	}

}