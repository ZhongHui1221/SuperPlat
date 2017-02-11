package com.zheling.sup.query.controller;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.zheling.sup.query.service.JsqkService;

@Controller
@RequestMapping("/Query/Jsqk")
public class JsqkController extends BaseController {

	@Autowired
	private JsqkService jsqkService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(
			@RequestParam(value = "selectType", defaultValue = "month") String selectType,
			@RequestParam(value = "beginDateStr", required = false) String beginDateStr,
			@RequestParam(value = "endDateStr", required = false) String endDateStr,
			HttpServletRequest request) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("month".equals(selectType)) {
			cal.set(Calendar.DAY_OF_MONTH, 1);
			beginDateStr = sdf.format(cal.getTime());
			cal.set(Calendar.DAY_OF_MONTH,
					cal.getActualMaximum(Calendar.DAY_OF_MONTH));
			endDateStr = sdf.format(cal.getTime());
		} else if ("year".equals(selectType)) {
			cal.set(Calendar.DAY_OF_YEAR, 1);
			beginDateStr = sdf.format(cal.getTime());
			cal.set(Calendar.DAY_OF_YEAR,
					cal.getActualMaximum(Calendar.DAY_OF_YEAR));
			endDateStr = sdf.format(cal.getTime());
		}
		request.setAttribute("selectType", selectType);
		request.setAttribute("beginDateStr", beginDateStr);
		request.setAttribute("endDateStr", endDateStr);

		// 减少情况总体数据参数组装

		Map<String, Object> totalCondition = new HashMap<String, Object>(
				baseCondition);
		totalCondition.put("sjizrq", beginDateStr);
		totalCondition.put("ejizrq", endDateStr);

		// 减少情况明细查询参数组装

		// 共享总体查询参数

		Map<String, Object> detailCondition = new HashMap<String, Object>(
				totalCondition);

		// 组装查询条件

		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("totalCondition", totalCondition);
		map.put("detailCondition", detailCondition);

		// 查询
		try {
			jsqkService.queryJsqk(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回结果游标
		/*
		 * 由于存储过程获取的结果与过程名相反,故,如此处理
		 */

		List<Object> totalCursor = (List<Object>) map.get("detailCondition")
				.get("P_DS");
		List<Object> detailCursor = (List<Object>) map.get("totalCondition")
				.get("P_DS");

		// 数据组装

		// 图例集合
		List<Object> jsqkLegend = new ArrayList<Object>();
		// 数量分配图数据集合
		List<ChartVo> jsqkCntList = new ArrayList<ChartVo>();
		// 价值分配图数据集合
		List<ChartVo> jsqkPriceList = new ArrayList<ChartVo>();

		// 表格数据

		// 依原因合计
		Double totalWcdb = 0.0;// 无偿调拨
		Double totalDwjz = 0.0;// 对外捐赠
		Double totalCs = 0.0;// 出售
		Double totalBf = 0.0;// 报废
		Double totalDwtz = 0.0;// 对外投资
		Double totalXxgz = 0.0;// 信息更正
		Double totalBs = 0.0;// 报损
		Double totalZh = 0.0;// 置换
		Double totalJcgf = 0.0;// 减持股份

		if (totalCursor != null && detailCursor != null
				&& totalCursor.size() > 0 && detailCursor.size() > 0) {

			Map<String, Object> tempMap = null;

			for (Object cursor : totalCursor) {
				ChartVo tempChartVo1 = new ChartVo();
				ChartVo tempChartVo2 = new ChartVo();
				tempMap = (Map<String, Object>) cursor;

				jsqkLegend.add(tempMap.get("MC"));
				tempChartVo1.setName(tempMap.get("MC").toString());
				tempChartVo1.setValue(tempMap.get("CNT").toString());
				jsqkCntList.add(tempChartVo1);

				tempChartVo2.setName(tempMap.get("MC").toString());
				Double jiaz = Double.valueOf(tempMap.get("JIAZ").toString());
				BigDecimal decimal = new BigDecimal(jiaz / 10000).setScale(2,
						BigDecimal.ROUND_HALF_UP);
				tempChartVo2.setValue(decimal.toString());
				jsqkPriceList.add(tempChartVo2);
			}

			for (Object cursor : detailCursor) {
				tempMap = (Map<String, Object>) cursor;

				totalWcdb += Double.valueOf(tempMap.get("WCDBJIAZ").toString());
				totalDwjz += Double.valueOf(tempMap.get("DWJZJIAZ").toString());
				totalCs += Double.valueOf(tempMap.get("CSDBJIAZ").toString());
				totalBf += Double.valueOf(tempMap.get("BFJZJIAZ").toString());
				totalDwtz += Double.valueOf(tempMap.get("TZJZJIAZ").toString());
				totalXxgz += Double.valueOf(tempMap.get("GZJZJIAZ").toString());
				totalBs += Double.valueOf(tempMap.get("BSJZJIAZ").toString());
				totalZh += Double.valueOf(tempMap.get("ZHIHJIAZ").toString());
				totalJcgf += Double.valueOf(tempMap.get("JCGFJIAZ").toString());
			}
		}

		// 与图表相关的请求
		request.setAttribute("jsqkLegend", JSON.toJSONString(jsqkLegend));
		request.setAttribute("jsqkCntList", JSON.toJSONString(jsqkCntList));
		request.setAttribute("jsqkPriceList", JSON.toJSONString(jsqkPriceList));
		request.setAttribute("detailCursor", detailCursor);
		request.setAttribute("totalWcdb", totalWcdb);
		request.setAttribute("totalDwjz", totalDwjz);
		request.setAttribute("totalCs", totalCs);
		request.setAttribute("totalBf", totalBf);
		request.setAttribute("totalDwtz", totalDwtz);
		request.setAttribute("totalXxgz", totalXxgz);
		request.setAttribute("totalBs", totalBs);
		request.setAttribute("totalZh", totalZh);
		request.setAttribute("totalJcgf", totalJcgf);

		return "sup/query/jsqk/main";
	}

}