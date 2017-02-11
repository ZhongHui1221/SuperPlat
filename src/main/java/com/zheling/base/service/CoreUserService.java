package com.zheling.base.service;

import java.sql.SQLException;
import java.util.Map;

import com.zheling.base.entity.CoreUser;

public interface CoreUserService extends BaseService<CoreUser> {

	/**
	 * 登录验证 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void login(Map<String, Object> map) throws SQLException;

	/**
	 * 用户注册 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	String register(Map<String, Object> map) throws Exception;

	/**
	 * 修改用户 by WGJ
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	String modify(Map<String, Object> map) throws Exception;

	/**
	 * 盘点使用人查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findPdUsers(Map<String, Object> map) throws SQLException;

	/**
	 * 用户查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findUsers(Map<String, Object> map) throws SQLException;

}