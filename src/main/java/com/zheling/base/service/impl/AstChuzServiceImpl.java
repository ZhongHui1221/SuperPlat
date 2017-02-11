package com.zheling.base.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.mapper.AstChuzMapper;
import com.zheling.base.service.AstChuzService;

@Service
@Transactional
public class AstChuzServiceImpl implements AstChuzService {

	@Autowired
	private AstChuzMapper astChuzMapper;

	@Override
	public String applyForDeal(Map<String, Object> map) throws Exception {
		astChuzMapper.callAstChuzCzmxin(map);
		return null;
	}

}