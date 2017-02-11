package com.zheling.sup.monitor.service;

import java.sql.SQLException;
import java.util.Map;

public interface PdjkService {

	/**
	 * 盘点基准日查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findPdjzr(Map<String, Object> map) throws SQLException;

	/**
	 * 单位盘点基准日查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findOrgPdjzr(Map<String, Object> map) throws SQLException;

	/**
	 * 盘点动态查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findPddt(Map<String, Object> map) throws SQLException;

	/**
	 * 单位盘点动态查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findOrgPddt(Map<String, Object> map) throws SQLException;

	/**
	 * 盘点总体情况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void getPdTotal(Map<String, Object> map) throws SQLException;

	/**
	 * 盘点信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findPd(Map<String, Object> map) throws SQLException;

	/**
	 * 盘盈数量查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void getPyTotal(Map<String, Object> map) throws SQLException;

	/**
	 * 盘盈信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findPy(Map<String, Object> map) throws SQLException;

}