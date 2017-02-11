package com.zheling.org.notice.service;

import java.sql.SQLException;
import java.util.Map;

public interface NoticeService {

	/**
	 * 公告查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findNotices(Map<String, Object> map) throws SQLException;

	/**
	 * 添加公告 by WGJ
	 * 
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	String addNotice(Map<String, Object> map) throws Exception;

	/**
	 * 将公告标记为已阅 by WGJ
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	String markAsRead(Map<String, Object> map) throws Exception;

	/**
	 * 公告查询 - 管理员 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findNoticesForMng(Map<String, Object> map) throws SQLException;

	/**
	 * 构建部门员工树 by WGJ
	 * 
	 * @param map
	 * @return
	 */
	String deptUserTree(Map<String, Object> map);

	/**
	 * 公告附件查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findNoticeAtts(Map<String, Object> map) throws SQLException;

	/**
	 * 修改（添加）公告附件 by WGJ
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	String modifyNoticeAtts(Map<String, Object> map) throws Exception;

	/**
	 * 删除公告 by WGJ
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	String removeNotices(Map<String, Object> map) throws Exception;

}