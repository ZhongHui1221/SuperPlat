package com.zheling.sup.query.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.zheling.base.mapper.BaseMapper;
import com.zheling.sup.query.entity.BsAstCard;

@Repository
public interface BsAstCardMapper extends BaseMapper<BsAstCard> {

	/**
	 * 资产大类查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryZcdl(Map<String, Object> map) throws SQLException;

	/**
	 * 重点情况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryZdqk(Map<String, Object> map) throws SQLException;

	/**
	 * 使用状态查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQuerySyzt(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片总体情况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAcnumq(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAcq(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片详情信息查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAcmxq(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片信息修改 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCardUpd(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片动态查询(是否有变动) --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callBsdtq(Map<String, Object> map) throws SQLException;

	/**
	 * 附属设备查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callQueryFussb(Map<String, Object> map) throws SQLException;

	/**
	 * 业务模型定义查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callCbsmdefq(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片折旧明细信息查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callQueryZhejmx(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片维修情况查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callWeixAwxq(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片业务日志信息查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callCardAclogq(Map<String, Object> map) throws SQLException;

	/**
	 * 维修卡片数量查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryAcwxnumq(Map<String, Object> map) throws SQLException;

	/**
	 * 维修卡片情况查询(用于生成卡片列表) --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstQueryAcwxq(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片导出查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAcqDaoc(Map<String, Object> map) throws SQLException;

	/**
	 * 自定义列查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCommonZidydcq(Map<String, Object> map) throws SQLException;

	/**
	 * 楼层信息查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCardLoucq(Map<String, Object> map) throws SQLException;

	/**
	 * 房间信息查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCardFangjq(Map<String, Object> map) throws SQLException;

	/**
	 * （取消）标记为公用资产 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCardBiaosgy(Map<String, Object> map) throws SQLException;

}