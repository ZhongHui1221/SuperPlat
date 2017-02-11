package com.zheling.org.distribution.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zheling.base.controller.BaseController;
import com.zheling.base.entity.BdAstYongt;
import com.zheling.base.service.BdDeptService;
import com.zheling.base.service.WorkflowService;
import com.zheling.base.util.Page;
import com.zheling.org.distribution.service.SlpzService;

@Controller
@RequestMapping("/orgSlpz")
public class SlpzController extends BaseController {

	// 本模块使用独立的 PAGE_SIZE
	private static final int PAGE_SIZE = 20;

	@Autowired
	private SlpzService slpzService;
	@Autowired
	private BdDeptService bdDeptService;
	@Autowired
	private WorkflowService workflowService;

	@RequestMapping(value = "/main/{pageId}/{currentRoleCode}", method = RequestMethod.GET)
	public String main(@PathVariable(value = "pageId", required = true) String pageId,
			@PathVariable(value = "currentRoleCode", required = true) String currentRoleCode,
			@RequestParam(value = "keyvalueStr", defaultValue = "") String keyvalueStr,
			@RequestParam(value = "condsql", defaultValue = "") String condsql,
			@RequestParam(value = "checkedIdStr", defaultValue = "") String checkedIdStr,
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "pzzt", defaultValue = "0") String pzzt,
			@RequestParam(value = "sortpartStr", defaultValue = "") String sortpartStr,
			HttpServletRequest request) throws Exception {
		request.setAttribute("pageId", pageId);
		// 回传当前用户角色码
		request.setAttribute("currentRoleCode", currentRoleCode);
		if ("wysl".equalsIgnoreCase(pageId) && "001".equalsIgnoreCase(currentRoleCode)) {// 来自使用人的我要申领(待提交)
			pzzt = "0";
			condsql = " and C.PEIZJHOBJID IS NULL";
		} else if ("auditting".equalsIgnoreCase(pageId) && "001".equalsIgnoreCase(currentRoleCode)) {// 来自使用人的审核中
			pzzt = "2";
		} else if ("auditted".equalsIgnoreCase(pageId) && "001".equalsIgnoreCase(currentRoleCode)) {// 来自使用人的已审核
			pzzt = "3";
		} else if ("peizgl".equalsIgnoreCase(pageId)
				&& ("002".equalsIgnoreCase(currentRoleCode) || "003"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "1";
			condsql = " and C.PEIZJHOBJID IS NULL";
		} else if ("auditting".equalsIgnoreCase(pageId)
				&& ("002".equalsIgnoreCase(currentRoleCode) || "003"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "2";
		} else if ("auditted".equalsIgnoreCase(pageId)
				&& ("002".equalsIgnoreCase(currentRoleCode) || "003"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "3";
		} else if ("peizgl".equalsIgnoreCase(pageId)
				&& ("004".equalsIgnoreCase(currentRoleCode) || "005"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "1";
			condsql = " and C.PEIZJHOBJID IS NULL";
		} else if ("auditting".equalsIgnoreCase(pageId)
				&& ("004".equalsIgnoreCase(currentRoleCode) || "005"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "2";
		} else if ("auditted".equalsIgnoreCase(pageId)
				&& ("004".equalsIgnoreCase(currentRoleCode) || "005"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "3";
		}
		/* 总体情况查询 —— BEGIN */

		// 总体情况查询条件组装
		Map<String, Object> daitjTotalCon = new HashMap<String, Object>(baseCondition);
		setDeptid(daitjTotalCon);
		daitjTotalCon.put("pzzt", pzzt);
		daitjTotalCon.put("keyvalue", keyvalueStr);

		// 查询
		slpzService.findDaitjTotal(daitjTotalCon);
		// 查询返回的游标
		List<Object> shenldTotalCursor = (List<Object>) daitjTotalCon.get("P_DS");
		/* 总体情况查询 —— END */
		/* 详情查询 —— END */
		// 详情查询条件组装
		int totalCount = 0;
		if (shenldTotalCursor != null && shenldTotalCursor.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) shenldTotalCursor.get(0);
			totalCount = Integer.parseInt(map.get("CNT").toString());
		}

		Page<Object> page = new Page<Object>(PAGE_SIZE, pageNo, totalCount);
		int fromIndex = (page.getPageNo() - 1) * PAGE_SIZE + 1;
		int endIndex = fromIndex + PAGE_SIZE - 1;

		Map<String, Object> daitjDetailCon = new HashMap<String, Object>(daitjTotalCon);
		daitjDetailCon.put("snum", fromIndex);
		daitjDetailCon.put("enum", endIndex);
		daitjDetailCon.put("sortpart", sortpartStr);
		daitjDetailCon.put("condsql", condsql);
		// 查询
		if (true) {
			slpzService.findDaitjDetail(daitjDetailCon);
		}
		// 查询返回的游标
		List<Object> shenldDetailCursor = (List<Object>) daitjDetailCon.get("P_DS");
		if (shenldDetailCursor != null && shenldDetailCursor.size() > 0) {
			// for(Object sheld : shenldDetailCursor){
			// Map<String, Object> tempMap = (Map<String, Object>) sheld;
			// BigDecimal yuj = (BigDecimal) tempMap.get("YUJDJ");
			// }
			page.setResults(shenldDetailCursor);
		}
		request.setAttribute(page.PAGE_NAME, page);
		request.setAttribute("keyvalueStr", keyvalueStr);
		request.setAttribute("condsql", condsql);
		request.setAttribute("pzzt", pzzt);
		request.setAttribute("sortpartStr", sortpartStr);
		/* 详情查询 —— END */
		if ("002".equalsIgnoreCase(currentRoleCode) || "003".equalsIgnoreCase(currentRoleCode)) {// 部门领导、部门资产管理员配置管理
			return "org/home/shenling/bm_peizgl";
		} else if ("004".equalsIgnoreCase(currentRoleCode)
				|| "005".equalsIgnoreCase(currentRoleCode)) {// 单位领导、单位资产管理员配置管理
			return "org/home/shenling/dw_peizgl";
		} else {// 否则是使用人
			return "org/home/shenling/syr_wysl";
		}
	}

	@RequestMapping(value = "/getWf/{currentRoleCode}/{checkedIdStr}", method = RequestMethod.GET)
	public String getWf(@PathVariable(value = "checkedIdStr", required = true) String checkedIdStr,
			HttpServletRequest request) throws Exception {
		// 条件组装
		Map<String, Object> wfCondition = new HashMap<String, Object>(baseCondition);
		setDeptid(wfCondition);
		wfCondition.put("bsrwid", checkedIdStr);
		wfCondition.put("bsmodelid", "C73CFD8BFCD848D28605799F91A8BB41");
		// 查询
		workflowService.findWf(wfCondition);
		// 查询返回的游标
		List<Object> wfCursor = (List<Object>) wfCondition.get("P_DS");
		request.setAttribute("wfCursor", wfCursor);
		return "org/home/shenling/sl_liucheng";
	}

	@RequestMapping(value = "/getShenlzcXqpage/{currentRoleCode}/{checkedIdStr}/{objnameStr}", method = RequestMethod.GET)
	public String getShenlzcXqpage(
			@PathVariable(value = "checkedIdStr", required = true) String checkedIdStr,
			@PathVariable(value = "objnameStr", required = true) String objnameStr,
			HttpServletRequest request) {
		request.setAttribute("checkedIdStr", checkedIdStr);
		request.setAttribute("objnameStr", objnameStr);
		/* 查询申领用途 --BEGIN */
		List<BdAstYongt> ytList = slpzService.findYongt();
		request.setAttribute("yt", ytList);
		/* 查询申领用途 --END */
		return "org/home/shenling/sl_zcxq";
	}

	@RequestMapping(value = "/getShenblcpage/{currentRoleCode}}", method = RequestMethod.POST)
	public String getShenblcpage(
			@RequestParam(value = "checkedIdStr", required = true) String checkedIdStr,
			@RequestParam(value = "pzzt", defaultValue = "0") String pzzt,
			@RequestParam(value = "keyvalueStr", defaultValue = "") String keyvalueStr,
			@RequestParam(value = "condsql", defaultValue = "") String condsql,
			@RequestParam(value = "wfzt", defaultValue = "1") String wfzt,
			@RequestParam(value = "shenpyj", defaultValue = "") String shenpyj,
			HttpServletRequest request) {
		return "org/home/shenling/sl_zcxq";
	}

	@RequestMapping(value = "/getBmCheckPage/{currentRoleCode}/{checkedIdStr}", method = RequestMethod.GET)
	public String getBmCheckPage(
			@PathVariable(value = "checkedIdStr", required = true) String checkedIdStr,
			HttpServletRequest request) {
		String path = request.getContextPath();
		System.out.println(path);
		request.setAttribute("checkedIdStr", checkedIdStr);
		return "org/home/shenling/sl_shenhe_bumen";
	}

	@RequestMapping(value = "/check/{currentRoleCode}/{checkedIdStr}", method = RequestMethod.POST)
	public String check() {

		return "";
	}

	@ResponseBody
	@RequestMapping(value = "/addSld/{currentRoleCode}", method = RequestMethod.PUT)
	public String addSld(@RequestParam(name = "zicmc", required = true) String zicmc,
			@RequestParam(name = "zicflid", required = true) String zicflid,
			@RequestParam(name = "guigxh", required = true) String guigxh,
			@RequestParam(name = "yujdj", required = true) String yujdj,
			@RequestParam(name = "yujjz", required = true) String yujjz,
			@RequestParam(name = "shul", required = true) String shul,
			@RequestParam(name = "shenlyy", required = true) String shenlyy,
			@RequestParam(name = "shenlytid", required = true) String shenlytid) throws Exception {
		// 生成主键ID值
		UUID uuid = UUID.randomUUID();
		String rwid = uuid.toString().replace("-", "");
		// 获取申领人信息
		Map<String, Object> slrInfo = new HashMap<String, Object>(baseCondition);
		setDeptid(slrInfo);
		String shenqbmid = slrInfo.get("deptid").toString();
		String shenqrid = slrInfo.get("userid").toString();
		// 校验数值型字符串
		boolean checkYujdj = decimalCheck(yujdj);
		boolean checkYujjj = decimalCheck(yujjz);
		boolean checkShul = decimalCheck(shul);
		// 解析data
		// System.out.println(params);
		// String paramsTrans = new
		// String(params.getBytes("ISO-8859-1"),"UTF-8");
		// params = java.net.URLDecoder.decode(paramsTrans , "UTF-8");
		// System.out.println(params);
		// 组装条件
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		if (checkYujdj && checkYujjj && checkShul) {
			condition.put("yujdj", yujdj);
			condition.put("yujjz", yujjz);
			condition.put("shul", shul);
		}
		setDeptid(condition);
		condition.put("bsrwid", rwid);
		condition.put("zicmc", zicmc);
		condition.put("zicflid", zicflid);
		condition.put("guigxh", guigxh);
		condition.put("shenqbmid", shenqbmid);
		condition.put("shenqrid", shenqrid);
		condition.put("shenlyy", shenlyy);
		condition.put("shenlytid", shenlytid);
		return slpzService.createShenld(condition);
//		 return "success";
	}

	/**
	 * 删除申领单 --hugo
	 * 
	 * @param currentRoleCode
	 *            当前用户角色code
	 * @param checkedIdStr
	 *            要删除的申领单RWID,多个用,隔开
	 * @param keyvalue
	 *            关键字
	 * @param condsql
	 *            条件
	 * @param pzzt
	 *            配置状态
	 * @return 若删除过程有返回字段,则返回给前端,成功则不返回
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteShenld/{currentRoleCode}", method = RequestMethod.DELETE)
	public String deleteShenld(
			@PathVariable(value = "currentRoleCode", required = true) String currentRoleCode,
			@RequestParam(value = "checkedIdStr", defaultValue = "") String checkedIdStr,
			@RequestParam(value = "keyvalue", defaultValue = "") String keyvalue,
			@RequestParam(value = "condsql", defaultValue = "") String condsql,
			@RequestParam(value = "pzzt", defaultValue = "0") String pzzt) throws Exception {
		// 组装条件
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		setDeptid(condition);
		condition.put("peizdid", checkedIdStr);
		condition.put("pzzt", pzzt);
		condition.put("keyvalue", keyvalue);
		condition.put("condsql", condsql);
		return slpzService.deleteShenld(condition);
	}

	@ResponseBody
	@RequestMapping(value = "/submitShenld/{currentRoleCode}", method = RequestMethod.PUT)
	public String submitShenld(
			@PathVariable(value = "currentRoleCode", required = true) String currentRoleCode,
			@RequestParam(value = "checkedIdStr", defaultValue = "") String checkedIdStr,
			@RequestParam(value = "keyvalue", defaultValue = "") String keyvalue,
			@RequestParam(value = "condsql", defaultValue = "") String condsql,
			@RequestParam(value = "pzzt", defaultValue = "0") String pzzt,
			@RequestParam(value = "wfzt", defaultValue = "1") String wfzt,
			@RequestParam(value = "shenpyj", defaultValue = "") String shenpyj,
			@RequestParam(value = "pageId", defaultValue = "") String pageId) throws Exception {
		if ("wysl".equalsIgnoreCase(pageId) && "001".equalsIgnoreCase(currentRoleCode)) {// 来自使用人的我要申领(待提交)
			pzzt = "0";
			wfzt = "1";
		} else if ("auditting".equalsIgnoreCase(pageId) && "001".equalsIgnoreCase(currentRoleCode)) {// 来自使用人的审核中
			pzzt = "2";
			wfzt = "4";
			shenpyj = "申请人取消申报";
			condsql = "";
		} else if ("auditted".equalsIgnoreCase(pageId) && "001".equalsIgnoreCase(currentRoleCode)) {// 来自使用人的已审核
			pzzt = "3";
		} else if ("peizgl".equalsIgnoreCase(pageId)
				&& ("002".equalsIgnoreCase(currentRoleCode) || "003"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "1";
			condsql = " and C.PEIZJHOBJID IS NULL";
		} else if ("auditting".equalsIgnoreCase(pageId)
				&& ("002".equalsIgnoreCase(currentRoleCode) || "003"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "2";
		} else if ("auditted".equalsIgnoreCase(pageId)
				&& ("002".equalsIgnoreCase(currentRoleCode) || "003"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "3";
		} else if ("peizgl".equalsIgnoreCase(pageId)
				&& ("004".equalsIgnoreCase(currentRoleCode) || "005"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "1";
			condsql = " and C.PEIZJHOBJID IS NULL";
		} else if ("auditting".equalsIgnoreCase(pageId)
				&& ("004".equalsIgnoreCase(currentRoleCode) || "005"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "2";
		} else if ("auditted".equalsIgnoreCase(pageId)
				&& ("004".equalsIgnoreCase(currentRoleCode) || "005"
						.equalsIgnoreCase(currentRoleCode))) {
			pzzt = "3";
		}
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		setDeptid(condition);
		condition.put("peizdid", checkedIdStr);
		condition.put("pzzt", pzzt);// 0和空为待提交，1为待审核，2为审核中，3为审核完成
		condition.put("keyvalue", keyvalue);
		condition.put("condsql", condsql);
		condition.put("wfzt", wfzt);// 0 退回，1提交 2 不同意，3 同意，4 取回
		condition.put("shenpyj", shenpyj);
		return slpzService.submitShenld(condition);
	}

	/**
	 * 为查询条件设置部门 ID by WGJ
	 * 
	 * @param condition
	 */
	private void setDeptid(Map<String, Object> condition) {
		String currentRoleCode = currentUser.getCurrentRoleCode();
		// 如果切换到“使用人（001）”、“部门资产管理员（002）”或“部门领导（003）”
		if ("001".equals(currentRoleCode) || "002".equals(currentRoleCode)
				|| "003".equals(currentRoleCode)) {
			// 部门信息查询 - 共享条件
			Map<String, Object> deptsCondition = new HashMap<String, Object>(condition);

			try {
				bdDeptService.findDepts(deptsCondition);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// 查询返回的游标
			List<Object> deptsCursor = (List<Object>) deptsCondition.get("P_DS");
			// 获取 deptid 并将其作为查询条件
			if (deptsCursor != null && deptsCursor.size() > 0) {
				Map<String, Object> map = (Map<String, Object>) deptsCursor.get(0);
				condition.put("deptid", map.get("RWID"));
			}
		}
	}

	/**
	 * 校验数值型字符串是否是两位小数或者整数 by hugo
	 * 
	 * @param target
	 *            校验目标字符串
	 * @return
	 */
	private boolean decimalCheck(String target) {
		// 数据校验
		String regEx = "^[0-9]+(.[0-9]{2})?$";
		Pattern pattern = Pattern.compile(regEx);
		Matcher matcher = pattern.matcher(target);
		return matcher.matches();
	}

}