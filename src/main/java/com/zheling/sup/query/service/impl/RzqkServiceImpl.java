package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zheling.sup.query.mapper.RzqkMapper;
import com.zheling.sup.query.service.RzqkService;

@Service
public class RzqkServiceImpl implements RzqkService {

	@Autowired
	private RzqkMapper rzqkMapper;

	@Override
	public void queryRzqk(Map<String, Map<String, Object>> map)
			throws SQLException {
		rzqkMapper.callAstQueryRuZZTQ(map.get("dzztCondition"));
		rzqkMapper.callAstQueryZongZQ(map.get("zzCondition"));
	}

}