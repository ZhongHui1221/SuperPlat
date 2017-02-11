package com.zheling.base.vo;

import java.util.ArrayList;
import java.util.List;

public class UserVo {

	private List<Object> userCursor = new ArrayList<Object>();
	private List<Object> roleCursor = new ArrayList<Object>();

	private String id; // 用户 ID
	private String name; // 用户姓名
	private String danwxzlxcode; // 单位行政类型编号
	private String topOrgId; // 顶级单位 ID
	private String currentOrgId; // 当前单位 ID
	private String currentRoleId; // 当前角色 ID
	private String currentRoleCode; // 当前角色编号
	private String currentRoleName; // 当前角色名称

	public List<Object> getUserCursor() {
		return userCursor;
	}

	public void setUserCursor(List<Object> userCursor) {
		this.userCursor = userCursor;
	}

	public List<Object> getRoleCursor() {
		return roleCursor;
	}

	public void setRoleCursor(List<Object> roleCursor) {
		this.roleCursor = roleCursor;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDanwxzlxcode() {
		return danwxzlxcode;
	}

	public void setDanwxzlxcode(String danwxzlxcode) {
		this.danwxzlxcode = danwxzlxcode;
	}

	public String getTopOrgId() {
		return topOrgId;
	}

	public void setTopOrgId(String topOrgId) {
		this.topOrgId = topOrgId;
	}

	public String getCurrentOrgId() {
		return currentOrgId;
	}

	public void setCurrentOrgId(String currentOrgId) {
		this.currentOrgId = currentOrgId;
	}

	public String getCurrentRoleId() {
		return currentRoleId;
	}

	public void setCurrentRoleId(String currentRoleId) {
		this.currentRoleId = currentRoleId;
	}

	public String getCurrentRoleCode() {
		return currentRoleCode;
	}

	public void setCurrentRoleCode(String currentRoleCode) {
		this.currentRoleCode = currentRoleCode;
	}

	public String getCurrentRoleName() {
		return currentRoleName;
	}

	public void setCurrentRoleName(String currentRoleName) {
		this.currentRoleName = currentRoleName;
	}

	/**
	 * 获取系统版本（根据当前角色判断，用以确定应访问主管版还是单位版） by WGJ
	 * 
	 * @param currentUser
	 * @return
	 */
	public String getCurrentEdition() {
		// 主管部门（008）、专管员/经办人（009）
		if ("008".equals(currentRoleCode) || "009".equals(currentRoleCode)) {
			return "sup";
		} else {
			return "org";
		}
	}

}