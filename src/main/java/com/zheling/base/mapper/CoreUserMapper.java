package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.zheling.base.entity.CoreUser;

@Repository
public interface CoreUserMapper extends BaseMapper<CoreUser> {

	/**
	 * 登录验证 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callCoreLogin(Map<String, Object> map) throws SQLException;

	void callCoreGetusers(Map<String, Object> map) throws SQLException;

	/**
	 * 根据 deptid 查询用户 by WGJ
	 * 
	 * @param deptid
	 * @return
	 */
	List<CoreUser> findUsersByDeptid(String deptid);

}