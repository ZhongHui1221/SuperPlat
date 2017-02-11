package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zheling.sup.query.mapper.WxqkMapper;
import com.zheling.sup.query.service.WxqkService;

@Service
public class WxqkServiceImpl implements WxqkService {

	@Autowired
	WxqkMapper wxqkMapper;

	@Override
	public void queryWxqk(Map<String, Map<String, Object>> map)
			throws SQLException {
		wxqkMapper.callAstQueryWeixfyq(map.get("tenYearsTotalCondition"));
		wxqkMapper.callAstQueryWeixfyq(map.get("oneYearTotalCondition"));
		wxqkMapper.callAstQueryWeixfymx(map.get("detailCondition"));
	}

}