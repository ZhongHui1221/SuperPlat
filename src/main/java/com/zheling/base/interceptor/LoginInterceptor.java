package com.zheling.base.interceptor;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.ResourceHttpRequestHandler;

import com.zheling.base.controller.BaseController;
import com.zheling.base.exception.NoLoginException;

/**
 * 验证登录状态的拦截器
 * 
 * @author WGJ
 */
public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// 如果是 <mvc:resources /> 中指定的静态资源，则直接放行
		if (handler instanceof ResourceHttpRequestHandler) {
			return true;
		}

		// 获取浏览器所请求的资源路径
		String servletPath = request.getServletPath();

		// 如果是集中式部署的访问方式，则直接放行
		Pattern pattern = Pattern.compile("^/(sup|org)/.*/login/*$");
		Matcher matcher = pattern.matcher(servletPath);
		if (matcher.find()) {
			return true;
		}

		// 指定无需登录即可访问的公共资源路径
		Set<String> publicResources = new HashSet<String>();
		publicResources.add("/");
		publicResources.add("/CoreUser/toLogin");
		publicResources.add("/CoreUser/login");
		publicResources.add("/CoreUser/logout");

		// 如果浏览器请求的是公共资源，则直接放行
		if (publicResources.contains(servletPath)) {
			return true;
		}

		// 获取当前用户信息
		Object currentUser = request.getSession().getAttribute(
				BaseController.CURRENT_USER);

		// 如果 currentUser 为空，则表明用户未登录
		if (currentUser == null) {
			// 回传版本信息
			request.setAttribute("version", getConfigInfo("version"));
			// 抛出 NoLoginException，并根据 spring-mvc.xml 中的异常映射配置，跳转至相关的页面
			throw new NoLoginException();
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

	/**
	 * 从配置文件中读取相关信息 by WGJ
	 * 
	 * @param key
	 * @return
	 */
	private String getConfigInfo(String key) {
		InputStream inputStream = getClass().getClassLoader()
				.getResourceAsStream("org.properties");
		Properties properties = new Properties();
		try {
			properties.load(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return properties.getProperty(key);
	}

}