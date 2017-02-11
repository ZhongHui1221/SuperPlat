package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface WorkflowMapper {

	/**
	 * 待办事项查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callCoreWfget(Map<String, Object> map) throws SQLException;

	/**
	 * 通用工作流查询 --hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCommonWfq(Map<String, Object> map) throws SQLException;

}