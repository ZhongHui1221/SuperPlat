package com.zheling.org.storage.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.zheling.base.entity.BdOrg;
import com.zheling.base.mapper.AstUserMapper;
import com.zheling.base.mapper.BdDeptMapper;
import com.zheling.base.mapper.BdOrgMapper;
import com.zheling.org.storage.service.StorageService;

@Service
@Transactional
public class StorageServiceImpl implements StorageService {

	// 部门树 JSON（后期会将类型优化为 StringBuffer 或 StringBuilder）
	private String deptTreeJson = "";

	@Autowired
	private AstUserMapper astUserMapper;
	@Autowired
	private BdOrgMapper bdOrgMapper;
	@Autowired
	private BdDeptMapper bdDeptMapper;

	@Override
	public void findStorages(Map<String, Object> map) throws SQLException {
		astUserMapper.callAstUserCunfddq(map);
	}

	@Override
	public String addStorage(Map<String, Object> map) throws Exception {
		astUserMapper.callAstUserCunfddin(map);
		return null;
	}

	@Override
	public String modifyStorage(Map<String, Object> map) throws Exception {
		astUserMapper.callAstUserCunfddupd(map);
		return null;
	}

	@Override
	public String removeStorages(Map<String, Object> map) throws Exception {
		astUserMapper.callAstUserCunfddout(map);
		return null;
	}

	@Override
	public String deptTree(Map<String, Object> map) {
		if (!"".equals(deptTreeJson)) {
			return JSON.parse(deptTreeJson).toString();
		}

		// 获取单位 ID
		String orgid = map.get("orgid").toString();
		// 查询当前单位
		BdOrg org = bdOrgMapper.selectByPrimaryKey(orgid);

		Map<String, Object> deptCondition = new HashMap<String, Object>(map);
		try {
			bdDeptMapper.callCoreGetdept(deptCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		List<Object> deptCursor = (List<Object>) deptCondition.get("P_DS");

		deptTreeJson += "{'id':'" + org.getRwid() + "','name':'" + org.getObjname() + "',";
		deptTreeJson += "'open':'true','children':[";
		recursion(deptCursor);
		if (deptTreeJson.substring(deptTreeJson.length() - 1).equals(",")) {
			deptTreeJson = deptTreeJson.substring(0, deptTreeJson.length() - 1);
		}
		deptTreeJson += "]}";
		return JSON.parse(deptTreeJson).toString();
	}

	/**
	 * 递归算法构建部门树 by WGJ
	 * 
	 * @param supDepts
	 *            上级（sup）部门集合
	 */
	private void recursion(List<Object> supDepts) {
		for (int i = 0; i < supDepts.size(); i++) {
			Map<String, Object> supMap = (Map<String, Object>) supDepts.get(i);
			String supDeptId = supMap.get("RWID").toString();
			Object supDeptName = supMap.get("OBJNAME");

			deptTreeJson += "{'id':'" + supDeptId + "','name':'" + supDeptName + "',";

			// 下级（sub）部门集合
			List<Object> subDepts = new ArrayList<Object>();
			for (int j = 0; j < supDepts.size(); j++) {
				Map<String, Object> subMap = (Map<String, Object>) supDepts.get(j);
				Object subParentId = subMap.get("PARENTID");
				if (supDeptId.equals(subParentId)) {
					subDepts.add(supDepts.get(j));
				}
			}

			// 如果存在下级（sub）部门
			if (subDepts.size() > 0) {
				deptTreeJson += "'open':'true','children':[";
				recursion(subDepts);
				deptTreeJson = deptTreeJson.substring(0, deptTreeJson.length() - 1) + "]},";
			} else {
				deptTreeJson = deptTreeJson.substring(0, deptTreeJson.length() - 1) + "},";
			}
		}
	}

}