package com.zheling.base.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.zheling.base.entity.BdDept;

public interface BdDeptService extends BaseService<BdDept> {

	/**
	 * 部门信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findDepts(Map<String, Object> map) throws SQLException;

	/**
	 * 根据 orgid 查询部门的个数 by WGJ
	 * 
	 * @param orgid
	 * @return
	 */
	int getCountByOrgid(String orgid);

	/**
	 * 根据 orgid 查询顶级部门 by WGJ
	 * 
	 * @param orgid
	 * @return
	 */
	List<BdDept> findTopDeptsByOrgid(String orgid);

	/**
	 * 构建部门树 by WGJ
	 * 
	 * @param map
	 * @return
	 */
	String deptTree(Map<String, Object> map);

}