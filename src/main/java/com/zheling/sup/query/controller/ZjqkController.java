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
import com.zheling.sup.query.service.ZjqkService;

@Controller
@RequestMapping("/Query/Zjqk")
public class ZjqkController extends BaseController {

	@Autowired
	private ZjqkService zjqkService;

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

		// 增加情况总体数据参数组装

		Map<String, Object> totalCondition = new HashMap<String, Object>(
				baseCondition);
		totalCondition.put("stime", beginDateStr);
		totalCondition.put("etime", endDateStr);

		// 增加情况明细查询参数组装

		// 共享总体查询参数

		Map<String, Object> detailCondition = new HashMap<String, Object>(
				totalCondition);

		// 组装查询条件

		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("totalCondition", totalCondition);
		map.put("detailCondition", detailCondition);

		// 查询结果

		try {
			zjqkService.queryZJQK(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回结果游标

		List<Object> totalCursor = (List<Object>) map.get("totalCondition")
				.get("P_DS");
		List<Object> detailCursor = (List<Object>) map.get("detailCondition")
				.get("P_DS");

		// 数据组装

		// 图例集合
		List<Object> zjqkLegend = new ArrayList<Object>();
		// 数量分配图数据集合
		List<ChartVo> zjqkCntList = new ArrayList<ChartVo>();
		// 价值分配图数据集合
		List<ChartVo> zjqkPriceList = new ArrayList<ChartVo>();

		// 表格数据

		// 依来源合计
		Double totalXg = 0.0;// 新购
		Double totalPy = 0.0;// 盘盈
		Double totalDb = 0.0;// 调拨
		Double totalZj = 0.0;// 自建
		Double totalJz = 0.0;// 接受捐赠
		Double totalZh = 0.0;// 置换
		Double totalYz = 0.0;// 自行研制
		Double totalQt = 0.0;// 其他

		if (totalCursor != null && detailCursor != null
				&& totalCursor.size() > 0 && detailCursor.size() > 0) {

			Map<String, Object> tempMap = null;

			for (Object cursor : totalCursor) {
				ChartVo tempChartVo1 = new ChartVo();
				ChartVo tempChartVo2 = new ChartVo();
				tempMap = (Map<String, Object>) cursor;

				zjqkLegend.add(tempMap.get("FS"));
				tempChartVo1.setId(tempMap.get("ID").toString());
				tempChartVo1.setName(tempMap.get("FS").toString());
				tempChartVo1.setValue(tempMap.get("CNT").toString());
				zjqkCntList.add(tempChartVo1);

				tempChartVo2.setId(tempMap.get("ID").toString());
				tempChartVo2.setName(tempMap.get("FS").toString());
				Double jiaz = Double.valueOf(tempMap.get("JIAZ").toString());
				BigDecimal decimal = new BigDecimal(jiaz / 10000).setScale(2,
						BigDecimal.ROUND_HALF_UP);
				tempChartVo2.setValue(decimal.toString());
				zjqkPriceList.add(tempChartVo2);
			}

			for (Object cursor : detailCursor) {
				tempMap = (Map<String, Object>) cursor;

				totalXg += Double.valueOf(tempMap.get("XGJIAZ").toString());
				totalPy += Double.valueOf(tempMap.get("PYJIAZ").toString());
				totalDb += Double.valueOf(tempMap.get("DBJIAZ").toString());
				totalZj += Double.valueOf(tempMap.get("ZJJIAZ").toString());
				totalJz += Double.valueOf(tempMap.get("JZJIAZ").toString());
				totalZh += Double.valueOf(tempMap.get("ZHJIAZ").toString());
				totalYz += Double.valueOf(tempMap.get("ZXYZJIAZ").toString());
				totalQt += Double.valueOf(tempMap.get("QTJIAZ").toString());
			}
		}

		// 与图表相关的请求
		request.setAttribute("zjqkLegend", JSON.toJSONString(zjqkLegend));
		request.setAttribute("zjqkCntList", JSON.toJSONString(zjqkCntList));
		request.setAttribute("zjqkPriceList", JSON.toJSONString(zjqkPriceList));
		request.setAttribute("detailCursor", detailCursor);
		request.setAttribute("totalXg", totalXg);
		request.setAttribute("totalPy", totalPy);
		request.setAttribute("totalDb", totalDb);
		request.setAttribute("totalZj", totalZj);
		request.setAttribute("totalJz", totalJz);
		request.setAttribute("totalZh", totalZh);
		request.setAttribute("totalYz", totalYz);
		request.setAttribute("totalQt", totalQt);

		return "sup/query/zjqk/main";
	}

}