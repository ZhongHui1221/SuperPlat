package com.zheling.sup.query.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface FbqkMapper {

	/**
	 * 分布情况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryHuizDeptq(Map<String, Object> map) throws SQLException;

}