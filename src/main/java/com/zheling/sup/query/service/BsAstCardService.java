package com.zheling.sup.query.service;

import java.sql.SQLException;
import java.util.Map;

import com.zheling.base.service.BaseService;
import com.zheling.sup.query.entity.BsAstCard;

public interface BsAstCardService extends BaseService<BsAstCard> {

	/**
	 * 卡片总体情况查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void getCardsTotal(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片信息查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findCards(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片详情查询 by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findCardDetail(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片信息修改 by WGJ
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	String modify(Map<String, Object> map) throws Exception;

	/**
	 * 卡片是否有变动 by hugo
	 * 
	 * @param map
	 * @return isChanged
	 * @throws SQLException
	 */
	boolean isChangedOnCards(Map<String, Object> map) throws SQLException;

	/**
	 * 模板类型及相关字段对应中文名查询 --by hugo
	 * 
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	void findModel(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片折旧信息查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findCardZhejxx(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片维修情况查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findCardWeixxx(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片业务信息查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findCardLogs(Map<String, Object> map) throws SQLException;

	/**
	 * 维修业务卡片总体情况查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findTotalOfRepairedCards(Map<String, Object> map) throws SQLException;

	/**
	 * 维修业务卡片查询 -by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findRepairedCards(Map<String, Object> map) throws SQLException;

	/**
	 * 卡片导出汇总查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void cardExport(Map<String, Map<String, Object>> map) throws SQLException;

	/**
	 * 楼层信息查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findFloorInfo(Map<String, Map<String, Object>> map) throws SQLException;

	/**
	 * 附属卡片查询 --by hugo
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void findAdditionEquipments(Map<String, Object> map) throws SQLException;

	/**
	 * （取消）标记为公用资产 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	String markAsPublic(Map<String, Object> map) throws Exception;

	/**
	 * 修改（添加）卡片图片 by WGJ
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	String modifyCardPic(Map<String, Object> map) throws Exception;

}