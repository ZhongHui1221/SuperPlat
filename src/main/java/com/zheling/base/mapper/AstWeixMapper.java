package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface AstWeixMapper {

	/**
	 * 申请报修 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstWeixWxin(Map<String, Object> map) throws SQLException;

}