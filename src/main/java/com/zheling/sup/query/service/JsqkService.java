package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

/**
 * 固定减少情况
 * 
 * @author admin
 *
 */
public interface JsqkService {

	/**
	 * 模块主页面数据查询
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void queryJsqk(Map<String, Map<String, Object>> map) throws SQLException;

}