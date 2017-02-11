package junit.test;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zheling.org.notice.mapper.NoticeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath*:/applicationContext.xml" })
public class NoticeTest {

	@Autowired
	private NoticeMapper noticeMapper;

	Map<String, Object> baseCondition = new HashMap<String, Object>();
	{
		baseCondition.put("orgid", "4A9BC790C5C70C9AC6278BE4B24EE728");
		baseCondition.put("userid", "C9456E334CF84F4498BAA65F26086509");
		baseCondition.put("deptid", "10FA98A26A6C4F5E8F7850129AE43367");
		baseCondition.put("roleid", "B1C2A17CB38945068F20A82246E87961");
	}

	@Test
	public void callCoreNtget() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		noticeMapper.callCoreNtget(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callNtDefin() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("orgid", "F2910DDF2FD0BF52DC3ABAE2102BEB09");
		condition.put("userid", "C730D8BA8EDD4F9FA6F6DF6D71CD31ED");
		condition.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		condition.put("rwid", "46AD526946294A0F973D9ACCB5AC3515");
		condition.put("nstype", "GG");
		condition.put("title", "999");
		condition.put("msg", "88");
		condition.put("jiezrq", "2017-02-07");
		noticeMapper.callNtDefin(condition);
	}

	@Test
	public void callNtDonein() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("ntrwid", "0A2665A0C01C496FBF744067746FC553");
		noticeMapper.callNtDonein(condition);
	}

	@Test
	public void callNtDefq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("nttype", "GG");
		noticeMapper.callNtDefq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callNtDefd() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("rwids", "66A7F1FC826C403B935542EF29A13718,7CAEE46726644CE0AE1BFEFD6B19E52E");
		condition.put("nstype", "GG");
		noticeMapper.callNtDefd(condition);
	}

}