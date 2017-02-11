package com.zheling.base.service;

import java.sql.SQLException;
import java.util.Map;

public interface AstGengzService {

	/**
	 * 申请更正 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	String applyForCorrect(Map<String, Object> map) throws Exception;

}