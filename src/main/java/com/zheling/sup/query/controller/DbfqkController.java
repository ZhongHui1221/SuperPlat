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
import com.zheling.sup.query.service.DbfzcService;

@Controller
@RequestMapping("/Query/Dbfqk")
public class DbfqkController extends BaseController {

	@Autowired
	private DbfzcService dbfzcService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(HttpServletRequest request) {

		// 待报废图参数组装
		Map<String, Object> chartsCondition = new HashMap<String, Object>(
				baseCondition);

		// 待报废表参数组装
		Map<String, Object> tableCondition = new HashMap<String, Object>(
				chartsCondition);

		// 查询条件组装
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("totalCondition", chartsCondition);
		map.put("detailCondition", tableCondition);

		// 查询
		try {
			dbfzcService.queryDbfzc(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回游标
		List<Object> totalCursor = (List<Object>) map.get("totalCondition")
				.get("P_DS");
		List<Object> detailCursor = (List<Object>) map.get("detailCondition")
				.get("P_DS");

		// 组装数据

		// 图例集合
		List<Object> dbfLegend = new ArrayList<Object>();
		// 数量分配图数据集合
		List<ChartVo> dbfCntList = new ArrayList<ChartVo>();
		List<ChartVo> zCntList = new ArrayList<ChartVo>();
		// 价值分配图数据集合
		List<ChartVo> dbfPriceList = new ArrayList<ChartVo>();

		// 表格数据

		// 依用途合计
		Double totalA = 0.0;// 0-3年
		Double totalB = 0.0;// 3-5年
		Double totalC = 0.0;// 5-8年
		Double totalD = 0.0;// 8-10年
		Double totalE = 0.0;// 10-15年
		Double totalF = 0.0;// 15-20年
		Double totalG = 0.0;// 20年以上

		if (totalCursor != null && detailCursor != null
				&& totalCursor.size() > 0 && detailCursor.size() > 0) {

			Map<String, Object> tempMap = null;

			for (Object cursor : totalCursor) {
				ChartVo tempChartVo1 = new ChartVo();
				ChartVo tempChartVo2 = new ChartVo();
				ChartVo tempChartVo3 = new ChartVo();
				tempMap = (Map<String, Object>) cursor;

				dbfLegend.add(tempMap.get("DL"));
				tempChartVo1.setId(tempMap.get("ID").toString());
				tempChartVo1.setValue(tempMap.get("ZCNT").toString());
				zCntList.add(tempChartVo1);
				tempChartVo3.setId(tempMap.get("ID").toString());
				tempChartVo3.setValue(tempMap.get("DBFCNT").toString());
				dbfCntList.add(tempChartVo3);

				tempChartVo2.setId(tempMap.get("ID").toString());
				tempChartVo2.setName(tempMap.get("DL").toString());
				Double jiaz = Double.valueOf(tempMap.get("DBFJIAZ").toString());
				BigDecimal decimal = new BigDecimal(jiaz / 10000).setScale(2,
						BigDecimal.ROUND_HALF_UP);
				tempChartVo2.setValue(decimal.toString());
				dbfPriceList.add(tempChartVo2);
			}

			for (Object cursor : detailCursor) {
				tempMap = (Map<String, Object>) cursor;

				totalA += Double.valueOf(tempMap.get("AJIAZ").toString());
				totalB += Double.valueOf(tempMap.get("BJIAZ").toString());
				totalC += Double.valueOf(tempMap.get("CJIAZ").toString());
				totalD += Double.valueOf(tempMap.get("DJIAZ").toString());
				totalE += Double.valueOf(tempMap.get("EJIAZ").toString());
				totalF += Double.valueOf(tempMap.get("FJIAZ").toString());
				totalG += Double.valueOf(tempMap.get("GJIAZ").toString());
			}
		}

		// 与图表相关的请求
		request.setAttribute("dbfLegend", JSON.toJSONString(dbfLegend));
		request.setAttribute("zCntList", JSON.toJSONString(zCntList));
		request.setAttribute("dbfCntList", JSON.toJSONString(dbfCntList));
		request.setAttribute("dbfPriceList", JSON.toJSONString(dbfPriceList));
		request.setAttribute("detailCursor", detailCursor);
		request.setAttribute("totalA", totalA);
		request.setAttribute("totalB", totalB);
		request.setAttribute("totalC", totalC);
		request.setAttribute("totalD", totalD);
		request.setAttribute("totalE", totalE);
		request.setAttribute("totalF", totalF);
		request.setAttribute("totalG", totalG);

		return "sup/query/dbfqk/main";
	}

}