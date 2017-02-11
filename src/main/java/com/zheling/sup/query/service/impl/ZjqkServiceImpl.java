package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.sup.query.mapper.ZjqkMapper;
import com.zheling.sup.query.service.ZjqkService;

/**
 * 固定资产增加情况
 * 
 * @author hugo
 */
@Service
@Transactional
public class ZjqkServiceImpl implements ZjqkService {

	@Autowired
	private ZjqkMapper zjqkMapper;

	@Override
	public void queryZJQK(Map<String, Map<String, Object>> map)
			throws SQLException {
		zjqkMapper.callAstQueryQuDFSQ(map.get("totalCondition"));
		zjqkMapper.callAstQueryQuDFSMXQ(map.get("detailCondition"));
	}

}