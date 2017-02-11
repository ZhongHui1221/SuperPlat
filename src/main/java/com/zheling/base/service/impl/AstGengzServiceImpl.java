package com.zheling.base.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.mapper.AstGengzMapper;
import com.zheling.base.service.AstGengzService;

@Service
@Transactional
public class AstGengzServiceImpl implements AstGengzService {

	@Autowired
	private AstGengzMapper astGengzMapper;

	@Override
	public String applyForCorrect(Map<String, Object> map) throws Exception {
		astGengzMapper.callAstGengzGzin(map);
		return null;
	}

}