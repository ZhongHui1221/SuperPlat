package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

public interface WxqkService {

	/**
	 * 查询维修情况模块主页面默认查询数据 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void queryWxqk(Map<String, Map<String, Object>> map) throws SQLException;

}