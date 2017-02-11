package com.zheling.org.distribution.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.entity.BdAstYongt;
import com.zheling.org.distribution.mapper.SlpzMapper;
import com.zheling.org.distribution.service.SlpzService;

@Service
@Transactional
public class SlpzServiceImpl implements SlpzService {
	@Autowired
	private SlpzMapper slpzMapper;

	@Override
	public List<BdAstYongt> findYongt() {
		List<BdAstYongt> ytlist = slpzMapper.findYongt();
		return ytlist;
	}

	@Override
	public void findDaitjTotal(Map<String, Object> condition) throws SQLException {
		slpzMapper.callAstPeizPznumq(condition);
	}

	@Override
	public void findDaitjDetail(Map<String, Object> condition) throws SQLException {
		slpzMapper.callAstPeizPzq(condition);
	}

	@Override
	public String createShenld(Map<String, Object> condition) throws Exception {
		slpzMapper.callAstPeizPzin(condition);
		return null;
	}

	@Override
	public String deleteShenld(Map<String, Object> condition) throws Exception {
		slpzMapper.callAstPeizPzout(condition);
		return null;
	}

	@Override
	public String submitShenld(Map<String, Object> condition) throws Exception {
		slpzMapper.callAstPeizSubmit(condition);
		return null;
	}

}
