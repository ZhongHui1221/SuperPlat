package com.zheling.base.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.zheling.base.component.GlobalComponent;
import com.zheling.base.entity.BdAstZicdl;
import com.zheling.base.entity.BdAstZicfl;
import com.zheling.base.mapper.AstZicflMapper;
import com.zheling.base.service.ZicflService;

/**
 * 通过父级id查询资产分类,用于公用组件资产分类查询
 * 
 * @author hugo
 *
 */
@Service
@Transactional
public class ZicflServiceImpl implements ZicflService {

	@Autowired
	private AstZicflMapper astZicflMapper;

	private String zicflTreeJson;
	private List<Object> cyZcflList = new ArrayList<Object>();
	private Integer startLev;

	private String xxzcflTreeJson;

	@Override
	public void findCyZicfl(Map<String, Object> map) throws SQLException {
		astZicflMapper.callAstZicflQcybyparentid(map);
	}

	@Override
	public void findZicflQuick(Map<String, Object> map) throws SQLException {
		astZicflMapper.callAstZicflQuickq(map);
	}

	@Override
	public void findXxZicfl(Map<String, Object> map) throws SQLException {
		astZicflMapper.callAstZicflQbyparentid(map);
	}

	@Override
	public String cyZicflTree() throws SQLException {
		// 初始清空cyZcflList
		cyZcflList.clear();
		// 组装查询条件,查询常用资产顶级目录
		Map<String, Object> cyTopCondition = new HashMap<String, Object>();
		// 查询
		astZicflMapper.callAstZicflQcybyparentid(cyTopCondition);
		// 获取查询结果集
		List<Object> cyTopZicfls = (List<Object>) cyTopCondition.get("P_DS");
		/*
		 * // 创建常用资产分类二级及其子集容器 List<Object> cySubZicfl = new
		 * ArrayList<Object>();
		 */
		if (cyTopZicfls != null && cyTopZicfls.size() > 0) {
			// 遍历查询常用资产分类及其子集
			for (Object obj : cyTopZicfls) {
				Map<String, Object> cyTopZicfl = (Map<String, Object>) obj;
				String topParentId = cyTopZicfl.get("RWID").toString();
				// 组装查询条件
				Map<String, Object> cyCondition = new HashMap<String, Object>();
				cyCondition.put("parentid", topParentId);
				// 查询
				astZicflMapper.callAstZicflQcybyparentid(cyCondition);
				// 获取结果集
				List<Object> zcflCur = (List<Object>) cyCondition.get("P_DS");
				// 为了避免当前缓存机制引起的修改累积效应，故将此对象copy
				List<Object> tempZcflCur = new ArrayList<Object>();
				tempZcflCur.addAll(zcflCur);
				// 建树
				recursionList(tempZcflCur, null);
			}
			return JSON.toJSONString(cyZcflList);
		}
		return null;
	}

	@Override
	public String xxZicflTree() throws SQLException {
		//初始化字符串
		xxzcflTreeJson = "";
		// 通过全局组件获取资产分类集合(不含资产大类)
		List<BdAstZicfl> Zicfls = GlobalComponent.zcflList;
		/* 获取资产大类 --BEGIN */
		List<BdAstZicdl> zicdls = astZicflMapper.findZcdls();
		/* 获取资产大类 --END */
		// copy一份资产大类
		List<Object> result = new ArrayList<Object>();
		result.addAll(zicdls);
		xxzcflTreeJson += "[";
		for (Object obj : result) {
			BdAstZicdl zicdl = (BdAstZicdl) obj;
			String zicdlId = zicdl.getRwid();
			String objname = zicdl.getObjname();
			xxzcflTreeJson += "{id:'" + zicdlId + "',name:'" + objname + "',";
			List<BdAstZicfl> supZicfls = findZcflByDlId(zicdlId);
			if(supZicfls.size() > 0){
				xxzcflTreeJson += "children:[";
				recursionXxList(supZicfls);
				xxzcflTreeJson += "]";
			}
			if(xxzcflTreeJson.substring(xxzcflTreeJson.length() - 1).equals(",")){
				xxzcflTreeJson = xxzcflTreeJson.substring(0, xxzcflTreeJson.length() - 1);
			}
			xxzcflTreeJson += "},";
		}
		if(xxzcflTreeJson.substring(xxzcflTreeJson.length() - 1).equals(",")){
			xxzcflTreeJson = xxzcflTreeJson.substring(0, xxzcflTreeJson.length() - 1);
		}
		xxzcflTreeJson += "]";
		System.out.println(xxzcflTreeJson);
		return JSON.parse(xxzcflTreeJson).toString();
	}

	public String zicflTree(String type) {
		// 读取资产分类的层级
		Integer level = null;
		// 字符串初始化
		zicflTreeJson = "";
		Map<String, Object> zicflCondition = new HashMap<String, Object>();
		zicflCondition.put("parentid", null);
		try {
			if ("0".equals(type)) {
				astZicflMapper.callAstZicflQcybyparentid(zicflCondition);
			} else {
				astZicflMapper.callAstZicflQbyparentid(zicflCondition);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 查询结果集
		List<Object> zcflCursor = (List<Object>) zicflCondition.get("P_DS");
		if (zcflCursor != null && zcflCursor.size() > 0) {
			for (Object obj : zcflCursor) {
				Map<String, Object> zhflMap = (Map<String, Object>) obj;
				String topParentId = zhflMap.get("RWID").toString();
				Map<String, Object> zicflCon = new HashMap<String, Object>();
				zicflCon.put("parentid", topParentId);
				try {
					if ("0".equals(type)) {
						astZicflMapper.callAstZicflQcybyparentid(zicflCon);
					} else {
						astZicflMapper.callAstZicflQbyparentid(zicflCon);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				// 获取查询结果集
				List<Object> zcflCur = (List<Object>) zicflCon.get("P_DS");
				if ("0".equals(type)) {
					List<Object> newzcflCur = new ArrayList<Object>();
					for (Object objTemp : zcflCur) {
						Map<String, Object> zcflTemplMap = (Map<String, Object>) objTemp;
						if (zcflTemplMap.get("PARENTID") != null) {
							newzcflCur.add(zcflTemplMap);
						}
					}
					zcflCur = newzcflCur;
					level = 1;
				}
				recursionZcflList(zcflCur, level);
			}

			zicflTreeJson += JSON.toJSONString(cyZcflList);
			return JSON.parse(zicflTreeJson).toString();
		}
		return null;
	}

	private void recursionList(List<Object> source, Integer level) {
		Integer lev;
		if (level == null) {
			// cyZcflList = new ArrayList<Object>();
			level = 1;
		} else {
			level++;
		}
		for (int i = 0; i < source.size(); i++) {
			Map<String, Object> supZicfl = (Map<String, Object>) source.get(i);
			String supRwid = supZicfl.get("RWID").toString();
			if (supZicfl.get("LEV") == null) {
				lev = 1;
			} else {
				lev = Integer.valueOf(supZicfl.get("LEV").toString());
			}
			if (level.equals(lev)) {
				// 下级资产分类集合
				List<Object> subZicfls = new ArrayList<Object>();
				for (int j = 0; j < source.size(); j++) {
					Map<String, Object> subZicfl = (Map<String, Object>) source.get(j);
					Object subParentid = subZicfl.get("PARENTID");
					Object subRwid = subZicfl.get("RWID");
					if (supRwid.equals(subParentid) && !subRwid.equals(subParentid)) {
						subZicfls.add(subZicfl);
					}
				}
				// 如果存在下级分类
				if (subZicfls.size() > 0) {
					// 添加子集
					supZicfl.put("children", subZicfls);
					if (level == 1) {
						cyZcflList.add(supZicfl);
					}
					// 寻找子集的子集
					recursionList(source, level);
				} else {
					if (lev < 3) {
						/*
						 * 此操作会引起JSON的重复引用错误 subZicfls.add(supZicfl);
						 */
						// 为避免JSON的重复引用生成"$ref":".."错误的字符串，先把对象copy一份，再引用。
						Map<String, Object> tempMap = new HashMap<String, Object>();
						tempMap.putAll(supZicfl);
						subZicfls.add(tempMap);
						supZicfl.put("children", subZicfls);
					}
				}
			} else {
				continue;
			}
		}
	}

	private void recursionXxList(List<BdAstZicfl> supZicfls) {
		for (Object obj : supZicfls) {
			BdAstZicfl zicfl = (BdAstZicfl) obj;
			String supRwid = zicfl.getRwid();
			String objname = zicfl.getObjname();
			xxzcflTreeJson += "{'id':'" + supRwid + "','name':'" + objname + "',";
			//下级资产集合
			List<BdAstZicfl> subZcfls = findSubzcflByParentId(supRwid);
			// 如果存在下级分类
			if (subZcfls.size() > 0) {
				xxzcflTreeJson += "'children':[";
				recursionXxList(subZcfls);
				xxzcflTreeJson = xxzcflTreeJson.substring(0, xxzcflTreeJson.length() - 1) + "]},";
			}else{
				xxzcflTreeJson = xxzcflTreeJson.substring(0, xxzcflTreeJson.length() - 1) + "},";
			}
		}

	}

	private List<BdAstZicfl> findSubzcflByParentId(String parentId) {
		// 通过全局组件获取资产分类集合
		List<BdAstZicfl> Zicfls = GlobalComponent.zcflList;
		// 创建存放子集的集合
		List<BdAstZicfl> result = new ArrayList<BdAstZicfl>();
		for (BdAstZicfl zcfl : Zicfls) {
			String rwid = zcfl.getParentid();
			if (parentId.equals(rwid)) {
				result.add(zcfl);
			}
		}
		return result;
	}
	
	private List<BdAstZicfl> findZcflByDlId(String dlId){
		// 通过全局组件获取资产分类集合
		List<BdAstZicfl> Zicfls = GlobalComponent.zcflList;
		// 创建存放子集的集合
		List<BdAstZicfl> result = new ArrayList<BdAstZicfl>();
		for(BdAstZicfl zcfl : Zicfls){
			String parentId = zcfl.getParentid();
			String zcdlId = zcfl.getZicdlid();
			if(parentId == null && dlId.equals(zcdlId)){
				result.add(zcfl);
			}
		}
		return result;
	}

	private void recursionZcflList(List<Object> source, Integer level) {
		Integer lev;
		if (cyZcflList == null) {
			cyZcflList = new ArrayList<Object>();
		}
		if (level == null || level < 0) {
			level = 1;
		} else {
			level++;
		}
		for (int i = 0; i < source.size(); i++) {
			Map<String, Object> supZicfl = (Map<String, Object>) source.get(i);
			String supRwid = supZicfl.get("RWID").toString();
			if (supZicfl.get("LEV") == null) {
				lev = 1;
			} else {
				lev = Integer.valueOf(supZicfl.get("LEV").toString());
			}
			if (level.equals(lev)) {
				// 下级资产分类集合
				List<Object> subZicfls = new ArrayList<Object>();
				for (int j = 0; j < source.size(); j++) {
					Map<String, Object> subZicfl = (Map<String, Object>) source.get(j);
					Object subParentid = subZicfl.get("PARENTID");
					Object subRwid = subZicfl.get("RWID");
					if (supRwid.equals(subParentid) && !subRwid.equals(subParentid)) {
						subZicfls.add(subZicfl);
					}
				}
				// 如果存在下级分类
				if (subZicfls.size() > 0) {
					// 添加子集
					supZicfl.put("children", subZicfls);
					if (level == startLev) {
						cyZcflList.add(supZicfl);
					}
					// 寻找子集的子集
					recursionZcflList(source, level);
				}
			} else {
				continue;
			}
		}
	}

}
