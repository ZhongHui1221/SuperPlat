package com.zheling.sup.query.controller;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
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
import com.zheling.base.vo.ChartVo;
import com.zheling.sup.query.service.ShiyztService;

@Controller
@RequestMapping("/Query/Syzk")
public class SyzkController extends BaseController {

	@Autowired
	private ShiyztService shiyztService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(HttpServletRequest request) {

		// 使用状况总体条件组装

		Map<String, Object> totalCondition = new HashMap<String, Object>(
				baseCondition);

		// 使用状况明细条件分享总体条件

		Map<String, Object> detailCondition = new HashMap<String, Object>(
				totalCondition);

		// 组装查询条件

		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("totalCondition", totalCondition);
		map.put("detailCondition", detailCondition);

		// 查询结果

		try {
			shiyztService.queryShiYZT(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		/* 固定资产使用状况查询数量圆饼图 */

		// 查询返回游标结果集

		List<Object> totalCursor = (List<Object>) map.get("totalCondition")
				.get("P_DS");
		List<Object> detailCursor = (List<Object>) map.get("detailCondition")
				.get("P_DS");

		// 数据组装

		// 图例
		List<Object> chartLegend = new ArrayList<Object>();
		// 按照卡片数量
		List<ChartVo> syzkCntList = new ArrayList<ChartVo>();
		// 按照卡片价值
		List<ChartVo> syzkPriceList = new ArrayList<ChartVo>();

		// 表格数据
		Double rkjzTotal = 0.0;
		Double zyjzTotal = 0.0;
		Double gyjzTotal = 0.0;
		Double czjzTotal = 0.0;
		Double cjjzTotal = 0.0;
		Double xzjzTotal = 0.0;

		if (totalCursor != null && totalCursor.size() > 0
				&& detailCursor != null && detailCursor.size() > 0) {

			Map<String, Object> tempMap = null;

			for (Object legend : totalCursor) {
				ChartVo tempChart1 = new ChartVo();
				ChartVo tempChart2 = new ChartVo();

				tempMap = (Map<String, Object>) legend;
				chartLegend.add(tempMap.get("OBJNAME"));

				tempChart1.setId(tempMap.get("SHIYZKID").toString());
				tempChart1.setName(tempMap.get("OBJNAME").toString());
				tempChart1.setValue(tempMap.get("CNT").toString());
				syzkCntList.add(tempChart1);

				tempChart2.setId(tempMap.get("SHIYZKID").toString());
				tempChart2.setName(tempMap.get("OBJNAME").toString());
				Double jiaz = Double.valueOf(tempMap.get("JIAZ").toString());
				BigDecimal decimal = new BigDecimal(jiaz / 10000).setScale(2,
						BigDecimal.ROUND_HALF_UP);
				tempChart2.setValue(decimal.toString());
				syzkPriceList.add(tempChart2);
			}

			for (Object cursor : detailCursor) {
				tempMap = (Map<String, Object>) cursor;

				rkjzTotal += Double.valueOf(tempMap.get("RKJIAZ").toString());
				zyjzTotal += Double.valueOf(tempMap.get("ZYJIAZ").toString());
				gyjzTotal += Double.valueOf(tempMap.get("GYJIAZ").toString());
				czjzTotal += Double.valueOf(tempMap.get("CZJIAZ").toString());
				cjjzTotal += Double.valueOf(tempMap.get("CJJIAZ").toString());
				xzjzTotal += Double.valueOf(tempMap.get("XZJIAZ").toString());
			}
		}

		// 图相关
		request.setAttribute("chartLegend", JSON.toJSONString(chartLegend));
		request.setAttribute("chart1Data", JSON.toJSONString(syzkCntList));
		request.setAttribute("chart2Data", JSON.toJSONString(syzkPriceList));

		// 表相关

		request.setAttribute("detailCursor", detailCursor);
		request.setAttribute("rkjzTotal", rkjzTotal);
		request.setAttribute("zyjzTotal", zyjzTotal);
		request.setAttribute("gyjzTotal", gyjzTotal);
		request.setAttribute("czjzTotal", czjzTotal);
		request.setAttribute("cjjzTotal", cjjzTotal);
		request.setAttribute("xzjzTotal", xzjzTotal);

		return "sup/query/syqk/main";
	}

}