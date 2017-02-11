package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

public interface ZjqkService {

	/**
	 * 固定资产增加情况查询（依据取得方式） by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void queryZJQK(Map<String, Map<String, Object>> map) throws SQLException;

}