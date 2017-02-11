package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

public interface YtflService {

	/**
	 * 用途分类模块主页数据查询
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void queryYtfl(Map<String, Map<String, Object>> map) throws SQLException;

}