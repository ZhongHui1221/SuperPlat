package com.zheling.base.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.mapper.AstWeixMapper;
import com.zheling.base.service.AstWeixService;

@Service
@Transactional
public class AstWeixServiceImpl implements AstWeixService {

	@Autowired
	private AstWeixMapper astWeixMapper;

	@Override
	public String applyForRepair(Map<String, Object> map) throws Exception {
		astWeixMapper.callAstWeixWxin(map);
		return null;
	}

}