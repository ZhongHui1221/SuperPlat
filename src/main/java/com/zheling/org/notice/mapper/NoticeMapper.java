package com.zheling.org.notice.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface NoticeMapper {

	/**
	 * 公告查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callCoreNtget(Map<String, Object> map) throws SQLException;

	/**
	 * 添加公告 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callNtDefin(Map<String, Object> map) throws SQLException;

	/**
	 * 将公告标记为已阅 by WGJ
	 * 
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	void callNtDonein(Map<String, Object> map) throws SQLException;

	/**
	 * 公告查询 - 管理员 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callNtDefq(Map<String, Object> map) throws SQLException;

	/**
	 * 删除公告 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callNtDefd(Map<String, Object> map) throws SQLException;

}