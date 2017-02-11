package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.zheling.base.entity.BdDept;

@Repository
public interface BdDeptMapper extends BaseMapper<BdDept> {

	/**
	 * 部门信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callCoreGetdept(Map<String, Object> map) throws SQLException;

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
	 * 根据 parentid 查询部门 by WGJ
	 * 
	 * @param parentid
	 * @return
	 */
	List<BdDept> findDeptsByParentid(String parentid);

}