package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.sup.query.mapper.FwxxMapper;
import com.zheling.sup.query.service.FwxxService;

@Service
@Transactional
public class FwxxServiceImpl implements FwxxService {

	@Autowired
	private FwxxMapper fwxxMapper;

	@Override
	public void findFwxx(Map<String, Object> map) throws SQLException {
		fwxxMapper.callAstQueryFwxxq(map);
	}

}