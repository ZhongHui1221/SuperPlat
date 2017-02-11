package com.zheling.base.aspect;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

/**
 * 缓存切面类
 * 
 * @author WGJ
 */
// @Aspect
@Component
@Order(9)
public class CacheAspect {

	/**
	 * 缓存容量上限
	 */
	private static final int MAX_CACHE_SIZE = 500;
	/**
	 * 缓存容器，当实际容量到达上限时即自行清空
	 */
	private Map<Integer, Object> cacheMap = new ConcurrentHashMap<Integer, Object>(
			MAX_CACHE_SIZE);
	private long beginTime;
	private long endTime;

	/**
	 * 获取缓存 by WGJ
	 * 
	 * @param hashCode
	 * @return
	 */
	public Object getCache(Integer hashCode) {
		return cacheMap.get(hashCode);
	}

	/**
	 * 记录缓存 by WGJ
	 * 
	 * @param hashCode
	 * @param object
	 */
	public void setCache(Integer hashCode, Object object) {
		if (beginTime == 0) {
			beginTime = System.currentTimeMillis();
		}
		endTime = System.currentTimeMillis();
		// 每 10 分钟清空一次缓存
		if (endTime - beginTime > 600000) {
			cacheMap.clear();
			beginTime = 0;
		}

		if (object != null) {
			if (cacheMap.size() == MAX_CACHE_SIZE) {
				cacheMap.clear();
			}
			cacheMap.put(hashCode, object);
		}
	}

	/**
	 * 获取下级 Map 的个数 by WGJ
	 * 
	 * @param map
	 * @return
	 */
	public int getSubMapsCount(Map<String, Object> map) {
		int count = 0; // 计数器，用于计算下级 Map 的个数
		Iterator iterator = map.entrySet().iterator(); // 获取迭代器
		while (iterator.hasNext()) { // 遍历顶级 Map
			Map.Entry<String, Object> entry = (Entry<String, Object>) iterator
					.next(); // 获取键值对
			Object value = entry.getValue(); // 获取值
			// 如果该值是 Map 类型
			if (value instanceof Map) {
				count++; // 计数器累加
			}
		}
		return count;
	}

	/**
	 * 横切关注点 - 开启缓存 by WGJ
	 * 
	 * 针对所有 ServiceImpl 中调用到存储过程的查询方法（特征：public void xxx(Map xx)）
	 * 
	 * 目前排除了对 login 及 register 方法的切入
	 * 
	 * @param joinPoint
	 */
	@Around("execution(public void com.zheling..*.service.impl.*ServiceImpl.*(java.util.Map))"
			+ " && !execution(public void com.zheling..*.service.impl.*ServiceImpl.login(java.util.Map))"
			+ " && !execution(public void com.zheling..*.service.impl.*ServiceImpl.register(java.util.Map))")
	public void openCache(ProceedingJoinPoint joinPoint) {
		// 连接点参数
		Object[] args = joinPoint.getArgs();
		// 因为切入点表达式的限制，连接点参数一定会是一个 Map 对象
		Map<String, Object> map = (Map<String, Object>) args[0];
		// 定位缓存的哈希码
		int hashCode = (joinPoint.getTarget().getClass().getSimpleName() + "." + joinPoint
				.getSignature().getName()).hashCode() + map.hashCode();
		// 获取下级 Map 的个数
		int count = getSubMapsCount(map);

		Object cache = getCache(hashCode); // 尝试获取缓存
		if (cache == null) { // 如果无缓存
			try {
				joinPoint.proceed(); // 正常执行查询

				// 如果仅为一级 Map
				if (count == 0) {
					setCache(hashCode, map.get("P_DS")); // 在缓存容器中记录本次查询的结果
				}
				// 如果为嵌套 Map
				else {
					Map<String, Map<String, Object>> results = new HashMap<String, Map<String, Object>>(); // 多查询结果集
					Iterator iterator = map.entrySet().iterator(); // 获取迭代器
					while (iterator.hasNext()) { // 遍历顶级 Map
						Map.Entry<String, Map<String, Object>> entry = (Entry<String, Map<String, Object>>) iterator
								.next(); // 获取键值对
						String key = entry.getKey(); // 获取键
						Map<String, Object> value = entry.getValue(); // 获取值
						results.put(key, value); // 更新结果集
					}
					setCache(hashCode, results); // 在缓存容器中记录该结果集
				}
			} catch (Throwable e) {
				e.printStackTrace();
			}
		}
		// 如果有缓存
		else {
			// 如果仅为一级 Map
			if (count == 0) {
				map.put("P_DS", cache); // 将缓存回传给连接点 Map
			}
			// 如果为嵌套 Map
			else {
				// 由 setCache(hashCode, results) 得知，cache 一定会是一个 Map 对象，
				// 且泛型可以确定为 <String, Map<String, Object>
				Map<String, Map<String, Object>> tmpCache = (Map<String, Map<String, Object>>) cache;
				Iterator iterator = tmpCache.entrySet().iterator(); // 获取迭代器
				while (iterator.hasNext()) { // 遍历顶级 Map
					Map.Entry<String, Map<String, Object>> entry = (Entry<String, Map<String, Object>>) iterator
							.next(); // 获取键值对
					String key = entry.getKey(); // 获取键
					Map<String, Object> value = entry.getValue(); // 获取值
					map.put(key, value); // 将缓存回传给连接点 Map
				}
			}
		}
	}

}