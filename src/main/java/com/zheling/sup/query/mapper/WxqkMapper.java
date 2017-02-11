package com.zheling.sup.query.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface WxqkMapper {

	/**
	 * 查询维修费用情况 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryWeixfyq(Map<String, Object> map) throws SQLException;

	/**
	 * 查询维修费用明细情况 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryWeixfymx(Map<String, Object> map) throws SQLException;

}