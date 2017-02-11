package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.sup.query.mapper.FbqkMapper;
import com.zheling.sup.query.service.FbqkService;

@Service
@Transactional
public class FbqkServiceImpl implements FbqkService {

	@Autowired
	private FbqkMapper fbqkMapper;

	@Override
	public void findFbqk(Map<String, Object> map) throws SQLException {
		fbqkMapper.callAstQueryHuizDeptq(map);
	}

}