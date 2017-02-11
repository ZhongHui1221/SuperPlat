package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.sup.query.mapper.SyztMapper;
import com.zheling.sup.query.service.ShiyztService;

@Service
@Transactional
public class ShiyztServiceImpl implements ShiyztService {

	@Autowired
	private SyztMapper syztMapper;

	@Override
	public void queryShiYZT(Map<String, Map<String, Object>> map)
			throws SQLException {
		syztMapper.callAstQueryShiyztq(map.get("totalCondition"));
		syztMapper.callAstQueryShiyztmxq(map.get("detailCondition"));
	}

}