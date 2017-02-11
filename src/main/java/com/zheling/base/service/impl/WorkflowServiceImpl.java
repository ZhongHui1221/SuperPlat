package com.zheling.base.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.mapper.WorkflowMapper;
import com.zheling.base.service.WorkflowService;

@Service
@Transactional
public class WorkflowServiceImpl implements WorkflowService {

	@Autowired
	private WorkflowMapper workflowMapper;

	@Override
	public void findDbsx(Map<String, Object> map) throws SQLException {
		workflowMapper.callCoreWfget(map);
	}

	@Override
	public void findWf(Map<String, Object> map) throws SQLException {
		workflowMapper.callAstCommonWfq(map);
	}

}