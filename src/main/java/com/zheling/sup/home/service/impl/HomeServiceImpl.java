package com.zheling.sup.home.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.zheling.base.entity.BdOrg;
import com.zheling.base.mapper.BdOrgMapper;
import com.zheling.sup.home.service.HomeService;
import com.zheling.sup.query.mapper.BsAstCardMapper;

@Service
@Transactional
public class HomeServiceImpl implements HomeService {

	@Autowired
	private BsAstCardMapper bsAstCardMapper;
	@Autowired
	private BdOrgMapper bdOrgMapper;

	// 单位树 JSON（后期会将类型优化为 StringBuffer 或 StringBuilder）
	private String orgTreeJson = "";

	@Override
	public void main(Map<String, Map<String, Object>> map) throws SQLException {
		bsAstCardMapper.callAstQueryZcdl(map.get("zcdlCondition"));
		bsAstCardMapper.callAstQueryZdqk(map.get("zdqkCondition"));
		bsAstCardMapper.callAstQuerySyzt(map.get("syztCondition"));
	}

	@Override
	public String orgTree(Map<String, Object> map) {
		if (!"".equals(orgTreeJson)) {
			return JSON.parse(orgTreeJson).toString();
		}

		// 上级（sup）单位集合
		List<BdOrg> supOrgs = new ArrayList<BdOrg>();
		BdOrg bdOrg = bdOrgMapper.selectByPrimaryKey(map.get("orgid").toString());
		supOrgs.add(bdOrg);

		orgTreeJson += "[";
		recursion(supOrgs);
		if (orgTreeJson.substring(orgTreeJson.length() - 1).equals(",")) {
			orgTreeJson = orgTreeJson.substring(0, orgTreeJson.length() - 1);
		}
		orgTreeJson += "]";
		return JSON.parse(orgTreeJson).toString();
	}

	/**
	 * 递归算法构建单位树 by WGJ
	 * 
	 * @param orgs
	 */
	private void recursion(List<BdOrg> orgs) {
		for (BdOrg org : orgs) {
			orgTreeJson += "{'id':'" + org.getRwid() + "','text':'" + org.getObjname() + "',";
			// 下级（sub）单位集合
			List<BdOrg> subOrgs = bdOrgMapper.findOrgsByParentid(org.getRwid());
			// 如果存在下级（sub）单位
			if (subOrgs != null && subOrgs.size() > 0) {
				orgTreeJson += "'children':[";
				recursion(subOrgs);
				orgTreeJson = orgTreeJson.substring(0, orgTreeJson.length() - 1) + "]},";
			} else {
				orgTreeJson = orgTreeJson.substring(0, orgTreeJson.length() - 1) + "},";
			}
		}
	}

}