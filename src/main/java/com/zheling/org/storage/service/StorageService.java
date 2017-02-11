package com.zheling.org.storage.service;

import java.sql.SQLException;
import java.util.Map;

public interface StorageService {

	/**
	 * 存放地点查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findStorages(Map<String, Object> map) throws SQLException;

	/**
	 * 添加存放地点 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	String addStorage(Map<String, Object> map) throws Exception;

	/**
	 * 修改存放地点 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	String modifyStorage(Map<String, Object> map) throws Exception;

	/**
	 * 删除存放地点 by WGJ
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	String removeStorages(Map<String, Object> map) throws Exception;

	/**
	 * 构建部门树 by WGJ
	 * 
	 * @param map
	 * @return
	 */
	String deptTree(Map<String, Object> map);

}