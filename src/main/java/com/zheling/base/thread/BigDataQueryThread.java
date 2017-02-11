package com.zheling.base.thread;

import com.zheling.base.component.GlobalComponent;

/**
 * 大数据查询线程类
 * 
 * @author WGJ
 */
public class BigDataQueryThread extends BaseDataQueryThread {

	@Override
	public void run() {
		// 资产分类
		GlobalComponent.zcflList = commonMapper.findZcfl();
	}

}