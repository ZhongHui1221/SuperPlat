package com.zheling.base.service.impl;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.entity.CoreUser;
import com.zheling.base.mapper.AstUserMapper;
import com.zheling.base.mapper.CoreUserMapper;
import com.zheling.base.service.CoreUserService;

@Service
@Transactional
public class CoreUserServiceImpl extends BaseServiceImpl<CoreUser> implements CoreUserService {

	@Autowired
	private CoreUserMapper coreUserMapper;
	@Autowired
	private AstUserMapper astUserMapper;

	@Override
	public void login(Map<String, Object> map) throws SQLException {
		coreUserMapper.callCoreLogin(map);
	}

	@Override
	public String register(Map<String, Object> map) throws Exception {
		astUserMapper.callAstUserUserin(map);
		return null;
	}

	@Override
	public String modify(Map<String, Object> map) throws Exception {
		astUserMapper.callAstUserUserupd(map);
		return null;
	}

	@Override
	public void findPdUsers(Map<String, Object> map) throws SQLException {
		coreUserMapper.callCoreGetusers(map);
	}

	@Override
	public void findUsers(Map<String, Object> map) throws SQLException {
		astUserMapper.callAstUserUserq(map);
	}

}