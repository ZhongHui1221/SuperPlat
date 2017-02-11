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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.zheling.base.controller.BaseController;
import com.zheling.base.vo.ChartVo;
import com.zheling.sup.query.service.CyzcService;
import com.zheling.sup.query.vo.SyzkVo;

@Controller
@RequestMapping("/Query/Cyzc")
public class CyzcController extends BaseController {

	@Autowired
	private CyzcService cyzcService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(
			@RequestParam(value = "dateStr", required = false) String dateStr,
			HttpServletRequest request) {
		// 将当前日期作为默认条件
		if (StringUtils.isBlank(dateStr)) {
			dateStr =formatDate(new Date(), "yyyy-MM-dd");
		}
		// 日期回显
		request.setAttribute("dateStr", dateStr);

		// 常用资产查询（电脑、办公类设备）- 条件组装
		Map<String, Object> cyq1Condition = new HashMap<String, Object>(
				baseCondition);
		cyq1Condition.put("condsql",
				"AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '" + dateStr + "'");

		// 常用资产查询（机动车辆）- 共享条件
		Map<String, Object> cyq2Condition = new HashMap<String, Object>(
				cyq1Condition);
		// 常用资产查询（数码电器类设备）- 共享条件
		Map<String, Object> cyq3Condition = new HashMap<String, Object>(
				cyq1Condition);
		// 常用资产查询（家具、用具和装具）- 共享条件
		Map<String, Object> cyq4Condition = new HashMap<String, Object>(
				cyq1Condition);

		// 总查询条件组装
		Map<String, Map<String, Object>> conditionMap = new HashMap<String, Map<String, Object>>();
		conditionMap.put("cyq1Condition", cyq1Condition);
		conditionMap.put("cyq2Condition", cyq2Condition);
		conditionMap.put("cyq3Condition", cyq3Condition);
		conditionMap.put("cyq4Condition", cyq4Condition);

		try {
			cyzcService.findCyzc(conditionMap);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		/* 常用资产查询（电脑、办公类设备）—— BEGIN */
		// 查询返回的游标
		List<Object> cyq1Cursor = (List<Object>) conditionMap.get(
				"cyq1Condition").get("P_DS");

		// 图例集合
		List<Object> cyq1Legend = new ArrayList<Object>();
		// 饼状图 1 数据集合
		List<ChartVo> cyq1Data = new ArrayList<ChartVo>();

		if (cyq1Cursor != null && cyq1Cursor.size() > 0) {
			for (Object cyq1 : cyq1Cursor) {
				Map<String, Object> map = (Map<String, Object>) cyq1;
				cyq1Legend.add(map.get("FXZB"));

				// 饼状图 1 数据组装
				ChartVo chartVo = new ChartVo(map.get("ZICFLID").toString(),
						map.get("FXZB").toString(), map.get("CNT").toString());
				cyq1Data.add(chartVo);
			}
		}

		request.setAttribute("cyq1Legend", JSON.toJSONString(cyq1Legend));
		request.setAttribute("cyq1Data", JSON.toJSONString(cyq1Data));
		/* 常用资产查询（电脑、办公类设备）—— END */

		/* 常用资产查询（机动车辆）—— BEGIN */
		// 查询返回的游标
		List<Object> cyq2Cursor = (List<Object>) conditionMap.get(
				"cyq2Condition").get("P_DS");

		// 图例集合
		List<Object> cyq2Legend = new ArrayList<Object>();
		// 饼状图 2 数据集合
		List<ChartVo> cyq2Data = new ArrayList<ChartVo>();

		if (cyq2Cursor != null && cyq2Cursor.size() > 0) {
			for (Object cyq2 : cyq2Cursor) {
				Map<String, Object> map = (Map<String, Object>) cyq2;
				cyq2Legend.add(map.get("FXZB"));

				// 饼状图 2 数据组装
				ChartVo chartVo = new ChartVo(map.get("ZICFLID").toString(),
						map.get("FXZB").toString(), map.get("CNT").toString());
				cyq2Data.add(chartVo);
			}
		}
		request.setAttribute("cyq2Legend", JSON.toJSONString(cyq2Legend));
		request.setAttribute("cyq2Data", JSON.toJSONString(cyq2Data));
		/* 常用资产查询（机动车辆）—— END */

		/* 常用资产查询（数码电器类设备）—— BEGIN */
		// 查询返回的游标
		List<Object> cyq3Cursor = (List<Object>) conditionMap.get(
				"cyq3Condition").get("P_DS");

		// 图例集合
		List<Object> cyq3Legend = new ArrayList<Object>();
		// 饼状图 3 数据集合
		List<ChartVo> cyq3Data = new ArrayList<ChartVo>();

		if (cyq3Cursor != null && cyq3Cursor.size() > 0) {
			for (Object cyq3 : cyq3Cursor) {
				Map<String, Object> map = (Map<String, Object>) cyq3;
				cyq3Legend.add(map.get("FXZB"));

				// 饼状图 3 数据组装
				ChartVo chartVo = new ChartVo(map.get("ZICFLID").toString(),
						map.get("FXZB").toString(), map.get("CNT").toString());
				cyq3Data.add(chartVo);
			}
		}
		request.setAttribute("cyq3Legend", JSON.toJSONString(cyq3Legend));
		request.setAttribute("cyq3Data", JSON.toJSONString(cyq3Data));
		/* 常用资产查询（数码电器类设备）—— END */

		/* 常用资产查询（家具、用具和装具）—— BEGIN */
		// 查询返回的游标
		List<Object> cyq4Cursor = (List<Object>) conditionMap.get(
				"cyq4Condition").get("P_DS");

		// 图例集合
		List<Object> cyq4Legend = new ArrayList<Object>();
		// 饼状图 4 数据集合
		List<ChartVo> cyq4Data = new ArrayList<ChartVo>();

		if (cyq4Cursor != null && cyq4Cursor.size() > 0) {
			for (Object cyq4 : cyq4Cursor) {
				Map<String, Object> map = (Map<String, Object>) cyq4;
				cyq4Legend.add(map.get("FXZB"));

				// 饼状图 4 数据组装
				ChartVo chartVo = new ChartVo(map.get("ZICFLID").toString(),
						map.get("FXZB").toString(), map.get("CNT").toString());
				cyq4Data.add(chartVo);
			}
		}
		request.setAttribute("cyq4Legend", JSON.toJSONString(cyq4Legend));
		request.setAttribute("cyq4Data", JSON.toJSONString(cyq4Data));
		/* 常用资产查询（家具、用具和装具）—— END */
		return "sup/query/cyzc/main";
	}

	@RequestMapping(value = "/zcyt/{dateStr}/{zicflidStr}", method = RequestMethod.GET)
	public String zcyt(@PathVariable("dateStr") String dateStr,
			@PathVariable("zicflidStr") String zicflidStr,
			HttpServletRequest request) {
		// 处理多 ID 拼接的传输格式
		String zicflid = processIdStr(zicflidStr);

		// 资产用途查询 - 条件组装
		Map<String, Object> zcytCondition = new HashMap<String, Object>(
				baseCondition);
		zcytCondition
				.put("condsql", "AND C.ZICFLID IN (" + zicflid
						+ ") AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '"
						+ dateStr + "'");

		try {
			cyzcService.findZcyt(zcytCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		/* 资产用途查询 —— BEGIN */
		// 查询返回的游标
		List<Object> zcytCursor = (List<Object>) zcytCondition.get("P_DS");

		// 总件数
		Integer totalNum = 0;
		// 总价值
		Double totalPrice = 0.0;
		// 未到使用年限的资产总数量
		Integer totalUnexpiredNum = 0;
		// 已到使用年限的资产总数量
		Integer totalExpiredNum = 0;
		// 未到使用年限的资产总价值
		Double totalUnexpiredPrice = 0.0;
		// 已到使用年限的资产总价值
		Double totalExpiredPrice = 0.0;

		// 堆叠柱状图 used 属性集合
		List<Object> zcytUsed = new ArrayList<Object>();
		// 未到使用年限的资产数量集合
		List<ChartVo> unexpiredNumList = new ArrayList<ChartVo>();
		// 已到使用年限的资产数量集合
		List<ChartVo> expiredNumList = new ArrayList<ChartVo>();
		// 未到使用年限的资产价值集合
		List<ChartVo> unexpiredPriceList = new ArrayList<ChartVo>();
		// 已到使用年限的资产价值集合
		List<ChartVo> expiredPriceList = new ArrayList<ChartVo>();

		if (zcytCursor != null && zcytCursor.size() > 0) {
			for (Object zcyt : zcytCursor) {
				Map<String, Object> map = (Map<String, Object>) zcyt;
				zcytUsed.add(map.get("OBJNAME"));

				// 未到使用年限的资产数量 - 数据组装
				if (map.get("YONGTID") != null && map.get("ZSHUL") != null) {
					ChartVo unexpiredNumVo = new ChartVo(map.get("YONGTID")
							.toString(), map.get("ZSHUL").toString());
					unexpiredNumList.add(unexpiredNumVo);

					// 已到使用年限的资产数量 - 数据组装
					ChartVo expiredNumVo = new ChartVo(map.get("YONGTID")
							.toString(), map.get("DBFSHUL").toString());
					expiredNumList.add(expiredNumVo);

					// 未到使用年限的资产价值
					Double unexpiredPrice = Double.valueOf(map.get("ZJIAZ")
							.toString());
					BigDecimal unexpiredPriceDecimal = new BigDecimal(
							unexpiredPrice / 10000).setScale(2,
							BigDecimal.ROUND_HALF_UP);
					ChartVo unexpiredPriceVo = new ChartVo(map.get("YONGTID")
							.toString(), unexpiredPriceDecimal.toString());
					unexpiredPriceList.add(unexpiredPriceVo);

					// 已到使用年限的资产价值
					Double expiredPrice = Double.valueOf(map.get("DBFJIAZ")
							.toString());
					BigDecimal expiredPriceDecimal = new BigDecimal(
							expiredPrice / 10000).setScale(2,
							BigDecimal.ROUND_HALF_UP);
					ChartVo expiredPriceVo = new ChartVo(map.get("YONGTID")
							.toString(), expiredPriceDecimal.toString());
					expiredPriceList.add(expiredPriceVo);

					// 累加总件数
					totalNum += Integer.valueOf(map.get("QSHUL").toString());
					// 累加总价值
					totalPrice += Double.valueOf(map.get("QJIAZ").toString());
					// 累加未到使用年限的资产总数量
					totalUnexpiredNum += Integer.valueOf(map.get("ZSHUL")
							.toString());
					// 累加已到使用年限的资产总数量
					totalExpiredNum += Integer.valueOf(map.get("DBFSHUL")
							.toString());
					// 累加未到使用年限的资产总价值
					totalUnexpiredPrice += Double.valueOf(map.get("ZJIAZ")
							.toString());
					// 累加已到使用年限的资产总价值
					totalExpiredPrice += Double.valueOf(map.get("DBFJIAZ")
							.toString());
				}
			}
		}

		// 与图表相关的请求
		request.setAttribute("zcytUsed", JSON.toJSONString(zcytUsed));
		request.setAttribute("unexpiredNumList",
				JSON.toJSONString(unexpiredNumList));
		request.setAttribute("expiredNumList",
				JSON.toJSONString(expiredNumList));
		request.setAttribute("unexpiredPriceList",
				JSON.toJSONString(unexpiredPriceList));
		request.setAttribute("expiredPriceList",
				JSON.toJSONString(expiredPriceList));

		// 与列表相关的请求
		request.setAttribute("zcytCursor", zcytCursor);
		request.setAttribute("totalNum", totalNum);
		request.setAttribute("totalPrice", totalPrice);
		request.setAttribute("totalUnexpiredNum", totalUnexpiredNum);
		request.setAttribute("totalExpiredNum", totalExpiredNum);
		request.setAttribute("totalUnexpiredPrice", totalUnexpiredPrice);
		request.setAttribute("totalExpiredPrice", totalExpiredPrice);
		/* 资产用途查询 —— END */
		return "sup/query/cyzc/zcyt";
	}

	@RequestMapping(value = "/syzk/{dateStr}/{zicflidStr}/{yongtidStr}", method = RequestMethod.GET)
	public String syzk(@PathVariable("dateStr") String dateStr,
			@PathVariable("zicflidStr") String zicflidStr,
			@PathVariable("yongtidStr") String yongtidStr,
			HttpServletRequest request) {
		// 处理多 ID 拼接的传输格式
		String yongtid = processIdStr(yongtidStr);
		String zicflid = processIdStr(zicflidStr);

		// 使用状况查询 - 条件组装
		Map<String, Object> syzkCondition = new HashMap<String, Object>(
				baseCondition);
		syzkCondition
				.put("condsql", "AND C.YONGTID  IN (" + yongtid
						+ ") AND C.ZICFLID IN (" + zicflid
						+ ") AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '"
						+ dateStr + "'");

		try {
			cyzcService.findZcsyzk(syzkCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		/* 使用状况查询 —— BEGIN */
		// 查询返回的游标
		List<Object> syzkCursor = (List<Object>) syzkCondition.get("P_DS");

		// 图例集合
		List<Object> syzkLegend = new ArrayList<Object>();
		// 图表数据集合
		List<ChartVo> syzkData = new ArrayList<ChartVo>();
		// 列表数据集合
		List<SyzkVo> syzkList = new ArrayList<SyzkVo>();

		if (syzkCursor != null && syzkCursor.size() > 0) {
			for (Object syzk : syzkCursor) {
				Map<String, Object> map = (Map<String, Object>) syzk;
				syzkLegend.add(map.get("SHIYZK"));

				// 图表数据组装
				ChartVo chartVo = new ChartVo(map.get("SHIYZKID").toString(),
						map.get("SHUL").toString());
				syzkData.add(chartVo);

				// 列表数据组装
				String syzkStr = syzk.toString();
				String str = "JIAZ)=";
				int fromIndex = syzkStr.indexOf(str);
				int endIndex = syzkStr.indexOf("}");
				String priceStr = syzkStr.substring(fromIndex + str.length(),
						endIndex);

				Double price = Double.valueOf(priceStr);
				BigDecimal priceDecimal = new BigDecimal(price / 10000)
						.setScale(2, BigDecimal.ROUND_HALF_UP);

				SyzkVo syzkVo = new SyzkVo(map.get("SHIYZK").toString(),
						priceDecimal.toString(), map.get("SHUL").toString());
				syzkList.add(syzkVo);
			}
		}

		// 与图表相关的请求
		request.setAttribute("syzkLegend", JSON.toJSONString(syzkLegend));
		request.setAttribute("syzkData", JSON.toJSONString(syzkData));

		// 与列表相关的请求
		request.setAttribute("syzkList", syzkList);
		/* 使用状况查询 —— END */
		return "sup/query/cyzc/syzk";
	}

}