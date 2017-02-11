package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.sup.query.mapper.ZtqkMapper;
import com.zheling.sup.query.service.ZtqkService;

@Service
@Transactional
public class ZtqkServiceImpl implements ZtqkService {

	@Autowired
	private ZtqkMapper ztqkMapper;

	@Override
	public void findZtqk(Map<String, Map<String, Object>> map)
			throws SQLException {
		ztqkMapper.callAstQueryCunlsyq(map.get("ztqkYearCondition"));
		ztqkMapper.callAstQueryCunlsyq(map.get("ztqkMonthCondition"));
	}

}