package com.zheling.sup.query.controller;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.zheling.sup.query.service.RzqkService;

@Controller
@RequestMapping("/Query/Rzqk")
public class RzqkController extends BaseController {

	@Autowired
	private RzqkService rzqkService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(
			@RequestParam(value = "beginDateStr", required = false) String stimeStr,
			@RequestParam(value = "endDateStr", required = false) String etimeStr,
			HttpServletRequest request) {
		// 默认情况下的查询上月末到本月今天
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if (StringUtils.isBlank(stimeStr) && StringUtils.isBlank(etimeStr)) {
			etimeStr = sdf.format(cal.getTime());
			cal.set(Calendar.DAY_OF_MONTH, 0);
			stimeStr = sdf.format(cal.getTime());
		}
		request.setAttribute("beginDateStr", stimeStr);
		request.setAttribute("endDateStr", etimeStr);

		// 登账查询参数组装
		Map<String, Object> dzztCondition = new HashMap<String, Object>(
				baseCondition);

		// 总账查询参数组装
		Map<String, Object> zzCondition = new HashMap<String, Object>(
				dzztCondition);
		zzCondition.put("stime", stimeStr);
		zzCondition.put("etime", etimeStr);

		// 组装查询条件
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("dzztCondition", dzztCondition);
		map.put("zzCondition", zzCondition);

		// 查询
		try {
			rzqkService.queryRzqk(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回结果游标
		List<Object> dzztCursor = (List<Object>) map.get("dzztCondition").get(
				"P_DS");
		List<Object> zzCursor = (List<Object>) map.get("zzCondition").get(
				"P_DS");

		// 数据组装

		// 柱状图横坐标字段集合
		Set<Object> rzqkX = new LinkedHashSet<Object>();
		// 已登账数据集合
		List<ChartVo> ydzList = new ArrayList<ChartVo>();
		// 未入账数据集合
		List<ChartVo> wrzList = new ArrayList<ChartVo>();

		// 表格数据

		// 依原因合计
		Double totalCqjz = 0.0;// 初期价值
		Double totalJf = 0.0;// 借方
		Double totalDf = 0.0;// 贷方
		Double totalMqjz = 0.0;// 末期价值

		if (dzztCursor != null && zzCursor != null && dzztCursor.size() > 0
				&& zzCursor.size() > 0) {

			Map<String, Object> tempMap = null;

			for (Object cursor : dzztCursor) {
				ChartVo tempChartVo1 = new ChartVo();
				tempMap = (Map<String, Object>) cursor;

				rzqkX.add(tempMap.get("OBJNAME"));
				if (tempMap.get("RZZT").equals("0")) {
					tempChartVo1.setId(tempMap.get("RWID").toString());
					tempChartVo1.setValue(tempMap.get("CNT").toString());
					ydzList.add(tempChartVo1);
				} else if (tempMap.get("RZZT").equals("1")) {
					tempChartVo1.setId(tempMap.get("RWID").toString());
					tempChartVo1.setValue(tempMap.get("CNT").toString());
					wrzList.add(tempChartVo1);
				}
			}

			for (Object cursor : zzCursor) {
				tempMap = (Map<String, Object>) cursor;
				
				if(tempMap.get("QIC") instanceof String){
					tempMap.put("QIC", new BigDecimal(tempMap.get("QIC").toString()));
				}
				if(tempMap.get("ZENGJ") instanceof String){
					tempMap.put("ZENGJ", new BigDecimal(tempMap.get("ZENGJ").toString()));
				}
				if(tempMap.get("JIANS") instanceof String){
					tempMap.put("JIANS", new BigDecimal(tempMap.get("JIANS").toString()));
				}
				if(tempMap.get("QIM") instanceof String){
					tempMap.put("QIM", new BigDecimal(tempMap.get("QIM").toString()));
				}
				

				totalCqjz += Double.valueOf(tempMap.get("QIC").toString());
				totalJf += Double.valueOf(tempMap.get("ZENGJ").toString());
				totalDf += Double.valueOf(tempMap.get("JIANS").toString());
				totalMqjz += Double.valueOf(tempMap.get("QIM").toString());
			}
		}

		// 与图表相关的请求
		request.setAttribute("rzqkX", JSON.toJSONString(rzqkX));
		request.setAttribute("ydzList", JSON.toJSONString(ydzList));
		request.setAttribute("wrzList", JSON.toJSONString(wrzList));
		request.setAttribute("zzCursor", zzCursor);
		request.setAttribute("totalCqjz", totalCqjz);
		request.setAttribute("totalJf", totalJf);
		request.setAttribute("totalDf", totalDf);
		request.setAttribute("totalMqjz", totalMqjz);

		return "sup/query/rzqk/main";
	}

}