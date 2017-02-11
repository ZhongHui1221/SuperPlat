package com.zheling.sup.query.controller;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;
import com.zheling.base.controller.BaseController;
import com.zheling.sup.query.service.FwxxService;
import com.zheling.sup.query.vo.FwxxVo;

@Controller
@RequestMapping("/Query/Fwxx")
public class FwxxController extends BaseController {

	@Autowired
	private FwxxService fwxxService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(HttpServletRequest request) {
		// 查询条件组装
		Map<String, Object> fwxxCondition = new HashMap<String, Object>(
				baseCondition);

		try {
			fwxxService.findFwxx(fwxxCondition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 查询返回的游标
		List<Object> fwxxCursor = (List<Object>) fwxxCondition.get("P_DS");

		final List<FwxxVo> fwxxVos = new ArrayList<FwxxVo>();
		for (Object fwxx : fwxxCursor) {
			Map<String, Object> fwxxMap = (Map<String, Object>) fwxx;

			String rwid = fwxxMap.get("RWID").toString(); // ID
			String objcode = fwxxMap.get("OBJCODE").toString(); // 编号
			String zicmc = fwxxMap.get("ZICMC") != null ? fwxxMap.get("ZICMC")
					.toString() : ""; // 资产名称
			String danwjc = fwxxMap.get("DANWJC") != null ? fwxxMap.get(
					"DANWJC").toString() : ""; // 单位简称
			String fwztmc = fwxxMap.get("FWZTMC") != null ? fwxxMap.get(
					"FWZTMC").toString() : ""; // 状态名称
			BigDecimal mianj = new BigDecimal(fwxxMap.get("MIANJ").toString()); // 面积

			List<Double> position = new ArrayList<Double>();
			Double weid = Double.valueOf(fwxxMap.get("WEID").toString()); // 纬度
			Double jingd = Double.valueOf(fwxxMap.get("JINGD").toString()); // 经度
			// 纬度必须在前
			position.add(weid);
			position.add(jingd);

			FwxxVo fwxxVo = new FwxxVo(rwid, objcode, zicmc, danwjc, fwztmc,
					mianj, position);
			fwxxVos.add(fwxxVo);
		}
		request.setAttribute("fwxxData", JSON.toJSONString(fwxxVos));
		return "sup/query/fwxx/main";
	}

}