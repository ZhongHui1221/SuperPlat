package com.zheling.base.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.zheling.base.entity.BdAstCaigzzxs;
import com.zheling.base.entity.BdAstChuzfs;
import com.zheling.base.entity.BdAstQudfs;
import com.zheling.base.entity.BdAstShiyzk;
import com.zheling.base.entity.BdAstYongt;
import com.zheling.base.entity.BdAstZhij;
import com.zheling.base.entity.BdAstZicfl;
import com.zheling.base.entity.CoreRole;

@Repository
public interface AstCommonMapper {

	/**
	 * 资产分类查询 by WGJ
	 * 
	 * @return
	 */
	List<BdAstZicfl> findZcfl();

	/**
	 * 角色查询 by WGJ
	 * 
	 * @return
	 */
	List<CoreRole> findRoles();

	/**
	 * 职级查询 by WGJ
	 * 
	 * @return
	 */
	List<BdAstZhij> findZhij();

	/**
	 * 处置方式查询 by WGJ
	 * 
	 * @return
	 */
	List<BdAstChuzfs> findChuzfs();

	/**
	 * 使用状况查询 by WGJ
	 * 
	 * @return
	 */
	List<BdAstShiyzk> findShiyzk();

	/**
	 * 取得方式查询 by WGJ
	 * 
	 * @return
	 */
	List<BdAstQudfs> findQudfs();

	/**
	 * 用途查询 by WGJ
	 * 
	 * @return
	 */
	List<BdAstYongt> findYongt();

	/**
	 * 采购形式查询 by WGJ
	 * 
	 * @return
	 */
	List<BdAstCaigzzxs> findCgxs();

	/**
	 * 权限查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCommonAuthq(Map<String, Object> map) throws SQLException;

	/**
	 * 自定义列查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCommonZidylq(Map<String, Object> map) throws SQLException;

	/**
	 * 附件查询 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCommonFujtpq(Map<String, Object> map) throws SQLException;

	/**
	 * 添加 / 修改附件 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCommonFujtpin(Map<String, Object> map) throws SQLException;

	/**
	 * 删除附件 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCommonFujtpout(Map<String, Object> map) throws SQLException;

	/**
	 * 根据预算代码查询单位 by WGJ
	 * 
	 * @param map
	 * @throws SQLException
	 */
	void callAstCommonGetorg(Map<String, Object> map) throws SQLException;

}