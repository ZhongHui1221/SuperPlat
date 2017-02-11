package com.zheling.sup.query.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zheling.base.controller.BaseController;
import com.zheling.base.entity.BdDept;
import com.zheling.base.entity.BdOrg;
import com.zheling.base.service.BdDeptService;
import com.zheling.base.service.BdOrgService;
import com.zheling.sup.query.service.FbqkService;

@Controller
@RequestMapping("/Query/Fbqk")
public class FbqkController extends BaseController {

	@Autowired
	private FbqkService fbqkService;
	@Autowired
	private BdOrgService bdOrgService;
	@Autowired
	private BdDeptService bdDeptService;

	@RequestMapping(value = "/main/{typeStr}/{orgidStr}", method = RequestMethod.GET)
	public String main(@PathVariable("typeStr") String typeStr,
			@PathVariable("orgidStr") String orgidStr,
			HttpServletRequest request) {
		// 通过主菜单访问分布情况时
		if ("0".equals(orgidStr)) {
			orgidStr = currentUser.getCurrentOrgId();
		}

		// 路径集合
		List<Object> pathList = new ArrayList<Object>();
		String deptidStr = "";
		// 如果穿透到部门层
		if ("2".equals(typeStr)) {
			// 此时单位 ID 即是部门 ID
			deptidStr = orgidStr;
			// 获取部门信息
			BdDept dept = bdDeptService.getEntity(deptidStr);
			// 将当前部门添加至路径集合
			pathList.add(dept);
			// 重新为单位 ID 赋值
			orgidStr = dept.getOrgid();
		}

		String topOrgid = currentUser.getCurrentOrgId();
		BdOrg org = bdOrgService.getEntity(orgidStr);
		recursion(topOrgid, org, pathList);
		// 反转路径集合
		Collections.reverse(pathList);
		request.setAttribute("orgs", pathList);
		request.setAttribute("fbqkOrgid", orgidStr);
		request.setAttribute("fbqkDeptid", deptidStr);

		// 分布情况查询 - 条件组装
		Map<String, Object> fbqkCondition = new HashMap<String, Object>(
				baseCondition);
		fbqkCondition.put("orgid", orgidStr);
		fbqkCondition.put("deptid", deptidStr);

		// 闲置房产
		if ("xzfc".equals(extra)) {
			fbqkCondition
					.put("condsql",
							"AND AST_COMMON.ISFW (2, A.ZICFLID) = 1 AND A.SHIYZKID IN ('3F5B09C1400000010A9442FDA2091273', '3F5B0C396000000170CA046A71F80C5D')");
			request.setAttribute("extra", extra);
		}

		try {
			fbqkService.findFbqk(fbqkCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> fbqkCursor = (List<Object>) fbqkCondition.get("P_DS");
		if (fbqkCursor != null) {
			// 总价值
			Double fbqkTotalJiaz = 0.00;
			for (Object fbqk : fbqkCursor) {
				Map<String, Object> map = (Map<String, Object>) fbqk;
				fbqkTotalJiaz += Double.valueOf(map.get("JIAZ").toString());
			}
			request.setAttribute("fbqkTotalJiaz", fbqkTotalJiaz);
		}
		request.setAttribute("fbqkCursor", fbqkCursor);
		return "sup/query/fbqk/main";
	}

	/**
	 * 递归算法查询上级单位 by WGJ
	 * 
	 * @param topOrgid
	 * @param org
	 * @param list
	 */
	private void recursion(String topOrgid, BdOrg org, List<Object> list) {
		if (org != null) {
			list.add(org);
			if (!topOrgid.equals(org.getRwid())) {
				String parentid = org.getParentid();
				BdOrg supOrg = bdOrgService.getEntity(parentid);
				recursion(topOrgid, supOrg, list);
			}
		}
	}

}