package com.zheling.base.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.zheling.base.service.ZicflService;

@Controller
public class ZicflController extends BaseController {
	@Autowired
	private ZicflService zicflService;

	@RequestMapping(value = "/findZicfl", method = RequestMethod.GET)
	public String findCyZicfl(HttpServletRequest request) throws Exception {
		/* 常用大类资产分类 --BEGIN */
		// 条件组装
		Map<String, Object> condition = new HashMap<String, Object>();
		// 查询
		zicflService.findCyZicfl(condition);
		// 查询返回结果
		List<Object> zicflCursor = (List<Object>) condition.get("P_DS");
		request.setAttribute("zicflLevel1", zicflCursor);
		/* 常用大类资产分类 --END */

		/* 常用资产分类 --BEGIN */
		String zicflTree = zicflService.cyZicflTree();
		request.setAttribute("zicflTree", zicflTree);
		/* 常用资产分类 --END */

		return "org/home/shenling/zcfl_cy";
	}

	@RequestMapping(value = "/findXxZicfl", method = RequestMethod.GET)
	public String findXxZicfl(HttpServletRequest request) throws Exception {
		String xxZicfls = zicflService.xxZicflTree();
		System.out.println(xxZicfls);
		request.setAttribute("xxZicfls", xxZicfls);
		return "org/home/shenling/zcfl_mx";
	}

	@ResponseBody
	@RequestMapping(value = "/findZicflQuick", method = RequestMethod.POST)
	public String findZicflQuick(
			@RequestParam(name = "keyvalueStr", defaultValue = "") String keyvalueStr,
			HttpServletRequest request) {
		// 组装查询条件
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("isfullname", "1");
		condition.put("key", keyvalueStr);
		condition.put("cnt", "-1");
		// 构造返回结果
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("stat", "SUCCESS");
		// 查询
		try {
			zicflService.findZicflQuick(condition);
		} catch (SQLException e) {
			result.put("stat", "DEFAULT");
			result.put("info", "系统错误!");
			e.printStackTrace();
		}
		// 获取结果集
		List<Object> zcfls = (List<Object>) condition.get("P_DS");
		if (zcfls != null && zcfls.size() > 0) {
			result.put("datas", zcfls);
		}
		return JSON.toJSONString(result);
	}

}
