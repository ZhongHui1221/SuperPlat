package com.zheling.base.service;

import java.sql.SQLException;
import java.util.Map;

public interface AstTiaojService {

	/**
	 * 申请转移 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	String applyForTransfer(Map<String, Object> map) throws Exception;

	/**
	 * 申请归还 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	String applyForReturn(Map<String, Object> map) throws Exception;

}