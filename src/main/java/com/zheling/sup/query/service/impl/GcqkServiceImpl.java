package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.sup.query.mapper.BsAstCardMapper;
import com.zheling.sup.query.service.GcqkService;

@Service
@Transactional
public class GcqkServiceImpl implements GcqkService {

	@Autowired
	private BsAstCardMapper bsAstCardMapper;

	@Override
	public void findGcqk(Map<String, Object> map) throws SQLException {
		bsAstCardMapper.callAstQueryZcdl(map);
	}

}