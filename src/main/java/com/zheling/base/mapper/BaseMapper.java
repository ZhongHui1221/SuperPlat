package com.zheling.base.mapper;

import java.util.List;
import java.util.Map;

/**
 * 基础 Mapper 接口
 * 
 * @author WGJ
 *
 * @param <T>
 */
public interface BaseMapper<T> {

	T selectByPrimaryKey(String id);

	List<T> selectAll();

	int insert(T entity);

	int updateByPrimaryKey(T entity);

	int deleteByPrimaryKey(String id);

	int getTotalCount();

	List<T> getResults(Map<String, Object> map);

}