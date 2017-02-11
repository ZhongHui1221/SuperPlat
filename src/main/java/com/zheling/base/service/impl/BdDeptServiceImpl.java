package com.zheling.base.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.zheling.base.entity.BdDept;
import com.zheling.base.mapper.BdDeptMapper;
import com.zheling.base.service.BdDeptService;

@Service
@Transactional
public class BdDeptServiceImpl extends BaseServiceImpl<BdDept> implements BdDeptService {

	@Autowired
	private BdDeptMapper bdDeptMapper;

	// 部门树 JSON（后期会将类型优化为 StringBuffer 或 StringBuilder）
	private String deptTreeJson = "";

	@Override
	public void findDepts(Map<String, Object> map) throws SQLException {
		bdDeptMapper.callCoreGetdept(map);
	}

	@Override
	public int getCountByOrgid(String orgid) {
		return bdDeptMapper.getCountByOrgid(orgid);
	}

	@Override
	public List<BdDept> findTopDeptsByOrgid(String orgid) {
		return bdDeptMapper.findTopDeptsByOrgid(orgid);
	}

	@Override
	public String deptTree(Map<String, Object> map) {
		if (!"".equals(deptTreeJson)) {
			return JSON.parse(deptTreeJson).toString();
		}

		Map<String, Object> deptCondition = new HashMap<String, Object>(map);
		try {
			bdDeptMapper.callCoreGetdept(deptCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		List<Object> deptCursor = (List<Object>) deptCondition.get("P_DS");

		deptTreeJson += "[";
		recursion(deptCursor);
		if (deptTreeJson.substring(deptTreeJson.length() - 1).equals(",")) {
			deptTreeJson = deptTreeJson.substring(0, deptTreeJson.length() - 1);
		}
		deptTreeJson += "]";
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
			Object supParentId = supMap.get("PARENTID");

			deptTreeJson += "{'id':'" + supDeptId + "','name':'" + supDeptName + "','pid':'"
					+ supParentId + "',";

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