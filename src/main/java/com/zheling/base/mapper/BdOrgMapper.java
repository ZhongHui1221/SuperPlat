package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.zheling.base.entity.BdOrg;

@Repository
public interface BdOrgMapper extends BaseMapper<BdOrg> {

	/**
	 * 构建单位树 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryOrgq(Map<String, Object> map) throws SQLException;

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

}