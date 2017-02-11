package com.zheling.base.thread;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zheling.base.component.GlobalComponent;
import com.zheling.base.mapper.AstCommonMapper;

/**
 * 基础数据查询线程类
 * 
 * @author WGJ
 */
public class BaseDataQueryThread implements Runnable {

	/**
	 * Spring 的 IoC 容器
	 * 
	 * 因无法对线程类进行依赖注入（即不能在此处使用 @Autowired）， 所以如果需要在本类中调用 Mapper 或
	 * Service，只能采用最原始的方式获取其 Bean 对象
	 */
	private static ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
			"applicationContext.xml");
	/**
	 * 从容器中获取 AstCommonMapper
	 * 
	 * 大部分基础数据都是通过它来查询获得
	 */
	protected AstCommonMapper commonMapper = (AstCommonMapper) applicationContext
			.getBean(AstCommonMapper.class);

	/**
	 * 计数器
	 */
	private static int count;

	/**
	 * 初始化块，每创建一个 BaseDataQueryThread 实例，count 都将自增
	 */
	{
		count++;
	}

	@Override
	public void run() {
		// 服务运行期间，以下查询只允许执行一次
		if (count == 1) {
			// 新开线程执行大数据查询
			new Thread(new BigDataQueryThread()).start();

			// 角色
			GlobalComponent.roleList = commonMapper.findRoles();

			// 职级
			GlobalComponent.zjList = commonMapper.findZhij();

			// 处置方式
			GlobalComponent.czfsList = commonMapper.findChuzfs();

			// 使用状况
			GlobalComponent.syzkList = commonMapper.findShiyzk();

			// 取得方式
			GlobalComponent.qdfsList = commonMapper.findQudfs();

			// 用途
			GlobalComponent.ytList = commonMapper.findYongt();

			// 采购形式
			GlobalComponent.cgxsList = commonMapper.findCgxs();
		}
	}

}