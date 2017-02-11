package com.zheling.sup.query.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface FwxxMapper {

	/**
	 * 房屋信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryFwxxq(Map<String, Object> map) throws SQLException;

}