package com.zheling.base.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.mapper.AstZujMapper;
import com.zheling.base.service.AstZujService;

@Service
@Transactional
public class AstZujServiceImpl implements AstZujService {

	@Autowired
	private AstZujMapper astZujMapper;

	@Override
	public String applyForRent(Map<String, Object> map) throws Exception {
		astZujMapper.callAstZujZujkpin(map);
		return null;
	}

}