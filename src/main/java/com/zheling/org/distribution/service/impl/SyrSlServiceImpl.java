package com.zheling.org.distribution.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.entity.BdAstYongt;
import com.zheling.org.distribution.mapper.SlpzMapper;
import com.zheling.org.distribution.service.SyrSlService;

@Service
@Transactional
public class SyrSlServiceImpl implements SyrSlService {
	@Autowired
	private SlpzMapper slpzMapper;

	@Override
	public void findDaitj(Map<String, Map<String, Object>> daitjCondition)
			throws SQLException {
		slpzMapper.callAstPeizPznumq(daitjCondition.get("totalCondition"));
		slpzMapper.callAstPeizPzq(daitjCondition.get("detailCondition"));
	}

	@Override
	public List<BdAstYongt> findYongt() {
		List<BdAstYongt> ytlist = slpzMapper.findYongt();
		return ytlist;
	}

}
