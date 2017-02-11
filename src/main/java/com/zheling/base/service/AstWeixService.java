package com.zheling.base.service;

import java.sql.SQLException;
import java.util.Map;

public interface AstWeixService {

	/**
	 * 申请报修 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	String applyForRepair(Map<String, Object> map) throws Exception;

}