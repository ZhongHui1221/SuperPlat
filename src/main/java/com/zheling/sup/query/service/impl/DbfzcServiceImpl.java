package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zheling.sup.query.mapper.DbfzcMapper;
import com.zheling.sup.query.service.DbfzcService;

@Service
public class DbfzcServiceImpl implements DbfzcService {

	@Autowired
	DbfzcMapper dbfzcMapper;

	@Override
	public void queryDbfzc(Map<String, Map<String, Object>> map)
			throws SQLException {
		dbfzcMapper.callAstQueryDaibfq(map.get("totalCondition"));
		dbfzcMapper.callAstQueryDaibfmxq(map.get("detailCondition"));
	}

}