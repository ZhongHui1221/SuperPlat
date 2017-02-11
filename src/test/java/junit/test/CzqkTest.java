package junit.test;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zheling.sup.query.mapper.CzqkMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath*:/applicationContext.xml" })
public class CzqkTest {

	@Autowired
	private CzqkMapper czqkMapper;

	Map<String, Object> baseCondition = new HashMap<String, Object>();
	{
		baseCondition.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		baseCondition.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		baseCondition.put("deptid", "");
		baseCondition.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
	}

	@Test
	public void callAstQueryCzhzq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("year", "");
		// condition.put("year", "2016");
		czqkMapper.callAstQueryCzhzq(condition);
		System.out.println(condition.get("P_DS"));
	}

	/**
	 * 数量查询
	 * 
	 * @throws SQLException
	 */
	@Test
	public void callAstQueryCzhzmxnumq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("year", "2016");
		condition.put("month", "07");
		condition.put("keyvalue", "");
		czqkMapper.callAstQueryCzhzmxnumq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstQueryCzhzmxq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("snum", 1);
		condition.put("enum", 20);
		condition.put("year", "2016");
		condition.put("month", "07");
		condition.put("keyvalue", "");
		condition.put("sortpart", "");
		czqkMapper.callAstQueryCzhzmxq(condition);
		System.out.println(condition.get("P_DS"));
	}

	/**
	 * 数量查询
	 * 
	 * @throws SQLException
	 */
	@Test
	public void callAstChuzCzmxnumq2() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("type", "CZ1");
		condition.put("rwid", "196C1923AA774031B87AFA7CF4C75F2E");
		condition.put("keyvalue", "");
		condition.put("condsql", "");
		czqkMapper.callAstChuzCzmxnumq2(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstChuzCzmxq2() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("snum", 1);
		condition.put("enum", 20);
		condition.put("type", "CZ1");
		condition.put("rwid", "196C1923AA774031B87AFA7CF4C75F2E");
		condition.put("keyvalue", "");
		condition.put("condsql", "");
		condition.put("sortpart", "");
		czqkMapper.callAstChuzCzmxq2(condition);
		System.out.println(condition.get("P_DS"));
	}

	/**
	 * 数量查询
	 * 
	 * @throws SQLException
	 */
	@Test
	public void callAstChuzCznumq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("pifzt", "1");
		condition.put("dengzzt", "-1");
		condition.put("keyvalue", "");
		condition.put("condsql", "");
		czqkMapper.callAstChuzCznumq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstChuzCzq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("chuzdid", "");
		condition.put("snum", 1);
		condition.put("enum", 20);
		condition.put("pifzt", "1");
		condition.put("dengzzt", "-1");
		condition.put("keyvalue", "");
		condition.put("condsql", "");
		condition.put("sortpart", "");
		czqkMapper.callAstChuzCzq(condition);
		System.out.println(condition.get("P_DS"));
	}

	/**
	 * 数量查询
	 * 
	 * @throws SQLException
	 */
	@Test
	public void callAstChuzSymxnumq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("shouymxid", "");
		// 0：处置执行中，1：处置完成
		condition.put("chuzzt", "0");
		// condition.put("chuzzt", "1");
		condition.put("keyvalue", "");
		condition.put("condsql", "");
		czqkMapper.callAstChuzSymxnumq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstChuzSymxq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("snum", 1);
		condition.put("enum", 20);
		condition.put("shouymxid", "");
		// 0：处置执行中，1：处置完成
		condition.put("chuzzt", "0");
		// condition.put("chuzzt", "1");
		condition.put("keyvalue", "");
		condition.put("condsql", "");
		condition.put("sortpart", "");
		czqkMapper.callAstChuzSymxq(condition);
		System.out.println(condition.get("P_DS"));
	}

}