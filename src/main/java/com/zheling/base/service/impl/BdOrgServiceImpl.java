package com.zheling.base.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.entity.BdOrg;
import com.zheling.base.mapper.AstCommonMapper;
import com.zheling.base.mapper.BdOrgMapper;
import com.zheling.base.service.BdOrgService;

@Service
@Transactional
public class BdOrgServiceImpl extends BaseServiceImpl<BdOrg> implements BdOrgService {

	@Autowired
	private BdOrgMapper bdOrgMapper;
	@Autowired
	private AstCommonMapper astCommonMapper;

	@Override
	public void orgTree(Map<String, Object> map) throws SQLException {
		bdOrgMapper.callAstQueryOrgq(map);
	}

	@Override
	public int getCountByParentid(String parentid) {
		return bdOrgMapper.getCountByParentid(parentid);
	}

	@Override
	public List<BdOrg> findOrgsByParentid(String parentid) {
		return bdOrgMapper.findOrgsByParentid(parentid);
	}

	@Override
	public void getOrgByCode(Map<String, Object> map) throws SQLException {
		astCommonMapper.callAstCommonGetorg(map);
	}

}