package com.zheling.sup.query.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface CzqkMapper {

	/**
	 * 处置情况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryCzhzq(Map<String, Object> map) throws SQLException;

	/**
	 * 查询处置批复单数量 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryCzhzmxnumq(Map<String, Object> map) throws SQLException;

	/**
	 * 查询处置批复单信息 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryCzhzmxq(Map<String, Object> map) throws SQLException;

	/**
	 * 查询处置单个批复单批复项目数 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstChuzCzmxnumq2(Map<String, Object> map) throws SQLException;

	/**
	 * 查询处置单个批复单批复项目明细 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstChuzCzmxq2(Map<String, Object> map) throws SQLException;

	/**
	 * 待审批处置数量查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstChuzCznumq(Map<String, Object> map) throws SQLException;

	/**
	 * 待审批处置信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstChuzCzq(Map<String, Object> map) throws SQLException;

	/**
	 * 收益明细数量查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstChuzSymxnumq(Map<String, Object> map) throws SQLException;

	/**
	 * 收益明细查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstChuzSymxq(Map<String, Object> map) throws SQLException;

}