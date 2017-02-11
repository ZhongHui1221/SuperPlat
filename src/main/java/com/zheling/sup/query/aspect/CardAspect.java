package com.zheling.sup.query.aspect;

import java.lang.reflect.Field;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import com.zheling.base.util.RequestBinder;

/**
 * 卡片切面类
 * 
 * @author WGJ
 */
@Aspect
@Component
@Order(1)
public class CardAspect {

	/**
	 * 横切关注点 - 处理卡片模块的请求绑定 by WGJ
	 * 
	 * 主要用于实时更新 BsAstCardController 的各项属性
	 * 
	 * @param joinPoint
	 */
	@Before("execution(* com.zheling.sup.query.controller.BsAstCardController.*(..))")
	public void requestBind(JoinPoint joinPoint) {
		HttpServletRequest request = RequestBinder.getRequest();
		String fromModel = request.getParameter("fromModel");
		Object target = joinPoint.getTarget();
		try {
			Field field = target.getClass().getDeclaredField("fromModel");
			field.setAccessible(true);
			field.set(target, fromModel);
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

}