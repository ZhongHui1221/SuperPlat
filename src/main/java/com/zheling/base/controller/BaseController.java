package com.zheling.base.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.sql.TIMESTAMP;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.zheling.base.vo.UserVo;

/**
 * 基础 Controller
 * 
 * @author WGJ
 */
public class BaseController {

	// 前缀路径在 Request 中的固定名称
	public static final String PREFIX_PATH = "prefixPath";
	// 当前用户信息在 Session 中的固定名称
	public static final String CURRENT_USER = "currentUser";
	// 视图模式在 Session 中的固定名称
	public static final String VIEW_MODE = "VIEW_MODE";

	// 卡片模式的固定名称
	public static final String CARD_MODE = "CARD_MODE";
	// 图片列表模式的固定名称
	public static final String IMG_LIST_MODE = "IMG_LIST_MODE";
	// 列表模式的固定名称
	public static final String LIST_MODE = "LIST_MODE";

	/**
	 * 前缀路径（如：http://127.0.0.1:8080）
	 */
	protected String prefixPath;
	/**
	 * 基础查询条件
	 * 
	 * 已通过切面实时更新该对象的内容，现封装了 orgid、userid、roleid 三个可高度重用的参数
	 * 
	 * 具体细节见 BaseAspect
	 */
	protected Map<String, Object> baseCondition;
	/**
	 * 当前用户信息
	 * 
	 * 已通过切面实时更新该对象的内容，它在 Controller 层可直接被使用，简化了
	 * request.getSession().get(CURRENT_USER) 的冗长写法
	 * 
	 * 具体细节见 BaseAspect
	 */
	protected UserVo currentUser;
	/**
	 * 预算代码，即单位的 OBJCODE
	 * 
	 * 已通过切面实时更新该对象的内容
	 * 
	 * 具体细节见 BaseAspect
	 */
	protected String code;
	/**
	 * 额外参数
	 * 
	 * 已通过切面实时更新该对象的内容，它用于携带一些起标识作用的参数
	 * 
	 * 具体细节见 BaseAspect
	 */
	protected String extra;

	/**
	 * 从游标中获取某个键的默认值 by WGJ
	 * 
	 * @param key
	 *            键的名称
	 * @param cursor
	 *            游标对象
	 * @return
	 */
	protected String getDefaultValueFromCursor(String key, List<Object> cursor) {
		if (cursor != null && cursor.size() > 0) {
			Map<String, Object> map = (Map<String, Object>) cursor.get(0);
			Object obj = map.get(key);
			return (obj != null) ? obj.toString() : null;
		}
		return null;
	}

	/**
	 * 从角色信息游标中获取某个键的默认值 by WGJ
	 * 
	 * @param key
	 *            键的名称
	 * @param roleCursor
	 *            角色信息游标
	 * @return
	 */
	protected String getDefaultValueFromRoleCursor(String key, List<Object> roleCursor) {
		if (roleCursor != null && roleCursor.size() > 0) {
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			for (Object role : roleCursor) {
				Map<String, Object> map = (Map<String, Object>) role;
				list.add(map);
			}
			if (list != null && list.size() > 0) {
				Object obj = list.get(0).get(key);
				return (obj != null) ? obj.toString() : null;
			}
		}
		return null;
	}

	/**
	 * 从角色信息游标中获取当前角色的名称，减少对数据库的访问 by WGJ
	 * 
	 * @param key
	 *            键的名称
	 * @param roleid
	 *            角色 ID
	 * @param roleCursor
	 *            角色信息游标
	 * @return
	 */
	protected String getValueFromRoleCursor(String key, String roleid, List<Object> roleCursor) {
		if (roleCursor != null && roleCursor.size() > 0) {
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			for (Object role : roleCursor) {
				Map<String, Object> map = (Map<String, Object>) role;
				list.add(map);
			}
			if (list != null && list.size() > 0) {
				for (Map<String, Object> map : list) {
					if (roleid.equals(map.get("RWID"))) {
						Object obj = map.get(key);
						return (obj != null) ? obj.toString() : null;
					}
				}
			}
		}
		return null;
	}

	/**
	 * 从配置文件中读取相关信息 by WGJ
	 * 
	 * @param key
	 * @return
	 */
	protected String getConfigInfo(String key) {
		InputStream inputStream = getClass().getClassLoader().getResourceAsStream("org.properties");
		Properties properties = new Properties();
		try {
			properties.load(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return properties.getProperty(key);
	}

	/**
	 * 处理多 ID 拼接的传输格式 by WGJ
	 * 
	 * @param idStr
	 * @return
	 */
	protected String processIdStr(String idStr) {
		String ids = "";
		if (idStr.contains(",")) {
			String[] tmpArr = idStr.split(",");
			for (String tmpStr : tmpArr) {
				ids += "'" + tmpStr + "',";
			}
			ids = ids.substring(0, ids.length() - 1);
		} else {
			ids = "'" + idStr + "'";
		}
		return ids;
	}

	/**
	 * 格式化日期 by WGJ
	 * 
	 * @param date
	 * @param pattern
	 * @return
	 */
	protected String formatDate(Object date, String pattern) {
		String dateStr = "";
		if (date != null) {
			SimpleDateFormat sdf = new SimpleDateFormat(pattern);
			if (date instanceof TIMESTAMP) {
				TIMESTAMP tS = (TIMESTAMP) date;
				try {
					Timestamp ts = tS.timestampValue();
					dateStr = sdf.format(ts);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else if (date instanceof Timestamp) {
				Timestamp ts = (Timestamp) date;
				dateStr = sdf.format(ts);
			} else if (date instanceof Date) {
				dateStr = sdf.format(date);
			}
		}
		return dateStr;
	}

	/**
	 * 获取响应 Excel 下载的输出流 by WGJ
	 * 
	 * @param fileName
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	protected OutputStream getExcelOS(String fileName, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// 文件名称拼接
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String currentDateStr = sdf.format(new Date());
		fileName = fileName + "_" + currentDateStr + ".xls";

		// 从请求头中获取用户代理信息
		String userAgent = request.getHeader("User-Agent");
		if (userAgent.contains("Firefox")) {
			// 如果浏览器为 Firefox，则使用 BASE64 编码
			fileName = "=?UTF-8?B?"
					+ new sun.misc.BASE64Encoder().encode(fileName.getBytes("UTF-8")) + "?=";
		} else {
			// 否则使用 UTF-8 编码
			fileName = URLEncoder.encode(fileName, "UTF-8");
		}

		// 设置文件名称
		response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
		// 指定下载文件的类型
		response.setContentType("application/vnd.ms-excel");
		return response.getOutputStream();
	}

	/**
	 * 通用上传 by WGJ
	 * 
	 * @param newFileTitle
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	protected List<String> commonsUpload(String newFileTitle, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		List<String> oldFileNames = null;
		// 创建多部件解析器
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request
				.getSession().getServletContext());
		// 检测是否有文件上传
		if (multipartResolver.isMultipart(request)) {
			oldFileNames = new ArrayList<String>();
			// 将 HttpServletRequest 造型为 MultipartHttpServletRequest
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			// 获取请求中所有的文件名称
			Iterator<String> iterator = multiRequest.getFileNames();
			while (iterator.hasNext()) {
				// 获取上传的文件
				MultipartFile multiFile = multiRequest.getFile(iterator.next());
				if (multiFile != null) {
					// 获取原始文件名
					String oldFileName = multiFile.getOriginalFilename();
					oldFileNames.add(oldFileName);

					// 获取附件后缀
					int dotIndex = oldFileName.lastIndexOf(".");
					String extension = oldFileName.substring(dotIndex + 1, oldFileName.length());

					// 新文件名
					String newFileName = newFileTitle + "." + extension;

					// 执行上传
					multiFile.transferTo(new File(getConfigInfo("FileFolder") + "/" + newFileName));
				}
			}
		}
		return oldFileNames;
	}

	/**
	 * 获取通用唯一识别码（UUID） by WGJ
	 * 
	 * @return
	 */
	protected String getUUID() {
		return UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
	}

}