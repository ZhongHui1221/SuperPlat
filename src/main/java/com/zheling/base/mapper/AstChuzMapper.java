package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface AstChuzMapper {

	/**
	 * 申请处置 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstChuzCzmxin(Map<String, Object> map) throws SQLException;

}