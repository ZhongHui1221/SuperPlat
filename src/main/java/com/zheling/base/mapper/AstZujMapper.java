package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface AstZujMapper {

	/**
	 * 申请出租（借） by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstZujZujkpin(Map<String, Object> map) throws SQLException;

}