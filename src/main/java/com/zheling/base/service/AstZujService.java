package com.zheling.base.service;

import java.sql.SQLException;
import java.util.Map;

public interface AstZujService {

	/**
	 * 申请出租（借） by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	String applyForRent(Map<String, Object> map) throws Exception;

}