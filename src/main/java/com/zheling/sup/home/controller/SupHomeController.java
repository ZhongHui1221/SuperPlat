package com.zheling.sup.home.controller;

import java.sql.SQLException;
import java.util.Date;
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

import com.zheling.base.controller.BaseController;
import com.zheling.base.service.BdOrgService;
import com.zheling.sup.home.service.HomeService;

@Controller
@RequestMapping("/supHome")
public class SupHomeController extends BaseController {

	@Autowired
	private HomeService homeService;
	@Autowired
	private BdOrgService bdOrgService;

	@RequestMapping(value = "/index/{orgidStr}/{roleidStr}", method = RequestMethod.GET)
	public String index(@PathVariable("orgidStr") String orgidStr,
			@PathVariable("roleidStr") String roleidStr,
			HttpServletRequest request) {
		// 回传版本信息
		request.setAttribute("version", getConfigInfo("version"));

		/* 角色切换 —— BEGIN */
		List<Object> roleCursor = currentUser.getRoleCursor();
		if ("0".equals(roleidStr)) {
			roleidStr = getDefaultValueFromRoleCursor("RWID", roleCursor);
		}
		currentUser.setCurrentRoleId(roleidStr);
		currentUser.setCurrentRoleCode(getValueFromRoleCursor("OBJCODE",
				roleidStr, roleCursor));
		currentUser.setCurrentRoleName(getValueFromRoleCursor("OBJNAME",
				roleidStr, roleCursor));
		request.getSession().setAttribute(CURRENT_USER, currentUser);
		/* 角色切换 —— END */
		return "sup/home/index";
	}

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(HttpServletRequest request) {
		String currentOrgId = currentUser.getCurrentOrgId();

		// 资产大类查询 - 条件组装
		Map<String, Object> zcdlCondition = new HashMap<String, Object>(
				baseCondition);
		zcdlCondition.put("orgid", currentOrgId);
		zcdlCondition.put("jizrq", formatDate(new Date(), "yyyy-MM-dd"));

		// 重点情况查询 - 条件组装
		Map<String, Object> zdqkCondition = new HashMap<String, Object>(
				baseCondition);
		zdqkCondition.put("orgid", currentOrgId);

		// 使用状态查询 - 条件组装
		Map<String, Object> syztCondition = new HashMap<String, Object>(
				baseCondition);
		syztCondition.put("orgid", currentOrgId);

		// 总查询条件组装
		Map<String, Map<String, Object>> conditionMap = new HashMap<String, Map<String, Object>>();
		conditionMap.put("zcdlCondition", zcdlCondition);
		conditionMap.put("zdqkCondition", zdqkCondition);
		conditionMap.put("syztCondition", syztCondition);

		try {
			homeService.main(conditionMap);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 资产大类查询返回的游标
		List<Object> zcdlCursor = (List<Object>) conditionMap.get(
				"zcdlCondition").get("P_DS");
		if (zcdlCursor != null) {
			// 总价值
			Double zcdlTotalJiaz = 0.00;
			for (Object zcdl : zcdlCursor) {
				if (zcdl != null) {
					Map<String, Object> map = (Map<String, Object>) zcdl;
					zcdlTotalJiaz += Double.valueOf(map.get("JIAZ").toString());
				}
			}
			request.setAttribute("zcdlTotalJiaz", zcdlTotalJiaz);

			// 将页面表体凑满 6 行
			if (zcdlCursor.size() < 6) {
				int difference = 6 - zcdlCursor.size();
				for (int i = 0; i < difference; i++) {
					zcdlCursor.add(null);
				}
			}
		}
		request.setAttribute("zcdlCursor", zcdlCursor);

		// 重点情况查询返回的游标
		List<Object> zdqkCursor = (List<Object>) conditionMap.get(
				"zdqkCondition").get("P_DS");
		if (zdqkCursor != null && zdqkCursor.size() > 0) {
			Map<String, Object> zdqkMap = (Map<String, Object>) zdqkCursor
					.get(0);
			request.setAttribute("zdqkMap", zdqkMap);
		}

		// 使用状态查询返回的游标
		List<Object> syztCursor = (List<Object>) conditionMap.get(
				"syztCondition").get("P_DS");
		if (syztCursor != null) {
			// 总价值
			Double syztTotalJiaz = 0.00;
			for (Object syzt : syztCursor) {
				if (syzt != null) {
					Map<String, Object> map = (Map<String, Object>) syzt;
					syztTotalJiaz += Double.valueOf(map.get("JIAZ").toString());
				}
			}
			request.setAttribute("syztTotalJiaz", syztTotalJiaz);

			// 将页面表体凑满 6 行
			if (syztCursor.size() < 6) {
				int difference = 6 - syztCursor.size();
				for (int i = 0; i < difference; i++) {
					syztCursor.add(null);
				}
			}
		}
		request.setAttribute("syztCursor", syztCursor);

		// 是否存在下级（sub）单位
		String hasSub = "false";
		int count = bdOrgService.getCountByParentid(currentOrgId);
		if (count > 0) {
			hasSub = "true";
		}
		request.setAttribute("hasSub", hasSub);
		return "sup/home/main";
	}

	@ResponseBody
	@RequestMapping(value = "/orgTree", method = RequestMethod.POST)
	public String orgTree() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", currentUser.getTopOrgId());
		return homeService.orgTree(map);
	}

	@ResponseBody
	@RequestMapping(value = "/switchOrg", method = RequestMethod.POST)
	public String switchOrg(@RequestParam("orgidStr") String orgidStr,
			HttpServletRequest request) {
		currentUser.setCurrentOrgId(orgidStr);
		request.getSession().setAttribute(CURRENT_USER, currentUser);
		return "SUCCESS";
	}

}