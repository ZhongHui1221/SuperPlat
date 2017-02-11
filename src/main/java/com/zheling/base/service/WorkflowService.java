package com.zheling.base.service;

import java.sql.SQLException;
import java.util.Map;

public interface WorkflowService {

	/**
	 * 待办事项查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findDbsx(Map<String, Object> map) throws SQLException;
	
	/**
	 * 工作流查看 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findWf(Map<String, Object> map) throws SQLException;

}