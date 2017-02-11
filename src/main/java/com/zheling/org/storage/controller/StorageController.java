package com.zheling.org.storage.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.zheling.base.controller.BaseController;
import com.zheling.org.storage.service.StorageService;

@Controller
@RequestMapping("/Storage")
public class StorageController extends BaseController {

	@Autowired
	private StorageService storageService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(HttpServletRequest request) {
		request.setAttribute("deptTree", storageService.deptTree(baseCondition));
		return "org/storage/main";
	}

	@ResponseBody
	@RequestMapping(value = "/findStorages", method = RequestMethod.GET)
	public String findStorages(@RequestParam(value = "deptid", defaultValue = "") String deptid,
			@RequestParam(value = "keyvalue", defaultValue = "") String keyvalue) {
		// 查询条件组装
		Map<String, Object> storagesCondition = new HashMap<String, Object>(baseCondition);
		storagesCondition.put("snum", 1);
		storagesCondition.put("enum", 1000);
		storagesCondition.put("suosbmid", deptid);

		try {
			storageService.findStorages(storagesCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> storagesCursor = (List<Object>) storagesCondition.get("P_DS");
		return JSON.toJSONString(storagesCursor);
	}

	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String add(@RequestParam("objname") String objname,
			@RequestParam("suosbmid") String suosbmid, @RequestParam("beiz") String beiz,
			HttpServletRequest request) throws Exception {
		Map<String, Object> addCondition = new HashMap<String, Object>(baseCondition);
		addCondition.put("objname", objname);
		addCondition.put("suosbmid", suosbmid);
		addCondition.put("beiz", beiz);
		return storageService.addStorage(addCondition);
	}

	@ResponseBody
	@RequestMapping(value = "/modify", method = RequestMethod.PUT)
	public String modify(@RequestParam("cunfddid") String cunfddid,
			@RequestParam("objname") String objname, @RequestParam("suosbmid") String suosbmid,
			@RequestParam("beiz") String beiz, HttpServletRequest request) throws Exception {
		Map<String, Object> modifyCondition = new HashMap<String, Object>(baseCondition);
		modifyCondition.put("cunfddid", cunfddid);
		modifyCondition.put("objname", objname);
		modifyCondition.put("suosbmid", suosbmid);
		modifyCondition.put("beiz", beiz);
		return storageService.modifyStorage(modifyCondition);
	}

	@ResponseBody
	@RequestMapping(value = "/removeStorages", method = RequestMethod.DELETE)
	public String removeStorages(@RequestParam("storageid") String storageid) throws Exception {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("cunfddid", storageid);
		return storageService.removeStorages(condition);
	}

}