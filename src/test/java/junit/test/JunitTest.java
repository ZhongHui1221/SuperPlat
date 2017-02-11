package junit.test;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zheling.base.entity.BdOrg;
import com.zheling.base.mapper.BdOrgMapper;
import com.zheling.base.mapper.CoreUserMapper;
import com.zheling.base.util.DataProcessUtil;
import com.zheling.sup.query.mapper.BsAstCardMapper;
import com.zheling.sup.query.mapper.CyzcMapper;
import com.zheling.sup.query.mapper.FbqkMapper;
import com.zheling.sup.query.mapper.ZtqkMapper;

public class JunitTest {

	ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
			"applicationContext.xml");
	SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) applicationContext
			.getBean(SqlSessionFactory.class);

	@Test
	public void callCoreLogin() throws SQLException {
		CoreUserMapper coreUserMapper = sqlSessionFactory.openSession().getMapper(
				CoreUserMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "4A9BC790C5C70C9AC6278BE4B24EE728");
		map.put("zhanghm", "www");
		map.put("psw", DataProcessUtil.md5("123qwe"));
		coreUserMapper.callCoreLogin(map);

		System.out.println(map.get("P_DS1"));
		// [{SUOSDWID=F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6, ...}]
		List<Object> cursor1 = (List<Object>) map.get("P_DS1");
		if (cursor1 != null && cursor1.size() > 0) {
			Map<String, Object> tmpMap = (Map<String, Object>) cursor1.get(0);
			// System.out.println(tmpMap.get("SUOSDWID"));
		}

		System.out.println(map.get("P_DS2"));
		// [{RWID=06B83490575848FEB55D5C76F1B0F07D, ...}]
		List<Object> cursor2 = (List<Object>) map.get("P_DS2");
		if (cursor2 != null && cursor2.size() > 0) {
			Map<String, Object> tmpMap = (Map<String, Object>) cursor2.get(0);
			// System.out.println(tmpMap.get("RWID"));
		}
	}

	@Test
	public void callAstQueryOrgq() throws SQLException {
		BdOrgMapper bdOrgMapper = sqlSessionFactory.openSession().getMapper(BdOrgMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		bdOrgMapper.callAstQueryOrgq(map);
		System.out.println(map.get("P_DS"));
	}

	@Test
	public void callAstQueryZcdl() throws SQLException {
		BsAstCardMapper bsAstCardMapper = sqlSessionFactory.openSession().getMapper(
				BsAstCardMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "864A334C0636E2970E2A6F9AFA107EDF");
		map.put("userid", "7A33E9B9102B4D76A6AF7C8E06F4FF9C");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("keyvalue", "");
		map.put("condsql", "");
		map.put("sortpart", "");
		map.put("jizrq", "2016-10-31");
		bsAstCardMapper.callAstQueryZcdl(map);
		System.out.println(map.get("P_DS"));
	}

	@Test
	public void callAstQueryZdqk() throws SQLException {
		BsAstCardMapper bsAstCardMapper = sqlSessionFactory.openSession().getMapper(
				BsAstCardMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "864A334C0636E2970E2A6F9AFA107EDF");
		bsAstCardMapper.callAstQueryZdqk(map);
		System.out.println(map.get("P_DS"));
	}

	@Test
	public void callAstQuerySyzt() throws SQLException {
		BsAstCardMapper bsAstCardMapper = sqlSessionFactory.openSession().getMapper(
				BsAstCardMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "864A334C0636E2970E2A6F9AFA107EDF");
		map.put("userid", "7A33E9B9102B4D76A6AF7C8E06F4FF9C");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("keyvalue", "");
		map.put("condsql", "");
		map.put("sortpart", "");
		bsAstCardMapper.callAstQuerySyzt(map);
		System.out.println(map.get("P_DS"));
	}

	@Test
	public void findOrgsByParentid() throws SQLException {
		BdOrgMapper bdOrgMapper = sqlSessionFactory.openSession().getMapper(BdOrgMapper.class);
		List<BdOrg> orgs = bdOrgMapper.findOrgsByParentid("060B3827F4613B09F415D03BF325F314");
		System.out.println(orgs);
	}

	@Test
	public void getCurrentDate() throws SQLException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateStr = sdf.format(new Date());
		System.out.println(dateStr);
	}

	@Test
	public void callAstQueryCyq() throws SQLException {
		CyzcMapper cyzcMapper = sqlSessionFactory.openSession().getMapper(CyzcMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "51DDA3BC0BAE4E73D0EC9A27E7F66D7E");
		map.put("userid", "78E00D137A6E48E682E3BCD749CBECF7");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("keyvalue", "");
		map.put("condsql", "");
		map.put("sortpart", "");
		cyzcMapper.callAstQueryCyq1(map);
		// cyzcMapper.callAstQueryCyq2(map);
		// cyzcMapper.callAstQueryCyq3(map);
		// cyzcMapper.callAstQueryCyq4(map);
		System.out.println(map.get("P_DS"));
	}

	@Test
	public void callAstQueryYongtq() throws SQLException {
		CyzcMapper cyzcMapper = sqlSessionFactory.openSession().getMapper(CyzcMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "864A334C0636E2970E2A6F9AFA107EDF");
		map.put("userid", "A164F3692B364B8D92385C474BA27333");
		map.put("deptid", "");
		map.put("roleid", "71E1C490E0E9459D8AFC9E475830B514");
		map.put("condsql", "");
		cyzcMapper.callAstQueryYongtq(map);
		// cyzcMapper.callAstQueryYtsyzkq(map);
		System.out.println(map.get("P_DS"));
	}

	@Test
	public void callAstQueryCunlsyq() throws SQLException {
		ZtqkMapper ztqkMapper = sqlSessionFactory.openSession().getMapper(ZtqkMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "864A334C0636E2970E2A6F9AFA107EDF");
		map.put("userid", "A164F3692B364B8D92385C474BA27333");
		map.put("deptid", "");
		map.put("roleid", "71E1C490E0E9459D8AFC9E475830B514");
		map.put("chaxtype", "0");
		map.put("year", "");
		ztqkMapper.callAstQueryCunlsyq(map);
		System.out.println(map.get("P_DS"));
	}

	@Test
	public void callAstQueryHuizDeptq() throws SQLException {
		FbqkMapper fbqkMapper = sqlSessionFactory.openSession().getMapper(FbqkMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "FB737EED439CF53D469DC7ACE81557CE");
		map.put("userid", "A164F3692B364B8D92385C474BA27333");
		map.put("deptid", "");
		map.put("roleid", "71E1C490E0E9459D8AFC9E475830B514");
		map.put("gouzrqnd", "");
		map.put("condsql", "");
		fbqkMapper.callAstQueryHuizDeptq(map);
		System.out.println(map.get("P_DS"));
	}

	@Test
	public void callAcnumq() throws SQLException {
		BsAstCardMapper bsAstCardMapper = sqlSessionFactory.openSession().getMapper(
				BsAstCardMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("shzkcode", "");
		map.put("querytype", "0");
		map.put("rwid", "");
		map.put("keyvalue", "");
		map.put("condsql",
				"and C.YONGTID IN ('372BA061E0000001726F76BDE3F9B5EC') AND C.ZICFLID IN ('3755B564E00006417C2AAA4E76B6C723','3755B564E000068120776A221426A75A','3755B564E00006612822D17249E55062') AND TO_CHAR (C.GOUZRQ, 'YYYY-MM-DD') <= '2016-11-21' AND C.SHIYZKID = '3F5B09F3E00000016BE054BFD00B9D4D'");
		bsAstCardMapper.callAcnumq(map);
		System.out.println(map.get("P_DS"));
	}

	@Test
	public void callAcq() throws SQLException {
		BsAstCardMapper bsAstCardMapper = sqlSessionFactory.openSession().getMapper(
				BsAstCardMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("snum", "31");
		map.put("enum", "60");
		map.put("deptid", "");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("shzkcode", "");
		map.put("querytype", "0");
		map.put("rwid", "");
		map.put("keyvalue", "");
		map.put("condsql",
				"and c.YONGTID  IN ('372BA061E0000001726F76BDE3F9B5EC')AND C.ZICFLID IN ('3755B564E00006A1F46E04B4CF02C3F6') AND TO_CHAR(C.GOUZRQ,'YYYY-MM-DD')<='2016-11-25' AND C.SHIYZKID = '3F5B09F3E00000016BE054BFD00B9D4D'");
		map.put("sortpart", "");
		bsAstCardMapper.callAcqDaoc(map);
		List<Object> cardCursor = (List<Object>) map.get("P_DS");
		System.out.println(cardCursor);
	}

	@Test
	public void callAstCommonZidydcq() throws SQLException {
		BsAstCardMapper bsAstCardMapper = sqlSessionFactory.openSession().getMapper(
				BsAstCardMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		map.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		map.put("type", "1");
		bsAstCardMapper.callAstCommonZidydcq(map);
		List<Object> cardCursor = (List<Object>) map.get("P_DS");
		System.out.println(cardCursor);
	}

	@Test
	public void callAstCardUpd() throws SQLException {
		BsAstCardMapper bsAstCardMapper = sqlSessionFactory.openSession().getMapper(
				BsAstCardMapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", "4A9BC790C5C70C9AC6278BE4B24EE728");
		map.put("userid", "C9456E334CF84F4498BAA65F26086509");
		map.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		map.put("cardrwid", "4F2096E560000001174E5E25058ACA7B");
		map.put("pairs", "pinp='wgj1'");
		bsAstCardMapper.callAstCardUpd(map);
	}

}