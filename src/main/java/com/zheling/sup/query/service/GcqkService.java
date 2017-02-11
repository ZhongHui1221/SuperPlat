package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

public interface GcqkService {

	/**
	 * 构成情况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findGcqk(Map<String, Object> map) throws SQLException;

}