package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

public interface ZtqkService {

	/**
	 * 总体情况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findZtqk(Map<String, Map<String, Object>> map) throws SQLException;

}