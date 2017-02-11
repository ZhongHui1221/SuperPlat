package com.zheling.sup.query.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface YtflMapper {

	/**
	 * 用途分类查询
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryYTQ(Map<String, Object> map) throws SQLException;

}