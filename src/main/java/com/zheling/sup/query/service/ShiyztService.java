package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

public interface ShiyztService {

	/**
	 * 使用状况模块的主页数据 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void queryShiYZT(Map<String, Map<String, Object>> map) throws SQLException;

}