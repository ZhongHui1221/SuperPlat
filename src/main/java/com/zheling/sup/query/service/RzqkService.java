package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

public interface RzqkService {

	/**
	 * 查询入账情况模块的主页数据 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void queryRzqk(Map<String, Map<String, Object>> map) throws SQLException;

}