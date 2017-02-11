package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

public interface FbqkService {

	/**
	 * 分布情况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findFbqk(Map<String, Object> map) throws SQLException;

}