package com.zheling.base.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.mapper.AstTouzMapper;
import com.zheling.base.service.AstTouzService;

@Service
@Transactional
public class AstTouzServiceImpl implements AstTouzService {

	@Autowired
	private AstTouzMapper astTouzMapper;

	@Override
	public String applyForInvest(Map<String, Object> map) throws Exception {
		astTouzMapper.callAstTouzTzmxin(map);
		return null;
	}

}