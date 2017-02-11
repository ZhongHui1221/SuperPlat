package com.zheling.sup.query.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface RzqkMapper {

	/**
	 * 登账状态查询
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryRuZZTQ(Map<String, Object> map) throws SQLException;

	/**
	 * 总账查询
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryZongZQ(Map<String, Object> map) throws SQLException;

}