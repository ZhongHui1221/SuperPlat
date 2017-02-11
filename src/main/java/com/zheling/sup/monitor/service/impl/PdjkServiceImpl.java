package com.zheling.sup.monitor.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.sup.monitor.mapper.PdjkMapper;
import com.zheling.sup.monitor.service.PdjkService;

@Service
@Transactional
public class PdjkServiceImpl implements PdjkService {

	@Autowired
	private PdjkMapper pdjkMapper;

	@Override
	public void findPdjzr(Map<String, Object> map) throws SQLException {
		pdjkMapper.callAstPandJizrq(map);
	}

	@Override
	public void findOrgPdjzr(Map<String, Object> map) throws SQLException {
		pdjkMapper.callAstPandQcjzrorgq(map);
	}

	@Override
	public void findPddt(Map<String, Object> map) throws SQLException {
		pdjkMapper.callAstPandPddtq(map);
	}

	@Override
	public void findOrgPddt(Map<String, Object> map) throws SQLException {
		pdjkMapper.callAstPandPddtorgq(map);
	}

	@Override
	public void getPdTotal(Map<String, Object> map) throws SQLException {
		pdjkMapper.callAstPandPdnumq(map);
	}

	@Override
	public void findPd(Map<String, Object> map) throws SQLException {
		pdjkMapper.callAstPandPdq(map);
	}

	@Override
	public void getPyTotal(Map<String, Object> map) throws SQLException {
		pdjkMapper.callAstPandPynumq(map);
	}

	@Override
	public void findPy(Map<String, Object> map) throws SQLException {
		pdjkMapper.callAstPandPyq(map);
	}

}