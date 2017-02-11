package com.zheling.base.service;

import java.sql.SQLException;
import java.util.Map;

public interface AstTouzService {

	/**
	 * 申请投资 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	String applyForInvest(Map<String, Object> map) throws Exception;

}