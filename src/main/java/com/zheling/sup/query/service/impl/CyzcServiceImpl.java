package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.sup.query.mapper.CyzcMapper;
import com.zheling.sup.query.service.CyzcService;

@Service
@Transactional
public class CyzcServiceImpl implements CyzcService {

	@Autowired
	private CyzcMapper cyzcMapper;

	@Override
	public void findCyzc(Map<String, Map<String, Object>> map)
			throws SQLException {
		cyzcMapper.callAstQueryCyq1(map.get("cyq1Condition"));
		cyzcMapper.callAstQueryCyq2(map.get("cyq2Condition"));
		cyzcMapper.callAstQueryCyq3(map.get("cyq3Condition"));
		cyzcMapper.callAstQueryCyq4(map.get("cyq4Condition"));
	}

	@Override
	public void findZcyt(Map<String, Object> map) throws SQLException {
		cyzcMapper.callAstQueryYongtq(map);
	}

	@Override
	public void findZcsyzk(Map<String, Object> map) throws SQLException {
		cyzcMapper.callAstQueryYtsyzkq(map);
	}

}