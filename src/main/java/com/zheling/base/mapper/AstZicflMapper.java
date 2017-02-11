package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.zheling.base.entity.BdAstZicdl;

@Repository
public interface AstZicflMapper {

	/**
	 * 常用资产分类查询 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstZicflQcybyparentid(Map<String, Object> map) throws SQLException;

	/**
	 * 资产分类快速查询 --hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstZicflQuickq(Map<String, Object> map) throws SQLException;

	/**
	 * 详细资产分类查询 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstZicflQbyparentid(Map<String, Object> map) throws SQLException;
	
	/**
	 * 资产大类查询 by hugo
	 * @return 资产大类集合
	 * @throws SQLException
	 */
	List<BdAstZicdl> findZcdls() throws SQLException; 
}