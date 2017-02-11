package com.zheling.base.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.zheling.base.mapper.BaseMapper;
import com.zheling.base.service.BaseService;
import com.zheling.base.util.Page;

/**
 * 基础 Service 实现类
 * 
 * @author WGJ
 *
 * @param <T>
 */
public class BaseServiceImpl<T> implements BaseService<T> {

	@Autowired
	private BaseMapper<T> baseMapper;

	@Override
	public T getEntity(String id) {
		return baseMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<T> findAll() {
		return baseMapper.selectAll();
	}

	@Override
	public int add(T entity) {
		return baseMapper.insert(entity);
	}

	@Override
	public int update(T entity) {
		return baseMapper.updateByPrimaryKey(entity);
	}

	@Override
	public int delete(String id) {
		return baseMapper.deleteByPrimaryKey(id);
	}

	@Override
	public Page<T> getPage(int pageSize, int pageNo) {
		int totalCount = baseMapper.getTotalCount();

		Page<T> page = new Page<T>(pageSize, pageNo, totalCount);
		int fromIndex = (page.getPageNo() - 1) * Page.PAGE_SIZE + 1;
		int endIndex = fromIndex + Page.PAGE_SIZE;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fromIndex", fromIndex);
		map.put("endIndex", endIndex);
		List<T> results = baseMapper.getResults(map);
		page.setResults(results);
		return page;
	}

}