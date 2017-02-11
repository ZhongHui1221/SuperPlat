package com.zheling.base.service;

import java.util.List;

import com.zheling.base.util.Page;

/**
 * 基础 Service 接口
 * 
 * @author WGJ
 *
 * @param <T>
 */
public interface BaseService<T> {

	T getEntity(String id);

	List<T> findAll();

	int add(T entity);

	int update(T entity);

	int delete(String id);

	Page<T> getPage(int pageSize, int pageNo);

}