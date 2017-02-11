package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

public interface FwxxService {

	/**
	 * 房屋信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findFwxx(Map<String, Object> map) throws SQLException;

}