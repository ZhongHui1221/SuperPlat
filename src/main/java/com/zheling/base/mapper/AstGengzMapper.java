package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface AstGengzMapper {

	/**
	 * 申请更正 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstGengzGzin(Map<String, Object> map) throws SQLException;

}