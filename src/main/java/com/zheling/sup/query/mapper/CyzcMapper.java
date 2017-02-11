package com.zheling.sup.query.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface CyzcMapper {

	/**
	 * 常用资产查询（电脑、办公类设备） by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryCyq1(Map<String, Object> map) throws SQLException;

	/**
	 * 常用资产查询（机动车辆） by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryCyq2(Map<String, Object> map) throws SQLException;

	/**
	 * 常用资产查询（数码电器类设备） by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryCyq3(Map<String, Object> map) throws SQLException;

	/**
	 * 常用资产查询（家具、用具和装具） by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryCyq4(Map<String, Object> map) throws SQLException;

	/**
	 * 资产用途查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryYongtq(Map<String, Object> map) throws SQLException;

	/**
	 * 资产使用状况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryYtsyzkq(Map<String, Object> map) throws SQLException;

}