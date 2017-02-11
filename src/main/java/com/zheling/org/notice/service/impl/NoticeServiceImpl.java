package com.zheling.org.notice.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.zheling.base.mapper.AstCommonMapper;
import com.zheling.base.mapper.AstUserMapper;
import com.zheling.base.mapper.BdDeptMapper;
import com.zheling.org.notice.mapper.NoticeMapper;
import com.zheling.org.notice.service.NoticeService;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService {

	// 部门员工树 JSON（后期会将类型优化为 StringBuffer 或 StringBuilder）
	private String deptUserTreeJson = "";
	// 用户游标
	private List<Object> userCursor;

	@Autowired
	private NoticeMapper noticeMapper;
	@Autowired
	private BdDeptMapper bdDeptMapper;
	@Autowired
	private AstUserMapper astUserMapper;
	@Autowired
	private AstCommonMapper astCommonMapper;

	@Override
	public void findNotices(Map<String, Object> map) throws SQLException {
		noticeMapper.callCoreNtget(map);
	}

	@Override
	public String addNotice(Map<String, Object> map) throws SQLException {
		noticeMapper.callNtDefin(map);
		return null;
	}

	@Override
	public String markAsRead(Map<String, Object> map) throws Exception {
		noticeMapper.callNtDonein(map);
		return null;
	}

	@Override
	public void findNoticesForMng(Map<String, Object> map) throws SQLException {
		noticeMapper.callNtDefq(map);
	}

	@Override
	public String deptUserTree(Map<String, Object> map) {
		if (!"".equals(deptUserTreeJson)) {
			return JSON.parse(deptUserTreeJson).toString();
		}

		Map<String, Object> userCondition = new HashMap<String, Object>(map);
		try {
			astUserMapper.callAstUserUserq(userCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		userCursor = (List<Object>) userCondition.get("P_DS");

		Map<String, Object> deptCondition = new HashMap<String, Object>(map);
		try {
			bdDeptMapper.callCoreGetdept(deptCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		List<Object> deptCursor = (List<Object>) deptCondition.get("P_DS");

		deptUserTreeJson += "[";
		recursion(deptCursor);
		if (deptUserTreeJson.substring(deptUserTreeJson.length() - 1).equals(",")) {
			deptUserTreeJson = deptUserTreeJson.substring(0, deptUserTreeJson.length() - 1);
		}
		deptUserTreeJson += "]";
		return JSON.parse(deptUserTreeJson).toString();
	}

	/**
	 * 递归算法构建部门树 by WGJ
	 * 
	 * @param supDepts
	 *            上级（sup）部门集合
	 */
	private void recursion(List<Object> supDepts) {
		for (int i = 0; i < supDepts.size(); i++) {
			Map<String, Object> supMap = (Map<String, Object>) supDepts.get(i);
			String supDeptId = supMap.get("RWID").toString();
			Object supDeptName = supMap.get("OBJNAME");

			deptUserTreeJson += "{'id':'" + supDeptId + "','name':'" + supDeptName + "',";

			// 部门员工集合
			List<Object> users = new ArrayList<Object>();
			for (int j = 0; j < userCursor.size(); j++) {
				Map<String, Object> userMap = (Map<String, Object>) userCursor.get(j);
				if (userMap.get("MNGDEPIDS") != null) {
					String userDepts = userMap.get("MNGDEPIDS").toString();
					if (userDepts.contains(supDeptId)) {
						users.add(userCursor.get(j));
					}
				}
			}

			if (users.size() > 0) {
				deptUserTreeJson += "'member':[";
				for (int j = 0; j < users.size(); j++) {
					Map<String, Object> userMap = (Map<String, Object>) userCursor.get(j);
					Object userId = userMap.get("RWID");
					Object userName = userMap.get("OBJNAME");
					deptUserTreeJson += "{'id':'" + userId + "','name':'" + userName + "'},";
				}
				deptUserTreeJson = deptUserTreeJson.substring(0, deptUserTreeJson.length() - 1)
						+ "],";
			}

			// 下级（sub）部门集合
			List<Object> subDepts = new ArrayList<Object>();
			for (int j = 0; j < supDepts.size(); j++) {
				Map<String, Object> subMap = (Map<String, Object>) supDepts.get(j);
				Object subParentId = subMap.get("PARENTID");
				if (supDeptId.equals(subParentId)) {
					subDepts.add(supDepts.get(j));
				}
			}

			// 如果存在下级（sub）部门
			if (subDepts.size() > 0) {
				deptUserTreeJson += "'open':'true','children':[";
				recursion(subDepts);
				deptUserTreeJson = deptUserTreeJson.substring(0, deptUserTreeJson.length() - 1)
						+ "]},";
			} else {
				deptUserTreeJson = deptUserTreeJson.substring(0, deptUserTreeJson.length() - 1)
						+ "},";
			}
		}
	}

	@Override
	public void findNoticeAtts(Map<String, Object> map) throws SQLException {
		astCommonMapper.callAstCommonFujtpq(map);
	}

	@Override
	public String modifyNoticeAtts(Map<String, Object> map) throws Exception {
		astCommonMapper.callAstCommonFujtpin(map);
		return null;
	}

	@Override
	public String removeNotices(Map<String, Object> map) throws Exception {
		noticeMapper.callNtDefd(map);
		return null;
	}

}