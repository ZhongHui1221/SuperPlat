package com.zheling.sup.query.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zheling.base.mapper.AstCommonMapper;
import com.zheling.base.service.impl.BaseServiceImpl;
import com.zheling.sup.query.entity.BsAstCard;
import com.zheling.sup.query.mapper.BsAstCardMapper;
import com.zheling.sup.query.service.BsAstCardService;

@Service
@Transactional
public class BsAstCardServiceImpl extends BaseServiceImpl<BsAstCard> implements BsAstCardService {

	@Autowired
	private BsAstCardMapper bsAstCardMapper;
	@Autowired
	private AstCommonMapper astCommonMapper;

	@Override
	public void getCardsTotal(Map<String, Object> map) throws SQLException {
		bsAstCardMapper.callAcnumq(map);
	}

	@Override
	public void findCards(Map<String, Object> map) throws SQLException {
		bsAstCardMapper.callAcq(map);
	}

	@Override
	public void findCardDetail(Map<String, Object> map) throws SQLException {
		bsAstCardMapper.callAcmxq(map);
	}

	@Override
	public String modify(Map<String, Object> map) throws Exception {
		bsAstCardMapper.callAstCardUpd(map);
		return null;
	}

	@Override
	public boolean isChangedOnCards(Map<String, Object> map) throws SQLException {
		boolean isChanged = false;
		bsAstCardMapper.callBsdtq(map);
		List<Object> list = new ArrayList<Object>();
		list = (List<Object>) map.get("P_DS");
		Map<String, Object> result = new HashMap<String, Object>();
		result = (Map<String, Object>) list.get(0);
		if ("0".equals(result.get("COUNT(1)"))) {
			isChanged = false;
		} else {
			isChanged = true;
		}
		return isChanged;
	}

	@Override
	public void findModel(Map<String, Object> map) throws SQLException {
		bsAstCardMapper.callCbsmdefq(map);
	}

	@Override
	public void findCardZhejxx(Map<String, Object> map) throws SQLException {
		bsAstCardMapper.callQueryZhejmx(map);
	}

	@Override
	public void findCardWeixxx(Map<String, Object> map) throws SQLException {
		bsAstCardMapper.callWeixAwxq(map);
	}

	@Override
	public void findCardLogs(Map<String, Object> map) throws SQLException {
		bsAstCardMapper.callCardAclogq(map);
	}

	@Override
	public void findTotalOfRepairedCards(Map<String, Object> map) throws SQLException {
		bsAstCardMapper.callAstQueryAcwxnumq(map);
	}

	@Override
	public void findRepairedCards(Map<String, Object> map) throws SQLException {
		bsAstCardMapper.callAstQueryAcwxq(map);
	}

	@Override
	public void cardExport(Map<String, Map<String, Object>> map) throws SQLException {
		bsAstCardMapper.callAcqDaoc(map.get("rowsCondition"));
		bsAstCardMapper.callAstCommonZidydcq(map.get("colsCondition"));
	}

	@Override
	public void findFloorInfo(Map<String, Map<String, Object>> map) throws SQLException {
		bsAstCardMapper.callAstCardLoucq(map.get("floorCondition"));
		bsAstCardMapper.callAstCardFangjq(map.get("roomCondition"));
	}

	@Override
	public void findAdditionEquipments(Map<String, Object> map) throws SQLException {
		bsAstCardMapper.callQueryFussb(map);
	}

	@Override
	public String markAsPublic(Map<String, Object> map) throws Exception {
		bsAstCardMapper.callAstCardBiaosgy(map);
		return null;
	}

	@Override
	public String modifyCardPic(Map<String, Object> map) throws Exception {
		astCommonMapper.callAstCommonFujtpin(map);
		return null;
	}

}