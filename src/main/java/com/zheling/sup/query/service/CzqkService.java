package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

public interface CzqkService {

	/**
	 * 处置情况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findCzqk(Map<String, Map<String, Object>> map) throws SQLException;

	/**
	 * 待审批处置数量查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void getDspczNum(Map<String, Object> map) throws SQLException;

	/**
	 * 待审批处置信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findDspcz(Map<String, Object> map) throws SQLException;

	/**
	 * 收益明细数量查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void getSymxNum(Map<String, Object> map) throws SQLException;

	/**
	 * 收益明细查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findSymx(Map<String, Object> map) throws SQLException;

}