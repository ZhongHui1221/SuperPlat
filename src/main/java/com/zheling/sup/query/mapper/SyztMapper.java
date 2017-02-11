package com.zheling.sup.query.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface SyztMapper {

	/**
	 * 使用状况查询(总体情况) by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryShiyztq(Map<String, Object> map) throws SQLException;

	/**
	 * 使用状况明细查询(依资产大类) by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryShiyztmxq(Map<String, Object> map) throws SQLException;

}