package com.zheling.org.card.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zheling.base.controller.BaseController;
import com.zheling.sup.query.service.BsAstCardService;

@Controller
@RequestMapping("/Card")
public class CardController extends BaseController {

	@Autowired
	private BsAstCardService bsAstCardService;

	/**
	 * 卡片信息修改 by WGJ
	 * 
	 * @param cardId
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/modify", method = RequestMethod.PUT)
	public String modify(@RequestParam("cardId") String cardId, @RequestParam("sql") String sql)
			throws Exception {
		Map<String, Object> modifyCondition = new HashMap<String, Object>(baseCondition);
		modifyCondition.put("cardrwid", cardId);
		modifyCondition.put("pairs", sql);
		modifyCondition.put("modifytime", formatDate(new Date(), "yyyy-MM-dd HH:mm:ss.SSS"));
		return bsAstCardService.modify(modifyCondition);
	}

	/**
	 * 附件上传 by WGJ
	 * 
	 * @param fileindex
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String upload(@RequestParam("cardid") String cardid,
			@RequestParam("fileindex") String fileindex, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String newFileTitle = getUUID();
		List<String> oldFilesNames = commonsUpload(newFileTitle, request, response);

		// 获取附件名及后缀
		String title = "";
		String extension = "";
		for (int i = 0; i < oldFilesNames.size(); i++) {
			String fileName = oldFilesNames.get(i);
			int dotIndex = fileName.lastIndexOf(".");
			title += fileName.substring(0, dotIndex) + ",";
			extension += fileName.substring(dotIndex + 1, fileName.length()) + ",";
		}
		title = title.substring(0, title.length() - 1);
		extension = extension.substring(0, extension.length() - 1);

		Map<String, Object> uploadCondition = new HashMap<String, Object>(baseCondition);
		uploadCondition.put("fujtpid", newFileTitle);
		uploadCondition.put("bsid", cardid);
		uploadCondition.put("title", title);
		uploadCondition.put("extension", extension);
		uploadCondition.put("fileindex", fileindex);
		uploadCondition.put("datatype", "CARD");
		bsAstCardService.modifyCardPic(uploadCondition);

		// 新文件名
		String newFileName = newFileTitle + "." + extension;
		return prefixPath + "/FileFolder/" + newFileName;
	}

}