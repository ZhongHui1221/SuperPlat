package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface AstTiaojMapper {

	/**
	 * 申请转移 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstTiaojZyin(Map<String, Object> map) throws SQLException;

	/**
	 * 申请归还 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstTiaojAcqghaud(Map<String, Object> map) throws SQLException;

}