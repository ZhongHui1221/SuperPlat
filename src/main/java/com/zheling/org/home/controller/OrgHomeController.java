package com.zheling.org.home.controller;

import java.sql.SQLException;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.zheling.base.controller.BaseController;
import com.zheling.base.service.AstChuzService;
import com.zheling.base.service.AstGengzService;
import com.zheling.base.service.AstTiaojService;
import com.zheling.base.service.AstTouzService;
import com.zheling.base.service.AstWeixService;
import com.zheling.base.service.AstZujService;
import com.zheling.base.service.BdDeptService;
import com.zheling.base.service.WorkflowService;
import com.zheling.base.util.Page;
import com.zheling.org.notice.service.NoticeService;
import com.zheling.sup.query.service.BsAstCardService;

@Controller
@RequestMapping("/orgHome")
public class OrgHomeController extends BaseController {

	// 公告 Map，每次执行公告查询时均会更新该对象的内容
	private Map<String, Object> noticesMap;

	@Autowired
	private BsAstCardService bsAstCardService;
	@Autowired
	private WorkflowService workflowService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private BdDeptService bdDeptService;
	@Autowired
	private AstWeixService astWeixService;
	@Autowired
	private AstChuzService astChuzService;
	@Autowired
	private AstTiaojService astTiaojService;
	@Autowired
	private AstGengzService astGengzService;
	@Autowired
	private AstZujService astZujService;
	@Autowired
	private AstTouzService astTouzService;

	/**
	 * 待办事项查询 by WGJ
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/findDbsx", method = RequestMethod.POST)
	public String findDbsx() {
		// 查询条件组装
		Map<String, Object> dbsxCondition = new HashMap<String, Object>(baseCondition);
		setDeptid(dbsxCondition);

		try {
			workflowService.findDbsx(dbsxCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> dbsxCursor = (List<Object>) dbsxCondition.get("P_DS");
		return JSON.toJSONString(dbsxCursor);
	}

	/**
	 * 公告查询 by WGJ
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/findNotices", method = RequestMethod.POST)
	public String findNotices() {
		// 查询条件组装
		Map<String, Object> noticesCondition = new HashMap<String, Object>(baseCondition);
		setDeptid(noticesCondition);

		try {
			noticeService.findNotices(noticesCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> noticesCursor = (List<Object>) noticesCondition.get("P_DS");
		noticesMap = new HashMap<String, Object>();
		for (int i = 0; i < noticesCursor.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) noticesCursor.get(i);
			// 更新公告 Map
			noticesMap.put(map.get("RWID").toString(), map);
		}
		return JSON.toJSONString(noticesCursor);
	}

	/**
	 * 公告详情 by WGJ
	 * 
	 * @param rwid
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/noticeDetail/{rwid}", method = RequestMethod.GET)
	public String noticeDetail(@PathVariable("rwid") String rwid, HttpServletRequest request) {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("bsid", rwid);
		condition.put("fileindex", "-1");

		try {
			noticeService.findNoticeAtts(condition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.setAttribute("attsCursor", condition.get("P_DS"));
		request.setAttribute("notice", noticesMap.get(rwid));
		return "org/notice/detail";
	}

	/**
	 * 外层 iframe - 角色切换 by WGJ
	 * 
	 * @param orgidStr
	 * @param roleidStr
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/index/{orgidStr}/{roleidStr}", method = RequestMethod.GET)
	public String index(@PathVariable("orgidStr") String orgidStr,
			@PathVariable("roleidStr") String roleidStr, HttpServletRequest request) {
		// 回传版本信息
		request.setAttribute("version", getConfigInfo("version"));

		/* 角色切换 —— BEGIN */
		List<Object> roleCursor = currentUser.getRoleCursor();
		if ("0".equals(roleidStr)) {
			roleidStr = getDefaultValueFromRoleCursor("RWID", roleCursor);
		}
		currentUser.setCurrentRoleId(roleidStr);
		currentUser.setCurrentRoleCode(getValueFromRoleCursor("OBJCODE", roleidStr, roleCursor));
		currentUser.setCurrentRoleName(getValueFromRoleCursor("OBJNAME", roleidStr, roleCursor));
		request.getSession().setAttribute(CURRENT_USER, currentUser);
		/* 角色切换 —— END */
		return "org/home/index";
	}

	/**
	 * 内层 iframe - 所有资产 by WGJ
	 * 
	 * @param pageNo
	 * @param keyvalueStr
	 * @param sortpartStr
	 * @param viewMode
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/main", method = RequestMethod.POST)
	public String main(@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "keyvalueStr", defaultValue = "") String keyvalueStr,
			@RequestParam(value = "sortpartStr", defaultValue = "") String sortpartStr,
			@RequestParam(value = "viewMode", required = false) String viewMode,
			HttpServletRequest request) {
		// 获取当前角色编号
		String currentRoleCode = currentUser.getCurrentRoleCode();

		// 如果切换到“单位领导（005）”或“财务制单人员（006）”
		if ("005".equals(currentRoleCode) || "006".equals(currentRoleCode)) {
			// 直接重定向至“总体情况”
			return "redirect:/Query/Ztqk/main";
		}

		// 接收高级查询的常用参数并直接回传
		String zicmc = request.getParameter("zicmc");
		String guigxh = request.getParameter("guigxh");
		String yuanzcbh_min = request.getParameter("yuanzcbh_min");
		String yuanzcbh_max = request.getParameter("yuanzcbh_max");
		String objcode_min = request.getParameter("objcode_min");
		String objcode_max = request.getParameter("objcode_max");
		String gouzrq_begin = request.getParameter("gouzrq_begin");
		String gouzrq_end = request.getParameter("gouzrq_end");
		String caiwrzrq_begin = request.getParameter("caiwrzrq_begin");
		String caiwrzrq_end = request.getParameter("caiwrzrq_end");
		String danj_min = request.getParameter("danj_min");
		String danj_max = request.getParameter("danj_max");
		request.setAttribute("zicmc", zicmc);
		request.setAttribute("guigxh", guigxh);
		request.setAttribute("yuanzcbh_min", yuanzcbh_min);
		request.setAttribute("yuanzcbh_max", yuanzcbh_max);
		request.setAttribute("objcode_min", objcode_min);
		request.setAttribute("objcode_max", objcode_max);
		request.setAttribute("gouzrq_begin", gouzrq_begin);
		request.setAttribute("gouzrq_end", gouzrq_end);
		request.setAttribute("caiwrzrq_begin", caiwrzrq_begin);
		request.setAttribute("caiwrzrq_end", caiwrzrq_end);
		request.setAttribute("danj_min", danj_min);
		request.setAttribute("danj_max", danj_max);

		// 拼接 condsql
		String condsql = "";
		if (StringUtils.isNotBlank(zicmc)) {
			condsql += " AND C.ZICMC LIKE '%" + zicmc + "%'";
		}
		if (StringUtils.isNotBlank(guigxh)) {
			condsql += " AND C.GUIGXH LIKE '%" + guigxh + "%'";
		}
		if (StringUtils.isNotBlank(yuanzcbh_min)) {
			condsql += " AND C.YUANZCBH >= '" + yuanzcbh_min + "'";
		}
		if (StringUtils.isNotBlank(yuanzcbh_max)) {
			condsql += " AND C.YUANZCBH <= '" + yuanzcbh_max + "'";
		}
		if (StringUtils.isNotBlank(objcode_min)) {
			condsql += " AND C.OBJCODE >= '" + objcode_min + "'";
		}
		if (StringUtils.isNotBlank(objcode_max)) {
			condsql += " AND C.OBJCODE <= '" + objcode_max + "'";
		}
		if (StringUtils.isNotBlank(gouzrq_begin)) {
			condsql += " AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') >= '" + gouzrq_begin + "'";
		}
		if (StringUtils.isNotBlank(gouzrq_end)) {
			condsql += " AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '" + gouzrq_end + "'";
		}
		if (StringUtils.isNotBlank(caiwrzrq_begin)) {
			condsql += " AND TO_CHAR (C.CAIWRZRQ, 'YYYY-MM-DD') >= '" + caiwrzrq_begin + "'";
		}
		if (StringUtils.isNotBlank(caiwrzrq_end)) {
			condsql += " AND TO_CHAR (C.CAIWRZRQ, 'YYYY-MM-DD') <= '" + caiwrzrq_end + "'";
		}
		if (StringUtils.isNotBlank(danj_min)) {
			condsql += " AND C.DANJ >= " + danj_min;
		}
		if (StringUtils.isNotBlank(danj_max)) {
			condsql += " AND C.DANJ <= " + danj_max;
		}

		/* 卡片总体情况查询 —— BEGIN */
		// 查询条件组装
		Map<String, Object> cardsTotalCondition = new HashMap<String, Object>(baseCondition);
		cardsTotalCondition.put("querytype", "0");
		cardsTotalCondition.put("keyvalue", keyvalueStr);
		cardsTotalCondition.put("condsql", condsql);
		setDeptid(cardsTotalCondition);

		try {
			bsAstCardService.getCardsTotal(cardsTotalCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> cardsTotalCursor = (List<Object>) cardsTotalCondition.get("P_DS");
		/* 卡片总体情况查询 —— END */

		/* 卡片信息查询 —— BEGIN */
		// 分页模型封装
		int totalCount = 0;
		if (cardsTotalCursor != null && cardsTotalCursor.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) cardsTotalCursor.get(0);
			totalCount = Integer.parseInt(map.get("CNT").toString());
		}
		Page<Object> page = new Page<Object>(Page.PAGE_SIZE, pageNo, totalCount);
		int fromIndex = (page.getPageNo() - 1) * Page.PAGE_SIZE + 1;
		int endIndex = fromIndex + Page.PAGE_SIZE - 1;

		// 查询条件组装
		Map<String, Object> cardsCondition = new HashMap<String, Object>(cardsTotalCondition);
		cardsCondition.put("snum", fromIndex);
		cardsCondition.put("enum", endIndex);
		cardsCondition.put("sortpart", sortpartStr);

		try {
			bsAstCardService.findCards(cardsCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> cardsCursor = (List<Object>) cardsCondition.get("P_DS");
		page.setResults(cardsCursor);
		request.setAttribute(Page.PAGE_NAME, page);
		/* 卡片信息查询 —— END */
		request.setAttribute(PREFIX_PATH, prefixPath);
		request.setAttribute("keyvalueStr", keyvalueStr);
		request.setAttribute("sortpartStr", sortpartStr);

		// 切换单位时仍保持当前的视图模式
		if (viewMode == null) {
			Object tmpViewMode = request.getSession().getAttribute(VIEW_MODE);
			viewMode = (tmpViewMode != null) ? tmpViewMode.toString() : CARD_MODE;
		}
		request.getSession().setAttribute(VIEW_MODE, viewMode);

		if (LIST_MODE.equals(viewMode)) {
			return "org/home/main_list";
		} else if (IMG_LIST_MODE.equals(viewMode)) {
			return "org/home/main_imglist";
		} else {
			return "org/home/main_card";
		}
	}

	/**
	 * （取消）标记为公用资产 by WGJ
	 * 
	 * @param isPublic
	 * @param checkedIdStr
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/markAsPublic", method = RequestMethod.PUT)
	public String markAsPublic(@RequestParam("isPublic") String isPublic,
			@RequestParam(value = "checkedIdStr", required = false) String checkedIdStr)
			throws Exception {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("cardrwid", checkedIdStr);
		condition.put("querytype", "0");
		condition.put("sffz", "0");
		// isPublic：0 = 取消标记，1 = 标记为公用资产
		condition.put("isgy", isPublic);
		return bsAstCardService.markAsPublic(condition);
	}

	/**
	 * 申请报修 by WGJ
	 * 
	 * @param checkedIdStr
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/applyForRepair", method = RequestMethod.PUT)
	public String applyForRepair(
			@RequestParam(value = "checkedIdStr", required = false) String checkedIdStr)
			throws Exception {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		setDeptid(condition);
		condition.put("cardrwid", checkedIdStr);
		condition.put("querytype", "0");
		condition.put("sffz", "0");
		return astWeixService.applyForRepair(condition);
	}

	/**
	 * 申请处置 by WGJ
	 * 
	 * @param checkedIdStr
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/applyForDeal", method = RequestMethod.PUT)
	public String applyForDeal(
			@RequestParam(value = "checkedIdStr", required = false) String checkedIdStr)
			throws Exception {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		setDeptid(condition);
		condition.put("cardrwid", checkedIdStr);
		condition.put("querytype", "0");
		condition.put("sffz", "0");
		return astChuzService.applyForDeal(condition);
	}

	/**
	 * 申请转移 by WGJ
	 * 
	 * @param checkedIdStr
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/applyForTransfer", method = RequestMethod.PUT)
	public String applyForTransfer(
			@RequestParam(value = "checkedIdStr", required = false) String checkedIdStr)
			throws Exception {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		setDeptid(condition);
		condition.put("cardrwid", checkedIdStr);
		condition.put("querytype", "0");
		condition.put("sffz", "0");
		return astTiaojService.applyForTransfer(condition);
	}

	/**
	 * 申请更正 by WGJ
	 * 
	 * @param checkedIdStr
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/applyForCorrect", method = RequestMethod.PUT)
	public String applyForCorrect(
			@RequestParam(value = "checkedIdStr", required = false) String checkedIdStr)
			throws Exception {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		setDeptid(condition);
		condition.put("cardrwid", checkedIdStr);
		condition.put("querytype", "0");
		condition.put("sffz", "0");
		return astGengzService.applyForCorrect(condition);
	}

	/**
	 * 申请出租（借） by WGJ
	 * 
	 * @param checkedIdStr
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/applyForRent", method = RequestMethod.PUT)
	public String applyForRent(
			@RequestParam(value = "checkedIdStr", required = false) String checkedIdStr)
			throws Exception {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		setDeptid(condition);
		condition.put("cardrwid", checkedIdStr);
		condition.put("querytype", "0");
		condition.put("sffz", "0");
		// TODO 申请出租（借）待补全
		return astZujService.applyForRent(condition);
	}

	/**
	 * 申请投资 by WGJ
	 * 
	 * @param checkedIdStr
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/applyForInvest", method = RequestMethod.PUT)
	public String applyForInvest(
			@RequestParam(value = "checkedIdStr", required = false) String checkedIdStr)
			throws Exception {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		setDeptid(condition);
		condition.put("cardrwid", checkedIdStr);
		condition.put("querytype", "0");
		condition.put("sffz", "0");
		return astTouzService.applyForInvest(condition);
	}

	/**
	 * 申请归还 by WGJ
	 * 
	 * @param checkedIdStr
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/applyForReturn", method = RequestMethod.PUT)
	public String applyForReturn(
			@RequestParam(value = "checkedIdStr", required = false) String checkedIdStr)
			throws Exception {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		setDeptid(condition);
		condition.put("cardrwid", checkedIdStr);
		condition.put("querytype", "0");
		return astTiaojService.applyForReturn(condition);
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

}