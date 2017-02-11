package com.zheling.org.notice.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.zheling.base.controller.BaseController;
import com.zheling.org.notice.service.NoticeService;
import com.zheling.org.notice.vo.NoticeListVo;

@Controller
@RequestMapping("/Notice")
public class NoticeController extends BaseController {

	// 公告 Map，每次执行公告查询时均会更新该对象的内容
	private Map<String, Object> noticesMap;
	// 公告 ID，由后端生成的通用唯一识别码
	private String noticeId;

	@Autowired
	private NoticeService noticeService;

	/**
	 * 公告发布页 by WGJ
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/toAdd", method = RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {
		request.setAttribute("deptTree", noticeService.deptUserTree(baseCondition));
		return "org/notice/edit";
	}

	/**
	 * 添加公告 by WGJ
	 * 
	 * @param title
	 * @param msg
	 * @param jiezrq
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String add(@RequestParam("title") String title, @RequestParam("msg") String msg,
			@RequestParam("jiezrq") String jiezrq, HttpServletRequest request) throws Exception {
		Map<String, Object> addCondition = new HashMap<String, Object>(baseCondition);
		noticeId = getUUID();
		addCondition.put("rwid", noticeId);
		addCondition.put("nstype", "GG");
		addCondition.put("title", title);
		addCondition.put("msg", msg);
		addCondition.put("jiezrq", jiezrq);
		return noticeService.addNotice(addCondition);
	}

	/**
	 * 附件上传 by WGJ
	 * 
	 * @param fileindex
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public void upload(@RequestParam("fileindex") String fileindex, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String newFileTitle = getUUID();
		List<String> oldFilesNames = commonsUpload(newFileTitle, request, response);

		// 获取附件名及后缀
		String title = "";
		String extension = "";
		for (int i = 0; i < oldFilesNames.size(); i++) {
			String fileName = oldFilesNames.get(i);
			int dotIndex = fileName.lastIndexOf(".");
			title += fileName.substring(0, dotIndex) + ",";
			extension += fileName.substring(dotIndex + 1, fileName.length()) + ",";
		}
		title = title.substring(0, title.length() - 1);
		extension = extension.substring(0, extension.length() - 1);

		Map<String, Object> uploadCondition = new HashMap<String, Object>(baseCondition);
		uploadCondition.put("fujtpid", newFileTitle);
		uploadCondition.put("bsid", noticeId);
		uploadCondition.put("title", title);
		uploadCondition.put("extension", extension);
		uploadCondition.put("fileindex", fileindex);
		uploadCondition.put("datatype", "GONGG");
		noticeService.modifyNoticeAtts(uploadCondition);
	}

	/**
	 * 公告列表页 by WGJ
	 * 
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list() {
		return "org/notice/list";
	}

	/**
	 * 公告查询 - 管理员 by WGJ
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/findNoticesForMng", method = RequestMethod.GET)
	public String findNoticesForMng() {
		// 查询条件组装
		Map<String, Object> noticesCondition = new HashMap<String, Object>(baseCondition);
		noticesCondition.put("nttype", "GG");

		try {
			noticeService.findNoticesForMng(noticesCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		List<NoticeListVo> noticeList = new ArrayList<NoticeListVo>();
		// 查询返回的游标
		List<Object> noticesCursor = (List<Object>) noticesCondition.get("P_DS");
		noticesMap = new HashMap<String, Object>();
		for (int i = 0; i < noticesCursor.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) noticesCursor.get(i);
			String id = map.get("RWID").toString();
			String title = map.get("TITLE").toString();
			String author = map.get("FABZ").toString();
			String createDate = formatDate(map.get("FABRQ"), "yyyy-MM-dd");
			String expiryDate = formatDate(map.get("JIEZRQ"), "yyyy-MM-dd");
			noticeList.add(new NoticeListVo(id, title, author, createDate, expiryDate));
			// 更新公告 Map
			noticesMap.put(id, map);
		}
		return JSON.toJSONString(noticeList);
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
	 * 删除公告 by WGJ
	 * 
	 * @param rwid
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/removeNotices", method = RequestMethod.DELETE)
	public String removeNotices(@RequestParam("rwid") String rwid) throws Exception {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("rwids", rwid);
		return noticeService.removeNotices(condition);
	}

}