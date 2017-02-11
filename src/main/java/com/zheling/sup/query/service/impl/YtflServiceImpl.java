package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zheling.sup.query.mapper.YtflMapper;
import com.zheling.sup.query.service.YtflService;

@Service
public class YtflServiceImpl implements YtflService {

	@Autowired
	private YtflMapper ytflMapper;

	@Override
	public void queryYtfl(Map<String, Map<String, Object>> map)
			throws SQLException {
		ytflMapper.callAstQueryYTQ(map.get("totalCondition"));
		ytflMapper.callAstQueryYTQ(map.get("detailCondition"));
	}

}