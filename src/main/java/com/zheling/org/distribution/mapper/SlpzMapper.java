package com.zheling.org.distribution.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.zheling.base.entity.BdAstYongt;

@Repository
public interface SlpzMapper {

	/**
	 * 申领配置情况总数量查询(分页用) --hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPeizPznumq(Map<String, Object> map) throws SQLException;

	/**
	 * 申领配置情况查询 --hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPeizPzq(Map<String, Object> map) throws SQLException;

	/**
	 * 新增申领 --hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPeizPzin(Map<String, Object> map) throws Exception;

	/**
	 * 删除申领单 --hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstPeizPzout(Map<String, Object> map) throws Exception;

	/**
	 * 提交申领单 --hugo
	 * 
	 * @param map
	 * @throws Exception
	 */
	void callAstPeizSubmit(Map<String, Object> map) throws Exception;

	/**
	 * 查询用途实体 --hugo
	 * 
	 * @return 用途list
	 */
	List<BdAstYongt> findYongt();

}