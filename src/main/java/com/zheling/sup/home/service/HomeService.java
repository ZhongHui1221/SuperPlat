package com.zheling.sup.home.service;

import java.sql.SQLException;
import java.util.Map;

public interface HomeService {

	/**
	 * 平台首页 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void main(Map<String, Map<String, Object>> map) throws SQLException;

	/**
	 * 构建单位树 by WGJ
	 * 
	 * @param map
	 * @return
	 */
	String orgTree(Map<String, Object> map);

}