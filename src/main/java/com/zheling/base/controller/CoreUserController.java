package com.zheling.base.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.code.kaptcha.Constants;
import com.zheling.base.component.GlobalComponent;
import com.zheling.base.entity.CoreUser;
import com.zheling.base.service.BdDeptService;
import com.zheling.base.service.BdOrgService;
import com.zheling.base.service.CoreUserService;
import com.zheling.base.thread.BaseDataQueryThread;
import com.zheling.base.util.DataProcessUtil;
import com.zheling.base.util.PromptUtil;
import com.zheling.base.vo.UserVo;

@Controller
public class CoreUserController extends BaseController {

	{
		// 新开线程执行基础数据查询
		new Thread(new BaseDataQueryThread()).start();
	}

	@Autowired
	private CoreUserService coreUserService;
	@Autowired
	private BdDeptService bdDeptService;
	@Autowired
	private BdOrgService bdOrgService;

	/**
	 * 登录页（集中式部署场景） by WGJ
	 * 
	 * @param code
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/{code:^[0-9].*$}", method = RequestMethod.GET)
	public String toLogin(@PathVariable("code") String code, HttpServletRequest request) {
		// 回传版本信息
		request.setAttribute("version", getConfigInfo("version"));

		this.code = code;
		request.setAttribute("code", code);

		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("objcode", code);

		try {
			bdOrgService.getOrgByCode(condition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		List<Object> orgCursor = (List<Object>) condition.get("P_DS");
		if (orgCursor != null && orgCursor.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) orgCursor.get(0);
			request.setAttribute("orgid", map.get("RWID"));
		}
		return "base/login_org";
	}

	/**
	 * 登录页（分散式部署场景） by WGJ
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/CoreUser/toLogin", method = RequestMethod.GET)
	public String toLogin(HttpServletRequest request) {
		// 回传版本信息
		request.setAttribute("version", getConfigInfo("version"));
		return "base/login_org";
	}

	@ResponseBody
	@RequestMapping(value = "/CoreUser/login", method = RequestMethod.POST)
	public String login(CoreUser coreUser, HttpServletRequest request) {
		String sessionKey = request.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY)
				.toString().toLowerCase();
		String inputKey = request.getParameter("inputKey").toString().toLowerCase();
		if (!sessionKey.equals(inputKey)) {
			return "请输入正确的验证码";
		}

		// 从配置文件中读取单位 ID
		String orgid = getConfigInfo("orgid");
		// 如未能取到，则表明当前为集中式部署场景
		if (StringUtils.isBlank(orgid)) {
			// 尝试从请求中获取
			orgid = coreUser.getOrgid();
		}

		// 登录验证 - 条件组装
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", orgid);
		map.put("zhanghm", coreUser.getZhanghm());
		map.put("psw", DataProcessUtil.md5(coreUser.getPsw()));

		try {
			coreUserService.login(map);
		} catch (Exception e) {
			e.printStackTrace();
			String[] messageArr = e.getMessage().trim().split("\n");
			return PromptUtil.getExceptionMessage(messageArr[0]);
		}

		// 登录验证返回的用户信息游标
		List<Object> userCursor = (List<Object>) map.get("P_DS1");
		// 登录验证返回的角色信息游标
		List<Object> roleCursor = (List<Object>) map.get("P_DS2");

		String roleid = getDefaultValueFromRoleCursor("RWID", roleCursor);
		if (StringUtils.isBlank(roleid)) {
			return "非法的角色！";
		}

		String edition = "";
		String rolecode = getDefaultValueFromRoleCursor("OBJCODE", roleCursor);
		if ("008".equals(rolecode) || "009".equals(rolecode)) {
			edition = "sup";
		} else {
			edition = "org";
		}

		// 将各类信息组装进 Vo，并将其存放至 Session
		UserVo userVo = new UserVo();
		userVo.setUserCursor(userCursor);
		userVo.setRoleCursor(roleCursor);
		userVo.setId(getDefaultValueFromCursor("RWID", userCursor));
		userVo.setName(getDefaultValueFromCursor("OBJNAME", userCursor));
		userVo.setDanwxzlxcode(getDefaultValueFromCursor("DANWXZLXCODE", userCursor));
		userVo.setTopOrgId(orgid);
		userVo.setCurrentOrgId(orgid);
		userVo.setCurrentRoleId(roleid);
		userVo.setCurrentRoleCode(rolecode);
		userVo.setCurrentRoleName(getDefaultValueFromRoleCursor("OBJNAME", roleCursor));

		// 销毁旧的 Session
		request.getSession().invalidate();
		request.getSession().setAttribute(CURRENT_USER, userVo);
		return edition + "," + orgid + "," + roleid;
	}

	/**
	 * 注册页（集中式部署场景） by WGJ
	 * 
	 * @param code
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/{code:^[0-9].*$}/register", method = RequestMethod.GET)
	public String toRegister(@PathVariable("code") String code, HttpServletRequest request) {
		this.code = code;
		request.setAttribute("code", code);

		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("objcode", code);

		try {
			bdOrgService.getOrgByCode(condition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		List<Object> orgCursor = (List<Object>) condition.get("P_DS");
		if (orgCursor != null && orgCursor.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) orgCursor.get(0);
			String orgid = map.get("RWID").toString();
			request.setAttribute("orgid", orgid);

			Map<String, Object> deptCondition = new HashMap<String, Object>();
			deptCondition.put("orgid", orgid);
			request.setAttribute("deptTree", bdDeptService.deptTree(deptCondition));
		}

		request.setAttribute("roleList", GlobalComponent.roleList);
		request.setAttribute("zjList", GlobalComponent.zjList);
		return "base/register_org";
	}

	/**
	 * 个人资料页 by WGJ
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/CoreUser/personal", method = RequestMethod.GET)
	public String personal(HttpServletRequest request) {
		String orgid = currentUser.getCurrentOrgId();
		request.setAttribute("edition", currentUser.getCurrentEdition());

		Map<String, Object> userCondition = new HashMap<String, Object>();
		userCondition.put("orgid", orgid);
		userCondition.put("type", "0");
		userCondition.put("rwid", currentUser.getId());

		try {
			coreUserService.findUsers(userCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		List<Object> userCursor = (List<Object>) userCondition.get("P_DS");
		request.setAttribute("personal", userCursor.get(0));

		Map<String, Object> deptCondition = new HashMap<String, Object>();
		deptCondition.put("orgid", orgid);
		request.setAttribute("deptTree", bdDeptService.deptTree(deptCondition));

		request.setAttribute("roleList", GlobalComponent.roleList);
		request.setAttribute("zjList", GlobalComponent.zjList);
		return "base/personal";
	}

	@ResponseBody
	@RequestMapping(value = "/CoreUser/register", method = RequestMethod.POST)
	public String register(CoreUser coreUser) throws Exception {
		// 用户注册 - 条件组装
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("orgid", coreUser.getOrgid());
		condition.put("zhanghm", coreUser.getZhanghm());
		condition.put("objname", coreUser.getObjname());
		condition.put("psw", DataProcessUtil.md5(coreUser.getPsw()));
		condition.put("shoujh", coreUser.getShoujh());
		condition.put("youx", coreUser.getYoux());
		condition.put("diz", coreUser.getDiz());
		condition.put("des", coreUser.getDes());
		condition.put("roleid", coreUser.getRoleids());
		condition.put("deptid", coreUser.getMngdepids());
		condition.put("shenfzh", coreUser.getShenfzh());
		// 0：男，1：女
		condition.put("xingb", coreUser.getXingb());
		condition.put("toux", coreUser.getToux());
		// 0：无需审核，1：需要审核
		condition.put("needaudit", 0);
		condition.put("zhijid", coreUser.getZhijid());
		// 0：不在编，1：在编
		condition.put("shifzb", coreUser.getShifzb());
		return coreUserService.register(condition);
	}

	@ResponseBody
	@RequestMapping(value = "/CoreUser/modify", method = RequestMethod.PUT)
	public String modify(CoreUser coreUser) throws Exception {
		// 修改用户 - 条件组装
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("yonghid", currentUser.getId());
		condition.put("juesid", coreUser.getRoleids());
		condition.put("bumid", coreUser.getMngdepids());
		condition.put("shoujh", coreUser.getShoujh());
		condition.put("zhijid", coreUser.getZhijid());
		// 0：不在编，1：在编
		condition.put("shifzb", coreUser.getShifzb());
		condition.put("oldpwd", "NULL");
		condition.put("newpwd", DataProcessUtil.md5(coreUser.getPsw()));
		condition.put("youx", coreUser.getYoux());
		condition.put("diz", coreUser.getDiz());
		condition.put("shenfzh", coreUser.getShenfzh());
		condition.put("xingm", coreUser.getObjname());
		condition.put("denglm", coreUser.getZhanghm());
		// 0：男，1：女
		condition.put("xingb", coreUser.getXingb());
		return coreUserService.modify(condition);
	}

	@RequestMapping(value = "/CoreUser/registered", method = RequestMethod.GET)
	public String registered(HttpServletRequest request) {
		request.setAttribute("code", code);
		return "base/registered";
	}

	@RequestMapping(value = "/CoreUser/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/" + code;
	}

	/**
	 * 待审核用户页 by WGJ
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/CoreUser/toUnaudited", method = RequestMethod.GET)
	public String toUnaudited(HttpServletRequest request) {
		return "base/unaudited_user";
	}

	/**
	 * 审核通过用户页 by WGJ
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/CoreUser/toAudited", method = RequestMethod.GET)
	public String toAudited(HttpServletRequest request) {
		return "base/audited_user";
	}

}