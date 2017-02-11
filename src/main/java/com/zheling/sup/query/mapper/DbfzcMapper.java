package com.zheling.sup.query.mapper;

/**
 * @author hugo
 */

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface DbfzcMapper {

	/**
	 * 待报废资产总体情况查询
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryDaibfq(Map<String, Object> map) throws SQLException;

	/**
	 * 待报废资产明细情况查询
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryDaibfmxq(Map<String, Object> map) throws SQLException;

}