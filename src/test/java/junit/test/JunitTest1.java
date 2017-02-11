package junit.test;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zheling.sup.query.mapper.BsAstCardMapper;
import com.zheling.sup.query.mapper.SyztMapper;
import com.zheling.sup.query.mapper.ZjqkMapper;
import com.zheling.sup.query.service.DbfzcService;
import com.zheling.sup.query.service.JsqkService;
import com.zheling.sup.query.service.RzqkService;
import com.zheling.sup.query.service.ShiyztService;
import com.zheling.sup.query.service.WxqkService;
import com.zheling.sup.query.service.YtflService;

/**
 * @author hugo
 *
 */
public class JunitTest1 {

	ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
			"applicationContext.xml");
	// SqlSessionFactory sqlSessionFactory = (SqlSessionFactory)
	// applicationContext
	// .getBean("sqlSessionFactory");
	SqlSessionFactory sqlSessionFactory = applicationContext
			.getBean(SqlSessionFactory.class);

	/**
	 * 测试callQUDFSQ方法 by hugo
	 */
	@Test
	public void zengJQKQuery1() {

		// 准备参数
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("stime", "2016-11-01");
		map.put("etime", "2016-11-30");
		map.put("keyvalue", "");
		map.put("condsql", "");
		map.put("sortpart", "");

		// 利用容器获得mapper
		ZjqkMapper zjqkMapper = applicationContext.getBean(ZjqkMapper.class);
		try {
			zjqkMapper.callAstQueryQuDFSQ(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 测试callQuDFSMXQ by hugo
	 */
	@Test
	public void zengJQKQuery2() {

		// 准备参数
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("stime", "2016-11-01");
		map.put("etime", "2016-11-30");
		map.put("keyvalue", "");
		map.put("condsql", "");
		map.put("sortpart", "");

		// 利用sqlsessionfactory获取mapper
		ZjqkMapper zjqkMapper = sqlSessionFactory.openSession().getMapper(
				ZjqkMapper.class);
		try {
			zjqkMapper.callAstQueryQuDFSMXQ(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 测试callAstQueryShiyztq by hugo
	 */
	@Test
	public void shiYZTQuery1() {

		// 准备参数
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("keyvalue", "");
		map.put("condsql", "");
		map.put("sortpart", "");

		// 利用容器获取mapper
		SyztMapper mapper = applicationContext.getBean(SyztMapper.class);
		try {
			mapper.callAstQueryShiyztmxq(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 测试callAstQueryShiyztmxq by hugo
	 */
	@Test
	public void shiYZTQuery2() {

		// 准备参数
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("keyvalue", "");
		map.put("condsql", "");
		map.put("sortpart", "");

		// 利用容器获取mapper
		SyztMapper mapper = applicationContext.getBean(SyztMapper.class);
		try {
			mapper.callAstQueryShiyztmxq(map);
			;
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 测试service中的findShiYZT方法 by hugo
	 */
	@Test
	public void shiyzkMain() {

		// 使用状况总体条件组装
		Map<String, Object> totalCondition = new HashMap<String, Object>();
		totalCondition.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		totalCondition.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		totalCondition.put("deptid", "");
		totalCondition.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		totalCondition.put("keyvalue", "");
		totalCondition.put("condsql", "");
		totalCondition.put("sortpart", "");

		// 使用状况明细条件分享总体条件
		Map<String, Object> detailCondition = new HashMap<String, Object>(
				totalCondition);

		// 组装查询条件
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("totalCondition", totalCondition);
		map.put("detailCondition", detailCondition);

		// 通过容器获取service
		ShiyztService shiyztService = applicationContext
				.getBean(ShiyztService.class);
		try {
			shiyztService.queryShiYZT(map);
			System.out.println(map.get("totalCondition").get("P_DS"));
			System.out.println(map.get("detailCondition").get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 测试JsqkService中的queryJsqk方法 by hugo
	 */
	@Test
	public void findJsqk() {

		// 减少情况查询条件组装
		Map<String, Object> totalCondition = new HashMap<String, Object>();
		totalCondition.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		totalCondition.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		totalCondition.put("deptid", "");
		totalCondition.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		totalCondition.put("sjizrq", "2016-11-01");
		totalCondition.put("ejizrq", "2016-11-30");
		totalCondition.put("keyvalue", "");
		totalCondition.put("condsql", "");
		totalCondition.put("sortpart", "");

		// 减少情况明细查询的条件共享总体查询
		Map<String, Object> detailCondition = new HashMap<String, Object>(
				totalCondition);

		// 组装条件
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("totalCondition", totalCondition);
		map.put("detailCondition", detailCondition);

		// 查询结果集

		// 通过容器获取service
		JsqkService jsqkService = applicationContext.getBean(JsqkService.class);
		try {
			jsqkService.queryJsqk(map);
			System.out.println(map.get("totalCondition").get("P_DS"));
			System.out.println(map.get("detailCondition").get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 测试用途分类service中queryYtfl方法 by hugo
	 */
	@Test
	public void findYtfl() {

		// 组装参数
		Map<String, Object> chartCondition = new HashMap<String, Object>();
		chartCondition.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		chartCondition.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		chartCondition.put("deptid", "");
		chartCondition.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		chartCondition.put("cxtype", 0);
		chartCondition.put("keyvalue", "");
		chartCondition.put("condsql", "");
		chartCondition.put("sortpart", "");

		// 图和表的参数就cxtype不同
		Map<String, Object> tempMap = new HashMap<String, Object>(
				chartCondition);
		tempMap.put("cxtype", 1);
		Map<String, Object> tabCondition = new HashMap<String, Object>(tempMap);

		// 组装总参数
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("chartCondition", chartCondition);
		map.put("tabCondition", tabCondition);

		// 查询结果

		// 利用容器获取service
		YtflService ytflService = applicationContext.getBean(YtflService.class);
		try {
			ytflService.queryYtfl(map);
			System.out.println(map.get("chartCondition").get("P_DS"));
			System.out.println(map.get("tabCondition").get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 测试待报废service中的queryDbfzc方法 by hugo
	 */
	@Test
	public void findDbfzc() {

		// 组装参数

		// 待报废资产总体条件组装
		Map<String, Object> totalCondition = new HashMap<String, Object>();
		totalCondition.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		totalCondition.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		totalCondition.put("deptid", "");
		totalCondition.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		totalCondition.put("keyvalue", "");
		totalCondition.put("condsql", "");
		totalCondition.put("sortpart", "");

		// 待报废资产明细条件分享总体条件
		Map<String, Object> detailCondition = new HashMap<String, Object>(
				totalCondition);

		// 组装查询条件
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("totalCondition", totalCondition);
		map.put("detailCondition", detailCondition);

		// 查询结果

		// 利用容器获得service
		DbfzcService dbfzcService = applicationContext
				.getBean(DbfzcService.class);
		try {
			dbfzcService.queryDbfzc(map);
			System.out.println(map.get("totalCondition").get("P_DS"));
			System.out.println(map.get("detailCondition").get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 测试入账情况service中的queryRzqk方法 by hugo
	 */
	@Test
	public void findRzqk() {

		// 组装参数

		// 登账状态条件组装
		Map<String, Object> dzztCondition = new HashMap<String, Object>();
		dzztCondition.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		dzztCondition.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		dzztCondition.put("deptid", "");
		dzztCondition.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		dzztCondition.put("keyvalue", "");
		dzztCondition.put("condsql", "");
		dzztCondition.put("sortpart", "");

		// 总账查询条件组装
		Map<String, Object> zzCondition = new HashMap<String, Object>();
		zzCondition.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		zzCondition.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		zzCondition.put("deptid", "");
		zzCondition.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		zzCondition.put("stime", "2016-10-31");
		zzCondition.put("etime", "2016-11-10");
		zzCondition.put("keyvalue", "");
		zzCondition.put("condsql", "");
		zzCondition.put("sortpart", "");

		// 组装查询条件
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("dzztCondition", dzztCondition);
		map.put("zzCondition", zzCondition);

		// 查询结果集

		// 利用容器获取service
		RzqkService rzqkService = applicationContext.getBean(RzqkService.class);
		try {
			rzqkService.queryRzqk(map);
			System.out.println(map.get("dzztCondition").get("P_DS"));
			System.out.println(map.get("zzCondition").get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void findWxqk() {

		/* 参数组装 --Begin */

		// 最近十年资产维修趋势图参数组装
		Map<String, Object> tenYearsTotalCondition = new HashMap<String, Object>();
		tenYearsTotalCondition.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		tenYearsTotalCondition
				.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		tenYearsTotalCondition.put("deptid", "");
		tenYearsTotalCondition
				.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		tenYearsTotalCondition.put("year", "2016");
		tenYearsTotalCondition.put("cxtype", 0);
		tenYearsTotalCondition.put("keyvalue", "");
		tenYearsTotalCondition.put("condsql", "");
		tenYearsTotalCondition.put("sortpart", "");

		// 本年度资产维修趋势图参数组装
		Map<String, Object> tempMap = new HashMap<String, Object>(
				tenYearsTotalCondition);
		tempMap.put("cxtype", 1);
		Map<String, Object> oneYearTotalCondition = new HashMap<String, Object>(
				tempMap);

		// 维修情况图参数组装
		Map<String, Object> detailCondition = new HashMap<String, Object>();
		detailCondition.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		detailCondition.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		detailCondition.put("deptid", "");
		detailCondition.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		detailCondition.put("nd", "2016");
		detailCondition.put("yf", "");

		// 查询参数组装
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		map.put("tenYearsTotalCondition", tenYearsTotalCondition);
		map.put("oneYearTotalCondition", oneYearTotalCondition);
		map.put("detailCondition", detailCondition);

		/* 参数组装 --End */

		/* 查询结果集 */

		// 通过容器获取service
		WxqkService wxqkService = applicationContext.getBean(WxqkService.class);
		try {
			wxqkService.queryWxqk(map);
			System.out.println(map.get("tenYearsTotalCondition").get("P_DS"));
			System.out.println(map.get("oneYearTotalCondition").get("P_DS"));
			System.out.println(map.get("detailCondition").get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void ACNUMQ() {
		// 构建参数
		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * ACNUMQ('F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6',
		 * 'A075922D88AB4BC58E73E9DDEBCB074A', '',
		 * '06B83490575848FEB55D5C76F1B0F07D', '', 0, '', '空调', 'and
		 * DL.RWID<>''3DCA958F0000002178673E76D0CE4984'' and c.SHIYZKID =
		 * ''3F5B09F3E00000016BE054BFD00B9D4D''',
		 */
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("shzkcode", "");
		map.put("querytype", 0);
		map.put("rwid", "");
		map.put("keyvalue", "");
		map.put("condsql",
				"and DL.RWID<>'3DCA958F0000002178673E76D0CE4984' and c.SHIYZKID ='3F5B09F3E00000016BE054BFD00B9D4D'");
		BsAstCardMapper bsAstCardMapper = applicationContext
				.getBean(BsAstCardMapper.class);
		try {
			bsAstCardMapper.callAcnumq(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void ACQ() {
		// 构建参数
		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * ACQ(
		 * 'F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6','A075922D88AB4BC58E73E9DDEBCB074A',
		 * 21, 40, '', '06B83490575848FEB55D5C76F1B0F07D', '', 0, '', '空调', 'and
		 * DL.RWID<>''3DCA958F0000002178673E76D0CE4984'' and c.SHIYZKID =
		 * ''3F5B09F3E00000016BE054BFD00B9D4D''', '',:OUT_REF<refcur,out[50]>);
		 * END;
		 */
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("snum", 0);
		map.put("enum", 20);
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("shzkcode", "");
		map.put("querytype", 0);
		map.put("rwid", "");
		map.put("keyvalue", "空调");
		map.put("condsql",
				"and DL.RWID<>'3DCA958F0000002178673E76D0CE4984' and c.SHIYZKID ='3F5B09F3E00000016BE054BFD00B9D4D'");
		map.put("sortpart", "");
		BsAstCardMapper bsAstCardMapper = applicationContext
				.getBean(BsAstCardMapper.class);
		try {
			bsAstCardMapper.callAcq(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 由于数据库参数的顺序问题导致查询sql无法被转换.
	 */
	@Test
	public void ACMXQ() {
		// 构造参数
		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * ACMXQ(
		 * 'F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6',1,'E4DC26EA8A9A42ED862948DFD046917F',
		 * :OUT_REF<refcur,out[50]>); END;
		 */
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("type", 1);
		map.put("idorcode", "E4DC26EA8A9A42ED862948DFD046917F");
		// List<Object> list = new ArrayList<Object>();
		// map.put("P_DS", list);
		// map.put("isphone", new Integer(0));
		BsAstCardMapper bsAstCardMapper = applicationContext
				.getBean(BsAstCardMapper.class);
		try {
			bsAstCardMapper.callAcmxq(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void BSDTQ() {
		// 构造参数
		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * BSDTQ(
		 * 'F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6','A075922D88AB4BC58E73E9DDEBCB074A',
		 * '06B83490575848FEB55D5C76F1B0F07D', '', 'CARD', '2016-11-21
		 * 15:26:14', :OUT_REF<refcur,out[50]>); END;
		 */
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("datatype", "CARD");
		map.put("datatime", "2016-11-21 15:26:14");
		BsAstCardMapper bsAstCardMapper = applicationContext
				.getBean(BsAstCardMapper.class);
		try {
			bsAstCardMapper.callBsdtq(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void FUSSB() {
		// 构造参数
		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * AST_QUERY.FUSSB( 'F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6',
		 * 'A075922D88AB4BC58E73E9DDEBCB074A','',
		 * '06B83490575848FEB55D5C76F1B0F07D',1,20000,'','AND ZF.ZCOBJID=
		 * ''1724492A9FEB484281B364420EF8F99D''','',:OUT_REF<refcur,out[50]>);
		 * END;
		 */
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("snum", 1);
		map.put("enum", 20000);
		map.put("keyvalue", "");
		map.put("condsql", "AND ZF.ZCOBJID= '1724492A9FEB484281B364420EF8F99D'");
		map.put("sortpart", "");
		BsAstCardMapper bsAstCardMapper = applicationContext
				.getBean(BsAstCardMapper.class);
		try {
			bsAstCardMapper.callQueryFussb(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void CBSMDEFQ() {
		// 构造参数
		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * CBSMDEFQ('F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6',
		 * '100F4A9BE5D2F5BEFBB7C8FA0883835F', '', :OUT_REF<refcur,out[50]>);
		 * END;
		 */
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("modelid", "100F4A9BE5D2F5BEFBB7C8FA0883835F");
		map.put("Minrvsvn", "");
		BsAstCardMapper bsAstCardMapper = applicationContext
				.getBean(BsAstCardMapper.class);
		try {
			bsAstCardMapper.callCbsmdefq(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void ZHEJMX() {
		// 构造参数
		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * #{orgid, mode=IN, jdbcType=VARCHAR}, #{cardobjid, mode=IN,
		 * jdbcType=VARCHAR},
		 */
		map.put("orgid", "'F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6'");
		map.put("cardobjid", "'A192916420494870970A481BBB8DF927'");
		BsAstCardMapper bsAstCardMapper = applicationContext
				.getBean(BsAstCardMapper.class);
		try {
			bsAstCardMapper.callQueryZhejmx(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void AWXQ() {
		// 构造参数
		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * #{orgid, mode=IN, jdbcType=VARCHAR}, #{userid, mode=IN,
		 * jdbcType=VARCHAR}, #{deptid, mode=IN, jdbcType=VARCHAR}, #{roleid,
		 * mode=IN, jdbcType=VARCHAR}, #{snum, mode=IN, jdbcType=VARCHAR},
		 * #{enum, mode=IN, jdbcType=VARCHAR}, #{weixzt, mode=IN,
		 * jdbcType=VARCHAR}, #{keyvalue, mode=IN, jdbcType=VARCHAR}, #{condsql,
		 * mode=IN, jdbcType=VARCHAR}, #{sortpart, mode=IN, jdbcType=VARCHAR}
		 * ast_weix.AWXQ( 'F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6',
		 * 'A075922D88AB4BC58E73E9DDEBCB074A','',
		 * '06B83490575848FEB55D5C76F1B0F07D', 1, 1000, 5,'', ' AND
		 * A.CARDOBJECTID = ''A192916420494870970A481BBB8DF927''', '',
		 */
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("snum", "1");
		map.put("enum", "1000");
		map.put("weixzt", "5");
		map.put("keyvalue", "空调");
		map.put("condsql",
				"AND A.CARDOBJECTID = 'A192916420494870970A481BBB8DF927'");
		map.put("sortpart", "");
		BsAstCardMapper bsAstCardMapper = applicationContext
				.getBean(BsAstCardMapper.class);
		try {
			bsAstCardMapper.callWeixAwxq(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void ACLOGQ() {
		// 构造参数
		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * AST_CARD.ACLOGQ('A192916420494870970A481BBB8DF927',
		 */
		map.put("cardobjid", "A192916420494870970A481BBB8DF927");
		BsAstCardMapper bsAstCardMapper = applicationContext
				.getBean(BsAstCardMapper.class);
		try {
			bsAstCardMapper.callCardAclogq(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void ACWXNUMQ() {
		// 构建查询条件
		/*
		 * AST_QUERY.ACWXNUMQ(
		 * '864A334C0636E2970E2A6F9AFA107EDF',
		 * 'A164F3692B364B8D92385C474BA27333','',
		 * '71E1C490E0E9459D8AFC9E475830B514','1','20','2016','','','
		 * AND WX.WEIXFSID
		 * =''3D6E84664C0C4210A8598A8181924134''','',:OUT_REF<refcur,out[50]>);
		 * END;
		 */
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "864A334C0636E2970E2A6F9AFA107EDF");
		map.put("userid", "A164F3692B364B8D92385C474BA27333");
		map.put("deptid", "");
		map.put("roleid", "71E1C490E0E9459D8AFC9E475830B514");
		map.put("snum", "1");
		map.put("enum", "20");
		map.put("time", "2016");
		map.put("moth", "");
		map.put("keyvalue", "");
		map.put("condsql",
				"AND WX.WEIXFSID='3D6E84664C0C4210A8598A8181924134'");
		map.put("sortpart", "");
		BsAstCardMapper bsAstCardMapper = applicationContext.getBean(BsAstCardMapper.class);
		try {
			bsAstCardMapper.callAstQueryAcwxnumq(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void ACWXQ() {
		//参数组装
		/*
		 *  17:59:50.698 [Debug] BEGIN AST_QUERY.ACWXQ(
		 * '864A334C0636E2970E2A6F9AFA107EDF',
		 * 'A164F3692B364B8D92385C474BA27333','',
		 * '71E1C490E0E9459D8AFC9E475830B514','1','20','2016','','','
		 * AND WX.WEIXFSID
		 * =''3D6E84664C0C4210A8598A8181924134''','',:OUT_REF<refcur,out[50]>);
		 * END;
		 * */
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "864A334C0636E2970E2A6F9AFA107EDF");
		map.put("userid", "A164F3692B364B8D92385C474BA27333");
		map.put("deptid", "");
		map.put("roleid", "71E1C490E0E9459D8AFC9E475830B514");
		map.put("snum", "1");
		map.put("enum", "20");
		map.put("time", "2016");
		map.put("moth", "");
		map.put("keyvalue", "");
		map.put("condsql",
				"AND WX.WEIXFSID='3D6E84664C0C4210A8598A8181924134'");
		map.put("sortpart", "");
		BsAstCardMapper bsAstCardMapper = applicationContext.getBean(BsAstCardMapper.class);
		try {
			bsAstCardMapper.callAstQueryAcwxq(map);
			System.out.println(map.get("P_DS"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
