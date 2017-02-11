package com.zheling.base.service;

import java.sql.SQLException;
import java.util.Map;

public interface AstChuzService {

	/**
	 * 申请处置 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	String applyForDeal(Map<String, Object> map) throws Exception;

}