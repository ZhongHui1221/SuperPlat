package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zheling.sup.query.mapper.JsqkMapper;
import com.zheling.sup.query.service.JsqkService;

@Service
public class JsqkServiceImpl implements JsqkService {

	@Autowired
	private JsqkMapper jsqkMapper;

	@Override
	public void queryJsqk(Map<String, Map<String, Object>> map)
			throws SQLException {
		jsqkMapper.callAstQueryZiCJSQ(map.get("totalCondition"));
		jsqkMapper.callAstQueryZiCJSMXQ(map.get("detailCondition"));
	}

}