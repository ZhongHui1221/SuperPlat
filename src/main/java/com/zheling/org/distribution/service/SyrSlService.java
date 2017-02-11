package com.zheling.org.distribution.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.zheling.base.entity.BdAstYongt;

public interface SyrSlService {
	
	void findDaitj(Map<String, Map<String, Object>> daitjCondition) throws SQLException;
	
	List<BdAstYongt> findYongt();

}
