package com.zheling.base.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.mapper.AstTiaojMapper;
import com.zheling.base.service.AstTiaojService;

@Service
@Transactional
public class AstTiaojServiceImpl implements AstTiaojService {

	@Autowired
	private AstTiaojMapper astTiaojMapper;

	@Override
	public String applyForTransfer(Map<String, Object> map) throws Exception {
		astTiaojMapper.callAstTiaojZyin(map);
		return null;
	}

	@Override
	public String applyForReturn(Map<String, Object> map) throws Exception {
		astTiaojMapper.callAstTiaojAcqghaud(map);
		return null;
	}

}