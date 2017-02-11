package com.zheling.sup.query.service;

/**
 * 待报废资产业务
 * @author hugo
 *
 */

import java.sql.SQLException;
import java.util.Map;

public interface DbfzcService {

	/**
	 * 待报废资产模块主页数据查询
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void queryDbfzc(Map<String, Map<String, Object>> map) throws SQLException;

}