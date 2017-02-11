package com.zheling.sup.query.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface ZjqkMapper {

	/**
	 * 取得方式查询 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryQuDFSQ(Map<String, Object> map) throws SQLException;

	/**
	 * 取得方式明细查询 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryQuDFSMXQ(Map<String, Object> map) throws SQLException;

}