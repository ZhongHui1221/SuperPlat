package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.sup.query.mapper.CzqkMapper;
import com.zheling.sup.query.service.CzqkService;

@Service
@Transactional
public class CzqkServiceImpl implements CzqkService {

	@Autowired
	private CzqkMapper czqkMapper;

	@Override
	public void findCzqk(Map<String, Map<String, Object>> map) throws SQLException {
		czqkMapper.callAstQueryCzhzq(map.get("czqkYearCondition"));
		czqkMapper.callAstQueryCzhzq(map.get("czqkMonthCondition"));
	}

	@Override
	public void getDspczNum(Map<String, Object> map) throws SQLException {
		czqkMapper.callAstChuzCznumq(map);
	}

	@Override
	public void findDspcz(Map<String, Object> map) throws SQLException {
		czqkMapper.callAstChuzCzq(map);
	}

	@Override
	public void getSymxNum(Map<String, Object> map) throws SQLException {
		czqkMapper.callAstChuzSymxnumq(map);
	}

	@Override
	public void findSymx(Map<String, Object> map) throws SQLException {
		czqkMapper.callAstChuzSymxq(map);
	}

}