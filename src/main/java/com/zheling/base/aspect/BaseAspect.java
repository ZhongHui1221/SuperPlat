package com.zheling.base.aspect;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import com.zheling.base.controller.BaseController;
import com.zheling.base.exception.NoLoginException;
import com.zheling.base.util.PromptUtil;
import com.zheling.base.util.RequestBinder;
import com.zheling.base.vo.UserVo;

/**
 * 基础切面类
 * 
 * @author WGJ
 */
@Aspect
@Component
@Order(0)
public class BaseAspect {

	private long beginTime;
	private long endTime;

	// 预算代码，即单位的 OBJCODE
	private String code;

	/**
	 * 横切关注点 - 处理全局的请求绑定 by WGJ
	 * 
	 * 主要用于实时更新 BaseController 的各项属性
	 * 
	 * @param joinPoint
	 */
	@Before("execution(* com.zheling..*.controller.*Controller.*(..))")
	public void requestBind(JoinPoint joinPoint) {
		beginTime = System.currentTimeMillis();

		HttpServletRequest request = RequestBinder.getRequest();
		UserVo userVo = (UserVo) request.getSession().getAttribute(BaseController.CURRENT_USER);
		// 如果用户已登录
		if (userVo != null) {
			Object target = joinPoint.getTarget();
			try {
				// 获取当前使用的协议
				String scheme = request.getScheme();
				// 获取服务器的名称
				String serverName = request.getServerName();
				// 获取服务器的端口号
				String serverPort = String.valueOf(request.getServerPort());
				// 拼接前缀路径
				String prefixPathStr = scheme + "://" + serverName + ":" + serverPort;
				Field prefixPath = target.getClass().getSuperclass().getDeclaredField("prefixPath");
				prefixPath.setAccessible(true);
				prefixPath.set(target, prefixPathStr);

				Field baseCondition = target.getClass().getSuperclass()
						.getDeclaredField("baseCondition");
				Map<String, Object> condition = new HashMap<String, Object>();
				condition.put("userid", userVo.getId());
				condition.put("orgid", userVo.getCurrentOrgId());
				condition.put("roleid", userVo.getCurrentRoleId());
				baseCondition.setAccessible(true);
				baseCondition.set(target, condition);

				Field currentUser = target.getClass().getSuperclass()
						.getDeclaredField("currentUser");
				currentUser.setAccessible(true);
				currentUser.set(target, userVo);

				Field code = target.getClass().getSuperclass().getDeclaredField("code");
				code.setAccessible(true);
				code.set(target, this.code);

				String extraStr = request.getParameter("extra");
				Field extra = target.getClass().getSuperclass().getDeclaredField("extra");
				extra.setAccessible(true);
				extra.set(target, extraStr);
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (NoSuchFieldException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		} else {
			// 获取浏览器所请求的资源路径
			String servletPath = request.getServletPath();

			// 登录页（集中式部署场景）的路径规则
			Pattern pattern1 = Pattern.compile("^/((?!/).)*$");
			Matcher matcher1 = pattern1.matcher(servletPath);

			// 注册页（集中式部署场景）的路径规则
			Pattern pattern2 = Pattern.compile("^/.*/register$");
			Matcher matcher2 = pattern2.matcher(servletPath);

			// 上传功能的路径规则（处理 Firefox 环境下，使用 Uploadify 上传失败的问题）
			Pattern pattern3 = Pattern.compile("^/.*/upload$");
			Matcher matcher3 = pattern3.matcher(servletPath);

			// 指定无需登录即可访问的公共资源路径
			Set<String> publicResources = new HashSet<String>();
			publicResources.add("/CoreUser/toLogin"); // 登录页（分散式部署场景）
			publicResources.add("/CoreUser/login"); // 登录
			publicResources.add("/CoreUser/logout"); // 登出
			publicResources.add("/CoreUser/register"); // 注册
			publicResources.add("/CoreUser/registered"); // 注册成功页

			// 如果浏览器请求的不是公共资源，且不符合集中式部署场景的路径规则，则进行拦截
			if (!matcher1.find() && !matcher2.find() && !matcher3.find()
					&& !publicResources.contains(servletPath)) {
				request.setAttribute("code", this.code);
				RequestBinder.setRequest(request);
				// 抛出 NoLoginException，并由 ExceptionAdvice 控制跳转至相关的页面
				throw new NoLoginException();
			}
		}
	}

	/**
	 * 横切关注点 - 统计所有 Controller 中的方法运行耗时 by WGJ
	 * 
	 * @param joinPoint
	 */
	@After("execution(* com.zheling..*.controller.*Controller.*(..))")
	public void timeWatch(JoinPoint joinPoint) {
		endTime = System.currentTimeMillis();
		System.out.println(joinPoint.getTarget().getClass().getSimpleName() + "."
				+ joinPoint.getSignature().getName() + "() 运行耗时：" + (endTime - beginTime) + " ms");
	}

	/**
	 * 横切关注点 - 首次访问时的一些后置处理 by WGJ
	 * 
	 * @param joinPoint
	 */
	@After("execution(* com.zheling..*.controller.*Controller.toLogin(..))"
			+ " || execution(* com.zheling..*.controller.*Controller.toRegister(..))")
	public void firstVisit(JoinPoint joinPoint) {
		Object target = joinPoint.getTarget();
		try {
			Field code = target.getClass().getSuperclass().getDeclaredField("code");
			code.setAccessible(true);
			this.code = code.get(target).toString();
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

	/**
	 * 横切关注点 - 统一处理存储过程抛出的异常信息 by WGJ
	 * 
	 * 针对所有 ServiceImpl 中调用到存储过程的增 / 删 / 改方法（特征：public String xxx(Map xx)）
	 * 
	 * 目前排除了对所有构建树形结构方法的切入
	 * 
	 * @param joinPoint
	 * @return
	 */
	@Around("execution(public String com.zheling..*.service.impl.*ServiceImpl.*(java.util.Map))"
			+ " && !execution(* com.zheling..*.service.impl.*ServiceImpl.*Tree(..))")
	public String getProcExcpMsg(ProceedingJoinPoint joinPoint) {
		String excpMsg = "SUCCESS";
		try {
			joinPoint.proceed();
		} catch (Throwable e) {
			e.printStackTrace();
			String[] messageArr = e.getMessage().trim().split("\n");
			excpMsg = PromptUtil.getExceptionMessage(messageArr[0]);
		}
		return excpMsg;
	}

	/**
	 * 从配置文件中读取相关信息 by WGJ
	 * 
	 * @param key
	 * @return
	 */
	private String getConfigInfo(String key) {
		InputStream inputStream = getClass().getClassLoader().getResourceAsStream("org.properties");
		Properties properties = new Properties();
		try {
			properties.load(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return properties.getProperty(key);
	}

}