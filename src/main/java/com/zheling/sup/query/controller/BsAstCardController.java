package com.zheling.sup.query.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.zheling.base.component.GlobalComponent;
import com.zheling.base.controller.BaseController;
import com.zheling.base.util.Page;
import com.zheling.base.vo.CardExportVo;
import com.zheling.base.vo.FloorVo;
import com.zheling.sup.query.service.BsAstCardService;

@Controller
@RequestMapping("/Query/BsAstCard")
public class BsAstCardController extends BaseController {

	// 来源模块（用于标识是从何处穿透至卡片列表）
	private String fromModel;

	@Autowired
	private BsAstCardService bsAstCardService;

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public String list(@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(value = "dateStr", defaultValue = "") String dateStr,
			@RequestParam(value = "zicflidStr", defaultValue = "") String zicflidStr,
			@RequestParam(value = "yongtidStr", defaultValue = "") String yongtidStr,
			@RequestParam(value = "shiyzkidStr", defaultValue = "") String shiyzkidStr,
			@RequestParam(value = "keyvalueStr", defaultValue = "") String keyvalueStr,
			@RequestParam(value = "sortpartStr", defaultValue = "") String sortpartStr,
			@RequestParam(value = "timeStr", defaultValue = "") String timeStr,
			@RequestParam(value = "mothStr", defaultValue = "") String mothStr,
			@RequestParam(value = "weixfsidStr", defaultValue = "") String weixfsidStr,
			@RequestParam(value = "zicdlrwidStr", defaultValue = "") String zicdlrwidStr,
			@RequestParam(value = "beginDateStr", defaultValue = "") String beginDateStr,
			@RequestParam(value = "endDateStr", defaultValue = "") String endDateStr,
			@RequestParam(value = "qudfsidStr", defaultValue = "") String qudfsidStr,
			@RequestParam(value = "viewMode", required = false) String viewMode,
			HttpServletRequest request) {
		// 处理多 ID 拼接的传输格式
		String yongtid = processIdStr(yongtidStr);
		String zicflid = processIdStr(zicflidStr);

		// 默认 timeStr 为当前年
		if ("".equals(timeStr)) {
			timeStr = formatDate(new Date(), "yyyy");
		}
		// 处理月份为 all 的情况
		if ("all".equals(mothStr)) {
			mothStr = "";
		}

		// 接收分布情况模块的特别参数并直接回传
		String fbqkType = request.getParameter("fbqkType");
		String fbqkOrgid = request.getParameter("fbqkOrgid");
		String fbqkDeptid = request.getParameter("fbqkDeptid");
		request.setAttribute("fbqkType", fbqkType);
		request.setAttribute("fbqkOrgid", fbqkOrgid);
		request.setAttribute("fbqkDeptid", fbqkDeptid);

		/* 卡片总体情况查询 —— BEGIN */
		// 查询条件组装
		Map<String, Object> cardsTotalCondition = new HashMap<String, Object>(baseCondition);
		cardsTotalCondition.put("querytype", "0");
		cardsTotalCondition.put("keyvalue", keyvalueStr);

		// 维修情况
		if ("wxqk_main".equals(fromModel)) {
			cardsTotalCondition.put("time", timeStr);
			cardsTotalCondition.put("moth", mothStr);
			cardsTotalCondition.put("condsql", "AND WX.WEIXFSID = '" + weixfsidStr + "'");
		}
		// 常用资产 - 使用状况
		else if ("cyzc_syzk".equals(fromModel)) {
			cardsTotalCondition.put("condsql", "AND C.YONGTID IN (" + yongtid
					+ ") AND C.ZICFLID IN (" + zicflid
					+ ") AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '" + dateStr
					+ "' AND C.SHIYZKID = '" + shiyzkidStr + "'");
		}
		// 构成情况
		else if ("gcqk_main".equals(fromModel)) {
			cardsTotalCondition.put("condsql", "AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '"
					+ dateStr + "' AND DL.RWID = '" + zicdlrwidStr + "'");
		}
		// 增加情况
		else if ("zjqk_main".equals(fromModel)) {
			cardsTotalCondition.put("condsql", "AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '"
					+ endDateStr + "' AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') >= '" + beginDateStr
					+ "' AND C.QUDFSID = '" + qudfsidStr + "'");
		}
		// 使用情况
		else if ("syzk_main".equals(fromModel)) {
			cardsTotalCondition.put("condsql",
					"AND DL.RWID <> '3DCA958F0000002178673E76D0CE4984' AND C.SHIYZKID = '"
							+ shiyzkidStr + "'");
		}
		// 用途分类
		else if ("ytfl_main".equals(fromModel)) {
			cardsTotalCondition.put("condsql", "AND C.YONGTID = '" + yongtidStr + "'");
		}
		// 待报废资产
		else if ("dbfqk_main".equals(fromModel)) {
			cardsTotalCondition.put("condsql", "AND DL.RWID = '" + zicdlrwidStr + "'");
		}
		// 入账情况
		else if ("rzqk_main".equals(fromModel)) {
			cardsTotalCondition.put("condsql", "AND DL.RWID = '" + zicdlrwidStr + "'");
		}
		// 分布情况
		else if ("fbqk_main".equals(fromModel)) {
			cardsTotalCondition.put("orgid", fbqkOrgid);
			// 使用状况
			if ("1".equals(fbqkType)) {
				// 部门资产
				if (StringUtils.isNotBlank(fbqkDeptid)) {
					cardsTotalCondition.put("condsql", "AND (C.SHIYZKID = '" + shiyzkidStr
							+ "') AND ((C.SHIYBMID = '" + fbqkDeptid
							+ "') OR (C.SHIYBMID IS NULL AND C.GUANLBMID = '" + fbqkDeptid + "'))");
				}
				// 单位资产
				else {
					cardsTotalCondition.put("condsql", "AND (C.SHIYZKID = '" + shiyzkidStr
							+ "') AND (C.SHIYBMID IS NULL) AND (DG.OBJNAME IS NULL)");
				}
			}
			// 使用人
			else if ("3".equals(fbqkType)) {
				cardsTotalCondition.put("condsql", "AND C.SHIYBMID = '" + fbqkDeptid
						+ "' AND (C.SHIYRID = '" + shiyzkidStr + "')");
			}
		}
		// 闲置房产
		else if ("xzfc".equals(fromModel)) {
			cardsTotalCondition.put("orgid", shiyzkidStr);
			cardsTotalCondition
					.put("condsql",
							"AND C.SHIYZKID IN ('3F5B09C1400000010A9442FDA2091273', '3F5B0C396000000170CA046A71F80C5D')"
									+ "AND AST_COMMON.ISFW (2, C.ZICFLID) = 1 AND C.RWID <> '3DCA958F0000002178673E76D0CE4984'");
		}
		// 六大类统计
		else if ("ldltj".equals(fromModel)) {
			cardsTotalCondition.put("condsql", "AND DL.RWID = '" + zicdlrwidStr + "'");
		}
		// 使用情况统计
		else if ("syqktj".equals(fromModel)) {
			cardsTotalCondition.put("condsql", "AND SBD.RWID = '" + shiyzkidStr
					+ "' AND DL.RWID <> '3DCA958F0000002178673E76D0CE4984'");
		}

		try {
			if ("wxqk_main".equals(fromModel)) {
				bsAstCardService.findTotalOfRepairedCards(cardsTotalCondition);
			} else {
				bsAstCardService.getCardsTotal(cardsTotalCondition);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> cardsTotalCursor = (List<Object>) cardsTotalCondition.get("P_DS");
		/* 卡片总体情况查询 —— END */

		/* 卡片信息查询 —— BEGIN */
		// 分页模型封装
		int totalCount = 0;
		if (cardsTotalCursor != null && cardsTotalCursor.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) cardsTotalCursor.get(0);
			totalCount = Integer.parseInt(map.get("CNT").toString());
		}
		Page<Object> page = new Page<Object>(Page.PAGE_SIZE, pageNo, totalCount);
		int fromIndex = (page.getPageNo() - 1) * Page.PAGE_SIZE + 1;
		int endIndex = fromIndex + Page.PAGE_SIZE - 1;

		// 查询条件组装
		Map<String, Object> cardsCondition = new HashMap<String, Object>(cardsTotalCondition);
		cardsCondition.put("snum", fromIndex);
		cardsCondition.put("enum", endIndex);
		cardsCondition.put("sortpart", sortpartStr);

		try {
			if ("wxqk_main".equals(fromModel)) {
				bsAstCardService.findRepairedCards(cardsCondition);
			} else {
				bsAstCardService.findCards(cardsCondition);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> cardsCursor = (List<Object>) cardsCondition.get("P_DS");
		page.setResults(cardsCursor);
		request.setAttribute(Page.PAGE_NAME, page);
		/* 卡片信息查询 —— END */
		request.setAttribute(PREFIX_PATH, prefixPath);
		request.setAttribute("fromModel", fromModel);
		request.setAttribute("dateStr", dateStr);
		request.setAttribute("zicflidStr", zicflidStr);
		request.setAttribute("yongtidStr", yongtidStr);
		request.setAttribute("shiyzkidStr", shiyzkidStr);
		request.setAttribute("keyvalueStr", keyvalueStr);
		request.setAttribute("sortpartStr", sortpartStr);
		request.setAttribute("timeStr", timeStr);
		request.setAttribute("mothStr", mothStr);
		request.setAttribute("weixfsidStr", weixfsidStr);
		request.setAttribute("zicdlrwidStr", zicdlrwidStr);
		request.setAttribute("beginDateStr", beginDateStr);
		request.setAttribute("endDateStr", endDateStr);
		request.setAttribute("qudfsidStr", qudfsidStr);

		// 切换单位时仍保持当前的视图模式
		if (viewMode == null) {
			Object tmpViewMode = request.getSession().getAttribute(VIEW_MODE);
			viewMode = (tmpViewMode != null) ? tmpViewMode.toString() : CARD_MODE;
		}
		request.getSession().setAttribute(VIEW_MODE, viewMode);

		if (LIST_MODE.equals(viewMode)) {
			return "sup/query/card/list_mode";
		} else {
			return "sup/query/card/card_mode";
		}
	}

	@RequestMapping(value = "/card/{rwid}/{editable}", method = RequestMethod.GET)
	public String card(@PathVariable("rwid") String rwid,
			@PathVariable("editable") String editable, HttpServletRequest request) {
		/* 卡片详情查询 --BEGIN */
		// 查询卡片详情条件组装
		Map<String, Object> mapDetailCondition = new HashMap<String, Object>(baseCondition);
		mapDetailCondition.put("type", 1);
		mapDetailCondition.put("idorcode", rwid);
		try {
			bsAstCardService.findCardDetail(mapDetailCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		List<Object> cardCursor = (List<Object>) mapDetailCondition.get("P_DS");
		if (cardCursor != null && cardCursor.size() > 0) {
			Map<String, Object> cardDetailInfo = (Map<String, Object>) cardCursor.get(0);
			request.setAttribute(PREFIX_PATH, prefixPath);
			request.setAttribute("cardDetailInfo", cardDetailInfo);
			String edition = currentUser.getCurrentEdition();
			if ("sup".equals(edition)) {
				request.setAttribute("baseInfoByModelId_URL", "/sup/query/card/card_"
						+ cardDetailInfo.get("MODELID").toString() + ".ftl");
			} else if ("org".equals(edition)) {
				request.setAttribute("baseInfoByModelId_URL", "/org/card/card_"
						+ cardDetailInfo.get("MODELID").toString() + ".ftl");
			}
			/* 卡片详情查询 --END */

			/* 页签列表 --BEGIN */
			List<Map<String, String>> listSubtab = new ArrayList<Map<String, String>>();

			// mapSubtab.put("jibxxName", "基本信息");
			// mapSubtab.put("jibxxURL", "/card/base");
			String objectid = (String) cardDetailInfo.get("OBJECTID");
			String danwxzlxcode = currentUser.getDanwxzlxcode();
			if (!"01".equals(danwxzlxcode)) {
				Map<String, String> mapSubtab = new HashMap<String, String>();
				mapSubtab.put("name", "折旧信息");
				mapSubtab.put("tabidOrClass", "info_zhejiu");
				listSubtab.add(mapSubtab);

				/* 折旧信息查询 --BEGIN */
				Map<String, Object> depreciationCondition = new HashMap<String, Object>(
						baseCondition);
				depreciationCondition.put("cardobjid", objectid);
				try {
					bsAstCardService.findCardZhejxx(depreciationCondition);
				} catch (SQLException e) {
					e.printStackTrace();
				}

				// 获取查询结果
				List<Object> depreciationCursor = (List<Object>) depreciationCondition.get("P_DS");

				request.setAttribute("depreciationCursor", depreciationCursor);

				/* 折旧信息查询 --END */
			}

			Map<String, String> mapSubtab1 = new HashMap<String, String>();
			mapSubtab1.put("name", "维修记录");
			mapSubtab1.put("tabidOrClass", "info_weixiu");
			listSubtab.add(mapSubtab1);

			// listSubtab.add("附件");
			// mapSubtab.put("fujName", "附件");
			// mapSubtab.put("fujxxURL", "/card/addition");

			String showMainCardInfo = cardDetailInfo.get("SHIFXSZKXX").toString();
			String isBook = cardDetailInfo.get("IS_TUS").toString();
			String shuL = cardDetailInfo.get("SHUL").toString();
			double quantity = Double.valueOf(shuL);
			if ("1".equals(showMainCardInfo) && "1".equals(isBook) && quantity >= 1) {
				Map<String, String> mapSubtab2 = new HashMap<String, String>();
				mapSubtab2.put("name", "子卡信息");
				mapSubtab2.put("tabidOrClass", "info_zika");
				listSubtab.add(mapSubtab2);

				/* 子卡信息查询 --BEGIN */
				/* 子卡信息查询 --END */
			}

			Map<String, String> mapSubtab3 = new HashMap<String, String>();
			mapSubtab3.put("name", "业务日志");
			mapSubtab3.put("tabidOrClass", "info_rizhi");
			listSubtab.add(mapSubtab3);

			String modelId = cardDetailInfo.get("MODELID").toString();
			String zicflcode = cardDetailInfo.get("ZICFLCODE").toString();
			/* 房屋模型id固定 */
			if ("134909E9FFBE79529494CC1AA1750BCD".equals(modelId)
					&& !"10290".equals(zicflcode.substring(0, 5))) {
				Map<String, String> mapSubtab4 = new HashMap<String, String>();
				mapSubtab4.put("name", "楼层信息");
				mapSubtab4.put("tabidOrClass", "info_louceng");
				listSubtab.add(mapSubtab4);

				/* 楼层信息查询 --BEGIN */

				Map<String, Map<String, Object>> floorInfoCondition = new HashMap<String, Map<String, Object>>();
				Map<String, Object> floorCondition = new HashMap<String, Object>(baseCondition);
				floorCondition.put("cardobjid", objectid);
				Map<String, Object> roomCondition = new HashMap<String, Object>(floorCondition);
				floorInfoCondition.put("floorCondition", floorCondition);
				floorInfoCondition.put("roomCondition", roomCondition);

				// 查询
				try {
					bsAstCardService.findFloorInfo(floorInfoCondition);
				} catch (SQLException e) {
					e.printStackTrace();
				}

				// 获取结果集
				List<Object> floorCursor = (List<Object>) floorInfoCondition.get("floorCondition")
						.get("P_DS");
				List<Object> roomCursor = (List<Object>) floorInfoCondition.get("roomCondition")
						.get("P_DS");

				List<Map<String, Object>> floorCursorList = new ArrayList<Map<String, Object>>();
				Map<String, Object> tempFloor = null;
				for (Object floor : floorCursor) {
					tempFloor = (Map<String, Object>) floor;
					Map<String, Object> mapFloor = new HashMap<String, Object>();
					mapFloor.put("id", tempFloor.get("RWID"));
					mapFloor.put("text", tempFloor.get("MINGC").toString().trim());
					floorCursorList.add(mapFloor);
				}

				double xianzmj = 0;
				for (Object room : roomCursor) {
					tempFloor = (Map<String, Object>) room;
					// YONGT字段：1 自用；2 公用；3 闲置；4 出租；5 出借
					switch (Integer.valueOf(tempFloor.get("YONGT").toString())) {
					case 1:
						tempFloor.put("YONGTMC", "自用");
						break;
					case 2:
						tempFloor.put("YONGTMC", "公用");
						break;
					case 3:
						tempFloor.put("YONGTMC", "闲置");
						xianzmj += Double.valueOf(tempFloor.get("MIANJ").toString());
						break;
					case 4:
						tempFloor.put("YONGTMC", "出租");
						break;
					case 5:
						tempFloor.put("YONGTMC", "出借");
						break;
					}
				}
				FloorVo floorVo = new FloorVo(cardDetailInfo.get("OBJECTID").toString(),
						cardDetailInfo.get("ZICMC").toString(), floorCursorList);
				request.setAttribute("floorVo", JSON.toJSONString(floorVo));
				request.setAttribute("roomCursor", roomCursor);
				request.setAttribute("xianzmj", xianzmj);
				/* 楼层信息查询 --END */
			}

			BigDecimal fussbnum = (BigDecimal) cardDetailInfo.get("FUSSBNUM");
			if (fussbnum.intValue() > 0) {
				Map<String, String> mapSubtab5 = new HashMap<String, String>();
				mapSubtab5.put("name", "附属卡片");
				mapSubtab5.put("tabidOrClass", "info_fushu");
				listSubtab.add(mapSubtab5);

				/* 附属卡片查询 --BEGIN */
				Map<String, Object> additionCardsCondition = new HashMap<String, Object>(
						baseCondition);
				additionCardsCondition.put("snum", 1);
				additionCardsCondition.put("enum", 20000);
				additionCardsCondition.put("condsql", "AND ZF.ZCOBJID = '" + objectid + "'");

				// 查询
				try {
					bsAstCardService.findAdditionEquipments(additionCardsCondition);
				} catch (SQLException e) {
					e.printStackTrace();
				}

				// 获取结果集
				List<Object> additionCardsCursor = (List<Object>) additionCardsCondition
						.get("P_DS");

				request.setAttribute("additionCardsCursor", additionCardsCursor);

				/* 附属卡片查询 --END */
			}
			request.setAttribute("listSubtab", listSubtab);

			/* 页签列表 --END */

			/* 维修记录查询 --BEGIN */
			String cardObjectId = (String) cardDetailInfo.get("OBJECTID");
			// 查询条件组装
			Map<String, Object> mapWeixCondition = new HashMap<String, Object>(baseCondition);
			mapWeixCondition.put("snum", "1");
			mapWeixCondition.put("enum", "1000");
			mapWeixCondition.put("weixzt", "5");
			mapWeixCondition.put("condsql", "AND A.CARDOBJECTID = '" + cardObjectId + "'");
			try {
				bsAstCardService.findCardWeixxx(mapWeixCondition);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// 获取维修结果集
			List<Object> weixCursor = (List<Object>) mapWeixCondition.get("P_DS");

			if (weixCursor != null && weixCursor.size() > 0) {
				Map<String, Object> tempMap = new HashMap<String, Object>();
				for (Object obj : weixCursor) {
					tempMap = (Map<String, Object>) obj;
					if ("1".equals(tempMap.get("SHIFZBH"))) {
						tempMap.put("dengzfs", "资本化");
					} else {
						tempMap.put("dengzfs", "费用化");
					}
				}
				request.setAttribute("weixCursor", weixCursor);
			}

			/* 维修记录查询 --END */

			/* 业务日志查询 --BEGIN */
			// 查询条件组装
			Map<String, Object> mapLogCondition = new HashMap<String, Object>();
			mapLogCondition.put("cardobjid", cardObjectId);

			try {
				bsAstCardService.findCardLogs(mapLogCondition);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// 获取日志查询结果
			List<Object> logCursor = (List<Object>) mapLogCondition.get("P_DS");
			if (logCursor != null && logCursor.size() > 0) {
				for (Object log : logCursor) {
					Map<String, Object> tempMap = (Map<String, Object>) log;
					tempMap.put("yewsj", formatDate(tempMap.get("YEWSJ"), "yyyy-MM-dd HH:mm:ss"));
				}
				request.setAttribute("logCursor", logCursor);
			}
			/* 业务日志查询 --END */
		}

		// 可编辑：editable = 0
		if ("0".equals(editable)) {
			// 用途
			request.setAttribute("ytList", GlobalComponent.ytList);
			// 取得方式
			request.setAttribute("qdfsList", GlobalComponent.qdfsList);
			// 采购形式
			request.setAttribute("cgxsList", GlobalComponent.cgxsList);
			return "org/card/card_detailinfo_dy";
		}
		return "sup/query/card/card_detailinfo";
	}

	@RequestMapping(value = "/exportExcel", method = RequestMethod.POST)
	public void exportExcel(@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam("dateStr") String dateStr, @RequestParam("zicflidStr") String zicflidStr,
			@RequestParam("yongtidStr") String yongtidStr,
			@RequestParam("shiyzkidStr") String shiyzkidStr,
			@RequestParam(value = "keyvalueStr", defaultValue = "") String keyvalueStr,
			@RequestParam(value = "sortpartStr", defaultValue = "") String sortpartStr,
			@RequestParam(value = "timeStr", defaultValue = "") String timeStr,
			@RequestParam(value = "mothStr", defaultValue = "") String mothStr,
			@RequestParam(value = "weixfsidStr", defaultValue = "") String weixfsidStr,
			@RequestParam(value = "zicdlrwidStr", defaultValue = "") String zicdlrwidStr,
			@RequestParam(value = "beginDateStr", defaultValue = "") String beginDateStr,
			@RequestParam(value = "endDateStr", defaultValue = "") String endDateStr,
			@RequestParam(value = "qudfsidStr", defaultValue = "") String qudfsidStr,
			@RequestParam(value = "checkedIdStr", required = false) String checkedIdStr,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 处理多 ID 拼接的传输格式
		String yongtid = processIdStr(yongtidStr);
		String zicflid = processIdStr(zicflidStr);

		// 接收分布情况模块的特别参数
		String fbqkType = request.getParameter("fbqkType");
		String fbqkOrgid = request.getParameter("fbqkOrgid");
		String fbqkDeptid = request.getParameter("fbqkDeptid");

		int fromIndex = (pageNo - 1) * Page.PAGE_SIZE + 1;
		int endIndex = fromIndex + Page.PAGE_SIZE - 1;
		// 行数据查询 - 条件组装
		Map<String, Object> rowsCondition = new HashMap<String, Object>(baseCondition);
		rowsCondition.put("querytype", "0");
		rowsCondition.put("keyvalue", keyvalueStr);
		rowsCondition.put("snum", fromIndex);
		rowsCondition.put("enum", endIndex);
		rowsCondition.put("sortpart", sortpartStr);

		// 维修情况
		if ("wxqk_main".equals(fromModel)) {
			rowsCondition.put("time", timeStr);
			rowsCondition.put("moth", mothStr);
			rowsCondition.put("condsql", "AND WX.WEIXFSID = '" + weixfsidStr + "'");
		}
		// 常用资产 - 使用状况
		else if ("cyzc_syzk".equals(fromModel)) {
			rowsCondition.put("condsql", "AND C.YONGTID IN (" + yongtid + ") AND C.ZICFLID IN ("
					+ zicflid + ") AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '" + dateStr
					+ "' AND C.SHIYZKID = '" + shiyzkidStr + "'");
		}
		// 构成情况
		else if ("gcqk_main".equals(fromModel)) {
			rowsCondition.put("condsql", "AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '" + dateStr
					+ "' AND DL.RWID = '" + zicdlrwidStr + "'");
		}
		// 增加情况
		else if ("zjqk_main".equals(fromModel)) {
			rowsCondition.put("condsql", "AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '" + endDateStr
					+ "' AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') >= '" + beginDateStr
					+ "' AND C.QUDFSID = '" + qudfsidStr + "'");
		}
		// 使用情况
		else if ("syzk_main".equals(fromModel)) {
			rowsCondition.put("condsql",
					"AND DL.RWID <> '3DCA958F0000002178673E76D0CE4984' AND C.SHIYZKID = '"
							+ shiyzkidStr + "'");
		}
		// 用途分类
		else if ("ytfl_main".equals(fromModel)) {
			rowsCondition.put("condsql", "AND C.YONGTID = '" + yongtidStr + "'");
		}
		// 待报废资产
		else if ("dbfqk_main".equals(fromModel)) {
			rowsCondition.put("condsql", "AND DL.RWID = '" + zicdlrwidStr + "' ");
		}
		// 入账情况
		else if ("rzqk_main".equals(fromModel)) {
			rowsCondition.put("condsql", "AND DL.RWID = '" + zicdlrwidStr + "'");
		}
		// 分布情况
		else if ("fbqk_main".equals(fromModel)) {
			rowsCondition.put("orgid", fbqkOrgid);
			// 使用状况
			if ("1".equals(fbqkType)) {
				// 部门资产
				if (StringUtils.isNotBlank(fbqkDeptid)) {
					rowsCondition.put("condsql", "AND (C.SHIYZKID = '" + shiyzkidStr
							+ "') AND ((C.SHIYBMID = '" + fbqkDeptid
							+ "') OR (C.SHIYBMID IS NULL AND C.GUANLBMID = '" + fbqkDeptid + "'))");
				}
				// 单位资产
				else {
					rowsCondition.put("condsql", "AND (C.SHIYZKID = '" + shiyzkidStr
							+ "') AND (C.SHIYBMID IS NULL) AND (DG.OBJNAME IS NULL)");
				}
			}
			// 使用人
			else if ("3".equals(fbqkType)) {
				rowsCondition.put("condsql", "AND C.SHIYBMID = '" + fbqkDeptid
						+ "' AND (C.SHIYRID = '" + shiyzkidStr + "')");
			}
		}
		// 闲置房产
		else if ("xzfc".equals(fromModel)) {
			rowsCondition.put("orgid", shiyzkidStr);
			rowsCondition
					.put("condsql",
							"AND C.SHIYZKID IN ('3F5B09C1400000010A9442FDA2091273', '3F5B0C396000000170CA046A71F80C5D')"
									+ "AND AST_COMMON.ISFW (2, C.ZICFLID) = 1 AND C.RWID <> '3DCA958F0000002178673E76D0CE4984'");
		}
		// 六大类统计
		else if ("ldltj".equals(fromModel)) {
			rowsCondition.put("condsql", "AND DL.RWID = '" + zicdlrwidStr + "'");
		}
		// 使用情况统计
		else if ("syqktj".equals(fromModel)) {
			rowsCondition.put("condsql", "AND SBD.RWID = '" + shiyzkidStr
					+ "' AND DL.RWID <> '3DCA958F0000002178673E76D0CE4984'");
		}

		// 列数据查询 - 条件组装
		Map<String, Object> colsCondition = new HashMap<String, Object>(baseCondition);
		colsCondition.put("type", "1");

		// 总查询条件组装
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("rowsCondition", rowsCondition);
		map.put("colsCondition", colsCondition);

		try {
			bsAstCardService.cardExport(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 行数据查询返回的游标
		List<Object> rowsCursor = (List<Object>) map.get("rowsCondition").get("P_DS");
		// 列数据查询
		List<String> colsCursor = new ArrayList<String>();
		Field[] colFields = CardExportVo.class.getDeclaredFields();

		for (Field colField : colFields) {
			String fieldName = colField.getName();
			colsCursor.add(fieldName);
		}

		// 只要行（列）数据为空，即终止导出操作
		if (rowsCursor == null || rowsCursor.size() == 0) {
			throw new RuntimeException("行数据异常");
		}
		if (colsCursor == null || colsCursor.size() == 0) {
			throw new RuntimeException("列数据异常");
		}

		// 筛选出被选中的卡片
		List<Object> checkedCards = new ArrayList<Object>();
		String[] idArr = checkedIdStr.split(",");
		for (String idStr : idArr) {
			for (Object row : rowsCursor) {
				Map<String, String> rowMap = (Map<String, String>) row;
				if (idStr.equals(rowMap.get("RWID"))) {
					checkedCards.add(row);
					break;
				}
			}
		}

		// 抽取列数据中的关键项，并重新组装（即最终展示在 Excel 中的列数据）
		final List<String> fldNames = new ArrayList<String>();
		for (Object col : colsCursor) {
			String colStr = (String) col;
			fldNames.add(colStr);
		}

		// 值对象集合（即最终展示在 Excel 中的行数据）
		final List<CardExportVo> cardVos = new ArrayList<CardExportVo>();
		// 遍历行数据游标
		for (Object row : checkedCards) {
			// 每行数据都使用一个 Vo 进行包装
			CardExportVo cardVo = new CardExportVo();
			// 遍历最终的列数据
			for (String fldName : fldNames) {
				Map<String, Object> rowMap = (Map<String, Object>) row;
				// 获取行数据中与本列对应的值
				Object fldValue = rowMap.get(fldName.toUpperCase());
				// 利用反射组装 Vo
				try {
					// 获取 Vo 中与本列对应的属性（属性名均采用了全小写的命名方式）
					Field field = cardVo.getClass().getDeclaredField(fldName.toLowerCase());
					// 突破访问权限
					field.setAccessible(true);
					// 为该属性赋值
					if (fldValue != null) {
						if (fldValue instanceof BigDecimal) {
							fldValue = new BigDecimal(fldValue.toString());
						} else {
							if ("rq".equalsIgnoreCase(fldName.substring(fldName.length() - 2,
									fldName.length())) || "licencedate".equalsIgnoreCase(fldName)) {
								fldValue = fldValue.toString().substring(0, 10);
							} else {
								fldValue = fldValue.toString();
							}
						}
					} else {
						String className = field.getType().getSimpleName();
						if (className.equalsIgnoreCase("BigDecimal")) {
							fldValue = new BigDecimal("0");
						} else {
							fldValue = "";
						}
					}
					field.set(cardVo, fldValue);
				} catch (SecurityException e) {
					e.printStackTrace();
				} catch (NoSuchFieldException e) {
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}
			}
			// 将组装完成的 Vo 添加至值对象集合
			cardVos.add(cardVo);
		}

		// 读取 Excel 模版的输入流
		InputStream is = getClass().getClassLoader().getResourceAsStream(
				"excelTemplate/FrameAll.xls");
		// 获取响应下载的输出流
		OutputStream os = getExcelOS("资产卡片", request, response);

		// Jxls 容器
		Context context = new Context();
		// 传递值对象集合
		context.putVar("cards", cardVos);
		// 传递单位名称
		String orgName = getDefaultValueFromCursor("DANWMC", rowsCursor);
		context.putVar("orgName", orgName);
		// 传递当前日期
		context.putVar("currentDate", formatDate(new Date(), "yyyy-MM-dd"));

		// 根据模版生成 Excel 文件
		JxlsHelper.getInstance().processTemplate(is, os, context);
	}

}