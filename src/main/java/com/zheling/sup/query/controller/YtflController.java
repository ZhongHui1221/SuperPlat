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
import com.zheling.sup.query.service.YtflService;

@Controller
@RequestMapping("/Query/Ytfl")
public class YtflController extends BaseController {

	@Autowired
	private YtflService ytflService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(HttpServletRequest request) {

		// 用途分类饼图参数组装
		Map<String, Object> chartsCondition = new HashMap<String, Object>(
				baseCondition);
		chartsCondition.put("cxtype", 0);

		// 用途分类表参数组装
		Map<String, Object> tableCondition = new HashMap<String, Object>(
				chartsCondition);
		tableCondition.put("cxtype", 1);

		// 组装查询条件

		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("totalCondition", chartsCondition);
		map.put("detailCondition", tableCondition);

		// 查询
		try {
			ytflService.queryYtfl(map);
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
		List<Object> ytflLegend = new ArrayList<Object>();
		// 数量分配图数据集合
		List<ChartVo> ytflCntList = new ArrayList<ChartVo>();
		// 价值分配图数据集合
		List<ChartVo> ytflPriceList = new ArrayList<ChartVo>();

		// 表格数据

		// 依用途合计
		Double totalBgsy = 0.0;// 办公使用
		Double totalJxsy = 0.0;// 教学使用
		Double totalPxsy = 0.0;// 培训使用
		Double totalZfzq = 0.0;// 执法执勤
		Double totalCksy = 0.0;// 窗口使用
		Double totalGgfw = 0.0;// 用于公共服务对象
		Double totalZysy = 0.0;// 专业用途
		Double totalQtyw = 0.0;// 其他业务使用

		if (totalCursor != null && detailCursor != null
				&& totalCursor.size() > 0 && detailCursor.size() > 0) {

			Map<String, Object> tempMap = null;

			for (Object cursor : totalCursor) {
				ChartVo tempChartVo1 = new ChartVo();
				ChartVo tempChartVo2 = new ChartVo();
				tempMap = (Map<String, Object>) cursor;

				// 规避开发库中坏数据造成的空指针异常,else中为正常代码 --begin
				if (tempMap.get("YT") == null
						|| tempMap.get("YONGTID").toString() == null) {
					ytflLegend.add("");
					tempChartVo1.setId("");
					tempChartVo1.setName("");
				} else {
					ytflLegend.add(tempMap.get("YT"));
					tempChartVo1.setId(tempMap.get("YONGTID").toString());
					tempChartVo1.setName(tempMap.get("YT").toString());
				}
				tempChartVo1.setValue(tempMap.get("CNT").toString());
				ytflCntList.add(tempChartVo1);

				if (tempMap.get("YT") == null
						|| tempMap.get("YONGTID").toString() == null) {
					tempChartVo2.setId("");
					tempChartVo2.setName("");
				} else {
					tempChartVo2.setId(tempMap.get("YONGTID").toString());
					tempChartVo2.setName(tempMap.get("YT").toString());
				}
				// 规避开发库中坏数据造成的空指针异常,else中为正常代码 --end
				Double jiaz = Double.valueOf(tempMap.get("JIAZ").toString());
				BigDecimal decimal = new BigDecimal(jiaz / 10000).setScale(2,
						BigDecimal.ROUND_HALF_UP);
				tempChartVo2.setValue(decimal.toString());
				ytflPriceList.add(tempChartVo2);
			}

			for (Object cursor : detailCursor) {
				tempMap = (Map<String, Object>) cursor;

				totalBgsy += Double.valueOf(tempMap.get("BGJIAZ").toString());
				totalJxsy += Double.valueOf(tempMap.get("JXJIAZ").toString());
				totalPxsy += Double.valueOf(tempMap.get("PXJIAZ").toString());
				totalZfzq += Double.valueOf(tempMap.get("ZQJIAZ").toString());
				totalCksy += Double.valueOf(tempMap.get("CKJIAZ").toString());
				totalGgfw += Double.valueOf(tempMap.get("GGJIAZ").toString());
				totalZysy += Double.valueOf(tempMap.get("ZYJIAZ").toString());
				totalQtyw += Double.valueOf(tempMap.get("QTJIAZ").toString());
			}
		}

		// 与图表相关的请求
		request.setAttribute("ytflLegend", JSON.toJSONString(ytflLegend));
		request.setAttribute("ytflCntList", JSON.toJSONString(ytflCntList));
		request.setAttribute("ytflPriceList", JSON.toJSONString(ytflPriceList));
		request.setAttribute("detailCursor", detailCursor);
		request.setAttribute("totalBgsy", totalBgsy);
		request.setAttribute("totalJxsy", totalJxsy);
		request.setAttribute("totalPxsy", totalPxsy);
		request.setAttribute("totalZfzq", totalZfzq);
		request.setAttribute("totalCksy", totalCksy);
		request.setAttribute("totalGgfw", totalGgfw);
		request.setAttribute("totalZysy", totalZysy);
		request.setAttribute("totalQtyw", totalQtyw);

		return "sup/query/ytfl/main";
	}

}