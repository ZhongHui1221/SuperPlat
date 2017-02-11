package com.zheling.sup.monitor.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface PdjkMapper {

	void callApdcanpost(Map<String, Object> map) throws SQLException;

	/**
	 * 盘点基准日查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPandJizrq(Map<String, Object> map) throws SQLException;

	/**
	 * 单位盘点基准日查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPandQcjzrorgq(Map<String, Object> map) throws SQLException;

	/**
	 * 盘点动态查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPandPddtq(Map<String, Object> map) throws SQLException;

	/**
	 * 单位盘点动态查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPandPddtorgq(Map<String, Object> map) throws SQLException;

	/**
	 * 盘点总体情况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPandPdnumq(Map<String, Object> map) throws SQLException;

	/**
	 * 盘点信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPandPdq(Map<String, Object> map) throws SQLException;

	/**
	 * 盘盈数量查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPandPynumq(Map<String, Object> map) throws SQLException;

	/**
	 * 盘盈信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPandPyq(Map<String, Object> map) throws SQLException;

	/**
	 * 用于初始化自定义列 hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCommonInitZidyl(Map<String, Object> map) throws SQLException;

}