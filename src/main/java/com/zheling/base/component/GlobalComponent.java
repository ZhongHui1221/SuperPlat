package com.zheling.base.component;

import java.util.List;

import org.springframework.stereotype.Component;

import com.zheling.base.entity.BdAstCaigzzxs;
import com.zheling.base.entity.BdAstChuzfs;
import com.zheling.base.entity.BdAstQudfs;
import com.zheling.base.entity.BdAstShiyzk;
import com.zheling.base.entity.BdAstYongt;
import com.zheling.base.entity.BdAstZhij;
import com.zheling.base.entity.BdAstZicfl;
import com.zheling.base.entity.CoreRole;

/**
 * 全局组件类
 * 
 * @author WGJ
 */
@Component
public class GlobalComponent {

	/**
	 * 资产分类
	 */
	public static List<BdAstZicfl> zcflList;

	/**
	 * 角色
	 */
	public static List<CoreRole> roleList;

	/**
	 * 职级
	 */
	public static List<BdAstZhij> zjList;

	/**
	 * 处置方式
	 */
	public static List<BdAstChuzfs> czfsList;

	/**
	 * 使用状况
	 */
	public static List<BdAstShiyzk> syzkList;

	/**
	 * 取得方式
	 */
	public static List<BdAstQudfs> qdfsList;

	/**
	 * 用途
	 */
	public static List<BdAstYongt> ytList;

	/**
	 * 采购形式
	 */
	public static List<BdAstCaigzzxs> cgxsList;

}