package junit.test;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zheling.base.mapper.BdDeptMapper;
import com.zheling.base.mapper.CoreUserMapper;
import com.zheling.sup.monitor.mapper.PdjkMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath*:/applicationContext.xml" })
public class PdjkTest {

	@Autowired
	private CoreUserMapper coreUserMapper;
	@Autowired
	private BdDeptMapper bdDeptMapper;
	@Autowired
	private PdjkMapper pdjkMapper;

	Map<String, Object> baseCondition = new HashMap<String, Object>();
	{
		baseCondition.put("orgid", "864A334C0636E2970E2A6F9AFA107EDF");
		baseCondition.put("userid", "412C1919CF5B42D8A2071844E1BF9F6C");
		baseCondition.put("deptid", "");
		// 主管部门
		baseCondition.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
		// 单位领导
		// baseCondition.put("roleid", "C71B8E9244614509BC07C8BE05E8A2DD");
	}

	@Test
	public void callCoreGetdept() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		condition.put("orgid", "4A9BC790C5C70C9AC6278BE4B24EE728");
		condition.put("userid", "C9456E334CF84F4498BAA65F26086509");
		condition.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		bdDeptMapper.callCoreGetdept(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callApdcanpost() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		condition.put("qcjzr", "2016-07-31");
		pdjkMapper.callApdcanpost(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstPandJizrq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		pdjkMapper.callAstPandJizrq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstPandPddtq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		condition.put("qcjzr", "2016-07-31");
		condition.put("stattype", "2");
		condition.put("querytype", "0");
		condition.put("rwid", "");
		pdjkMapper.callAstPandPddtq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstPandPddtorgq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		condition.put("qcjzr", "2016-12-14");
		condition.put("stattype", "2");
		condition.put("querytype", "0");
		condition.put("rwid", "");
		condition.put("optorgid", "7B2998E7A2CA4C32A5F9B58652EE785A");
		pdjkMapper.callAstPandPddtorgq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstPandQcjzrorgq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		pdjkMapper.callAstPandQcjzrorgq(condition);
		System.out.println(condition.get("P_DS"));
	}

	/**
	 * 总体情况查询
	 * 
	 * @throws SQLException
	 */
	@Test
	public void callAstPandPdnumq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		condition.put("orgid", "4A9BC790C5C70C9AC6278BE4B24EE728");
		condition.put("qcjzr", "2016-12-19");
		condition.put("querytype", "1");
		condition.put("rwid", "3F5B09C1400000010A9442FDA2091273");
		condition.put("keyvalue", "");
		condition.put("condsql", "and c.pdid is null");
		pdjkMapper.callAstPandPdnumq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstPandPdq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		condition.put("orgid", "4A9BC790C5C70C9AC6278BE4B24EE728");
		condition.put("qcjzr", "2016-12-19");
		condition.put("snum", 1);
		condition.put("enum", 20);
		condition.put("querytype", "1");
		condition.put("rwid", "3F5B09C1400000010A9442FDA2091273");
		condition.put("keyvalue", "");
		condition.put("condsql", "and c.pdid is null");
		condition.put("sortpart", "");
		pdjkMapper.callAstPandPdq(condition);
		System.out.println(condition.get("P_DS"));
	}

	/**
	 * 数量查询
	 * 
	 * @throws SQLException
	 */
	@Test
	public void callAstPandPynumq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		condition.put("qcjzr", "2016-12-19");
		condition.put("keyvalue", "");
		condition.put("condsql", "AND P.CREATERDEPTID IS NULL");
		pdjkMapper.callAstPandPynumq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstPandPyq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		condition.put("snum", 1);
		condition.put("enum", 20);
		condition.put("qcjzr", "2016-12-19");
		condition.put("keyvalue", "");
		condition.put("condsql", "AND P.CREATERDEPTID IS NULL");
		condition.put("sortpart", "");
		pdjkMapper.callAstPandPyq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callCoreGetusers() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		condition.put("orgid", "864A334C0636E2970E2A6F9AFA107EDF");
		condition.put("includechilddept", "1");
		coreUserMapper.callCoreGetusers(condition);
		System.out.println(condition.get("P_DS"));
	}

}