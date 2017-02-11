package com.zheling.sup.query.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface JsqkMapper {

	/**
	 * 资产减少情况总体情况查询
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryZiCJSQ(Map<String, Object> map) throws SQLException;

	/**
	 * 资产减少情况明细情况查询
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryZiCJSMXQ(Map<String, Object> map) throws SQLException;

}