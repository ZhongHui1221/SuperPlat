package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface AstUserMapper {

	/**
	 * 用户查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstUserUserq(Map<String, Object> map) throws SQLException;

	/**
	 * 添加用户 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstUserUserin(Map<String, Object> map) throws SQLException;

	/**
	 * 修改用户 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstUserUserupd(Map<String, Object> map) throws SQLException;

	/**
	 * 删除用户 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstUserUserout(Map<String, Object> map) throws SQLException;

	/**
	 * 存放地点查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstUserCunfddq(Map<String, Object> map) throws SQLException;

	/**
	 * 添加存放地点 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstUserCunfddin(Map<String, Object> map) throws SQLException;

	/**
	 * 修改存放地点 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstUserCunfddupd(Map<String, Object> map) throws SQLException;

	/**
	 * 删除存放地点 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstUserCunfddout(Map<String, Object> map) throws SQLException;

}