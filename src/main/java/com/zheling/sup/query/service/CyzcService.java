package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

public interface CyzcService {

	/**
	 * 常用资产汇总查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findCyzc(Map<String, Map<String, Object>> map) throws SQLException;

	/**
	 * 资产用途查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findZcyt(Map<String, Object> map) throws SQLException;

	/**
	 * 资产使用状况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findZcsyzk(Map<String, Object> map) throws SQLException;

}