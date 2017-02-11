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
import com.zheling.base.controller.BaseController;
import com.zheling.base.vo.ChartVo;
import com.zheling.sup.query.service.GcqkService;

@Controller
@RequestMapping("/Query/Gcqk")
public class GcqkController extends BaseController {

	@Autowired
	private GcqkService gcqkService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(
			@RequestParam(value = "dateStr", required = false) String dateStr,
			HttpServletRequest request) {
		// 将当前日期作为默认条件
		if (StringUtils.isBlank(dateStr)) {
			dateStr = formatDate(new Date(), "yyyy-MM-dd");
		}
		// 日期回显
		request.setAttribute("dateStr", dateStr);

		// 构成情况查询 - 条件组装
		Map<String, Object> gcqkCondition = new HashMap<String, Object>(
				baseCondition);
		gcqkCondition.put("jizrq", dateStr);

		try {
			gcqkService.findGcqk(gcqkCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		/* 构成情况查询 —— BEGIN */
		// 查询返回的游标
		List<Object> gcqkCursor = (List<Object>) gcqkCondition.get("P_DS");

		// 总数量
		Integer totalNum = 0;
		// 总价值
		Double totalPrice = 0.0;

		// 图例集合
		List<Object> gcqkLegend = new ArrayList<Object>();
		// 卡片数量集合
		List<ChartVo> gcqkCntList = new ArrayList<ChartVo>();
		// 卡片价值集合
		List<ChartVo> gcqkPriceList = new ArrayList<ChartVo>();

		if (gcqkCursor != null && gcqkCursor.size() > 0) {
			for (Object gcqk : gcqkCursor) {
				Map<String, Object> map = (Map<String, Object>) gcqk;
				gcqkLegend.add(map.get("ZICDL"));

				// 柱状图数据组装
				ChartVo barChartVo = new ChartVo(map.get("ZICDLID").toString(),
						map.get("CNT").toString());
				gcqkCntList.add(barChartVo);

				Double gcqkPrice = Double.valueOf(map.get("JIAZ").toString());
				BigDecimal gcqkPriceDecimal = new BigDecimal(gcqkPrice / 10000)
						.setScale(2, BigDecimal.ROUND_HALF_UP);

				// 饼状图数据组装
				ChartVo pieChartVo = new ChartVo(map.get("ZICDLID").toString(),
						map.get("ZICDL").toString(),
						gcqkPriceDecimal.toString());
				gcqkPriceList.add(pieChartVo);

				// 累加总数量
				totalNum += Integer.valueOf(map.get("CNT").toString());
				// 累加总价值
				totalPrice += Double.valueOf(map.get("JIAZ").toString());
			}
		}

		// 与图表相关的请求
		request.setAttribute("gcqkLegend", JSON.toJSONString(gcqkLegend));
		request.setAttribute("gcqkCntList", JSON.toJSONString(gcqkCntList));
		request.setAttribute("gcqkPriceList", JSON.toJSONString(gcqkPriceList));

		// 与列表相关的请求
		request.setAttribute("gcqkCursor", gcqkCursor);
		request.setAttribute("totalNum", totalNum);
		request.setAttribute("totalPrice", totalPrice);
		/* 构成情况查询 —— END */
		return "sup/query/gcqk/main";
	}

}