package com.zheling.base.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

/**
 * 提示信息工具类
 * 
 * @author WGJ
 */
public class PromptUtil {

	public static void setPromptToRequest(HttpServletRequest request,
			String prompt) {
		request.setAttribute("prompt", prompt);
	}

	public static void setErrorToRequest(HttpServletRequest request,
			String error) {
		request.setAttribute("error", error);
	}

	public static void setPromptToSession(HttpServletRequest request,
			String prompt) {
		request.getSession().setAttribute("prompt", prompt);
	}

	public static void setErrorToSession(HttpServletRequest request,
			String error) {
		request.getSession().setAttribute("error", error);
	}

	public static void removePromptFromSession(HttpServletRequest request) {
		String prompt = (String) request.getSession().getAttribute("prompt");
		String error = (String) request.getSession().getAttribute("error");
		if (StringUtils.isNotBlank(prompt)) {
			request.setAttribute("prompt", prompt);
		}
		if (StringUtils.isNotBlank(error)) {
			request.setAttribute("error", error);
		}
		request.getSession().removeAttribute("prompt");
		request.getSession().removeAttribute("error");
	}

	/**
	 * 获取存储过程抛出的异常信息 by WGJ
	 * 
	 * @param message
	 * @return
	 */
	public static String getExceptionMessage(String message) {
		String regex = "[^\\x00-\\xff]";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(message);
		if (matcher.find()) {
			return message.substring(matcher.start());
		} else {
			return "登录失败！";
		}
	}

}