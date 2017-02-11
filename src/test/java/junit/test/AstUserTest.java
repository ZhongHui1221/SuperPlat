package junit.test;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zheling.base.mapper.AstUserMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath*:/applicationContext.xml" })
public class AstUserTest {

	@Autowired
	private AstUserMapper astUserMapper;

	Map<String, Object> baseCondition = new HashMap<String, Object>();
	{
		baseCondition.put("orgid", "4A9BC790C5C70C9AC6278BE4B24EE728");
		baseCondition.put("userid", "C9456E334CF84F4498BAA65F26086509");
		baseCondition.put("deptid", "10FA98A26A6C4F5E8F7850129AE43367");
		baseCondition.put("roleid", "63D02E565F284EC69E7A722939A98004");
	}

	@Test
	public void callAstUserUserq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("type", "0");
		condition.put("rwid", "");
		astUserMapper.callAstUserUserq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstUserUserin() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("orgid", "4A9BC790C5C70C9AC6278BE4B24EE728");
		condition.put("zhanghm", "wgj");
		condition.put("objname", "王冠捷");
		condition.put("psw", "202CB962AC59075B964B07152D234B70");
		condition.put("shoujh", "18521599961");
		condition.put("youx", "");
		condition.put("diz", "");
		condition.put("des", "");
		condition
				.put("roleid",
						"4DF9FAE4918D46D9914E501440191EF7,D2F7D1DC562640B486475A8F2309A048,63D02E565F284EC69E7A722939A98004,C71B8E9244614509BC07C8BE05E8A2DD,B1C2A17CB38945068F20A82246E87961");
		condition
				.put("deptid",
						"10FA98A26A6C4F5E8F7850129AE43367,4F707DCBA4BE4E229B1D9ECE8DDCF1B6,07164F433EC6461BBC703906AE831D52,3288EA42CE4B48D3A5ABD443A6DBDC55");
		condition.put("shenfzh", "");
		condition.put("xingb", 1);
		condition.put("toux", "");
		condition.put("needaudit", 0);
		condition.put("zhijid", "D01DFC1FB7FA435397FAA9F260B8C074");
		condition.put("shifzb", 1);
		astUserMapper.callAstUserUserin(condition);
	}

	@Test
	public void callAstUserUserupd() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("orgid", "F2910DDF2FD0BF52DC3ABAE2102BEB09");
		condition.put("userid", "C730D8BA8EDD4F9FA6F6DF6D71CD31ED");
		condition.put("deptid", "");
		condition.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		condition.put("yonghid", "C730D8BA8EDD4F9FA6F6DF6D71CD31ED");
		condition.put("juesid", "NULL");
		condition.put("bumid", "NULL");
		condition.put("shoujh", "18521599961");
		condition.put("zhijid", "D01DFC1FB7FA435397FAA9F260B8C074");
		condition.put("shifzb", "1");
		condition.put("oldpwd", "NULL");
		condition.put("newpwd", "202CB962AC59075B964B07152D234B70");
		condition.put("youx", "guanjie0423@qq.com");
		condition.put("diz", "123");
		condition.put("shenfzh", "320302199304252018");
		condition.put("xingm", "wgj");
		condition.put("denglm", "wgj");
		condition.put("toux", "NULL");
		condition.put("xingb", "1");
		astUserMapper.callAstUserUserupd(condition);
	}

	@Test
	public void callAstUserUserout() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("orgid", "4A9BC790C5C70C9AC6278BE4B24EE728");
		condition.put("userid", "C9456E334CF84F4498BAA65F26086509");
		condition.put("deptid", "");
		condition.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		condition.put("userids", "F1A3EB25B18A463081C7A170178E1BF9"); // 待删用户
		condition.put("type", 2);
		astUserMapper.callAstUserUserout(condition);
	}

	@Test
	public void callAstUserCunfddq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("snum", 1);
		condition.put("enum", 100);
		astUserMapper.callAstUserCunfddq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstUserCunfddin() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("orgid", "F2910DDF2FD0BF52DC3ABAE2102BEB09");
		condition.put("userid", "C730D8BA8EDD4F9FA6F6DF6D71CD31ED");
		condition.put("deptid", "");
		condition.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		condition.put("objcode", "");
		condition.put("objname", "555");
		condition.put("suosbmid", "CE77EFE20C7941F5A008DCA4ECADA34D");
		condition.put("beiz", "159");
		astUserMapper.callAstUserCunfddin(condition);
	}

	@Test
	public void callAstUserCunfddupd() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("orgid", "F2910DDF2FD0BF52DC3ABAE2102BEB09");
		condition.put("userid", "C730D8BA8EDD4F9FA6F6DF6D71CD31ED");
		condition.put("deptid", "");
		condition.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		condition.put("cunfddid", "F9A7BCAAA22B424C8E71E65AC328D86C");
		condition.put("objcode", "NULL");
		condition.put("objname", "555");
		condition.put("suosbmid", "CE77EFE20C7941F5A008DCA4ECADA34D");
		condition.put("beiz", "159");
		astUserMapper.callAstUserCunfddupd(condition);
	}

	@Test
	public void callAstUserCunfddout() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("cunfddid", "E19456D841434D49BBB65FE813EA65B5");
		astUserMapper.callAstUserCunfddout(condition);
	}

}