package com.zheling.base.service;

import java.sql.SQLException;
import java.util.Map;

public interface ZicflService {

	/**
	 * 常用资产分类查询 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findCyZicfl(Map<String, Object> map) throws SQLException;

	/**
	 * 资产分类快速查询 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findZicflQuick(Map<String, Object> map) throws SQLException;

	/**
	 * 详细资产分类查询 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findXxZicfl(Map<String, Object> map) throws SQLException;

	String cyZicflTree() throws SQLException;

	String xxZicflTree() throws SQLException;

}