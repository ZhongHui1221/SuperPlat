package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface AstTouzMapper {

	/**
	 * 申请投资 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstTouzTzmxin(Map<String, Object> map) throws SQLException;

}