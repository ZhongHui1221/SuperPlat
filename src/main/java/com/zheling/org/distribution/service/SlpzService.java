package com.zheling.org.distribution.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.zheling.base.entity.BdAstYongt;

public interface SlpzService {

	void findDaitjTotal(Map<String, Object> daitjTotalCondition) throws SQLException;

	void findDaitjDetail(Map<String, Object> daitjDetailCondition) throws SQLException;

	String createShenld(Map<String, Object> daitjDetailCondition) throws Exception;

	String deleteShenld(Map<String, Object> daitjDetailCondition) throws Exception;

	String submitShenld(Map<String, Object> daitjDetailCondition) throws Exception;

	List<BdAstYongt> findYongt();

}
