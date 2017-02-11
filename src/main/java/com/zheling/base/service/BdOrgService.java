package com.zheling.base.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.zheling.base.entity.BdOrg;

public interface BdOrgService extends BaseService<BdOrg> {

	/**
	 * 构建单位树 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void orgTree(Map<String, Object> map) throws SQLException;

	/**
	 * 根据 parentid 查询单位的个数 by WGJ
	 * 
	 * @param parentid
	 * @return
	 */
	int getCountByParentid(String parentid);

	/**
	 * 根据 parentid 查询单位 by WGJ
	 * 
	 * @param parentid
	 * @return
	 */
	List<BdOrg> findOrgsByParentid(String parentid);

	/**
	 * 根据预算代码查询单位 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void getOrgByCode(Map<String, Object> map) throws SQLException;

}