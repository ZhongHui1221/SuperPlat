package junit.test;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zheling.base.mapper.AstChuzMapper;
import com.zheling.base.mapper.AstCommonMapper;
import com.zheling.base.mapper.AstGengzMapper;
import com.zheling.base.mapper.AstTiaojMapper;
import com.zheling.base.mapper.AstTouzMapper;
import com.zheling.base.mapper.AstWeixMapper;
import com.zheling.base.mapper.AstZujMapper;
import com.zheling.sup.query.mapper.BsAstCardMapper;
import com.zheling.sup.query.service.BsAstCardService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath*:/applicationContext.xml" })
public class AstCommonTest {

	@Autowired
	private AstCommonMapper astCommonMapper;
	@Autowired
	private BsAstCardMapper bsAstCardMapper;
	@Autowired
	private BsAstCardService bsAstCardService;
	@Autowired
	private AstWeixMapper astWeixMapper;
	@Autowired
	private AstChuzMapper astChuzMapper;
	@Autowired
	private AstTiaojMapper astTiaojMapper;
	@Autowired
	private AstGengzMapper astGengzMapper;
	@Autowired
	private AstZujMapper astZujMapper;
	@Autowired
	private AstTouzMapper astTouzMapper;

	Map<String, Object> baseCondition = new HashMap<String, Object>();
	{
		baseCondition.put("orgid", "4A9BC790C5C70C9AC6278BE4B24EE728");
		baseCondition.put("userid", "C9456E334CF84F4498BAA65F26086509");
		baseCondition.put("deptid", "10FA98A26A6C4F5E8F7850129AE43367");
		baseCondition.put("roleid", "63D02E565F284EC69E7A722939A98004");
	}

	@Test
	public void callAstCommonAuthq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("enttype", 1);
		condition.put("restype", -1);
		astCommonMapper.callAstCommonAuthq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstCommonZidylq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("type", 1);
		astCommonMapper.callAstCommonZidylq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAcnumq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("querytype", 0);
		bsAstCardMapper.callAcnumq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstWeixWxin() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("deptid", "");
		condition.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		condition.put("cardrwid", "4F2096E560000001174E5E25058ACA7B");
		condition.put("querytype", "0");
		condition.put("sffz", "0");
		// astWeixMapper.callAstWeixWxin(condition);
		// astChuzMapper.callAstChuzCzmxin(condition);
		// astTiaojMapper.callAstTiaojZyin(condition);
		// astGengzMapper.callAstGengzGzin(condition);
		astTouzMapper.callAstTouzTzmxin(condition);
	}

	@Test
	public void callAstTiaojAcqghaud() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("orgid", "F2910DDF2FD0BF52DC3ABAE2102BEB09");
		condition.put("userid", "C730D8BA8EDD4F9FA6F6DF6D71CD31ED");
		condition.put("deptid", "CE77EFE20C7941F5A008DCA4ECADA34D");
		condition.put("roleid", "63D02E565F284EC69E7A722939A98004");
		condition.put("cardrwid", "54CCEED300000001624700E89457601A");
		condition.put("querytype", "0");
		astTiaojMapper.callAstTiaojAcqghaud(condition);
	}

	@Test
	public void callAstZujZujkpin() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("deptid", "");
		condition.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		condition.put("cardrwid", "4F2096E560000001174E5E25058ACA7B");
		condition.put("mianj", "0.00");
		// 01：出租，02：出借
		condition.put("zujfs", "01");
		// condition.put("zujfs", "02");
		condition.put("sdate", "2017-01-16");
		condition.put("edate", "2017-01-17");
		condition.put("querytype", "0");
		condition.put("sffz", "0");
		astZujMapper.callAstZujZujkpin(condition);
	}

	@Test
	public void callAstCardBiaosgy() throws Exception {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("deptid", "");
		condition.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		condition.put("cardrwid", "4F2096E560000001174E5E25058ACA7B");
		condition.put("querytype", "0");
		condition.put("sffz", "0");
		// 0：取消标记，1：标记为公用
		// condition.put("isgy", "0");
		condition.put("isgy", "1");
		String message = bsAstCardService.markAsPublic(condition);
		System.out.println(message);
	}

	@Test
	public void callAstCommonFujtpq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("userid", "C730D8BA8EDD4F9FA6F6DF6D71CD31ED");
		condition.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		// condition.put("bsid", "3C9CC849C70D4AF287E263563BD036D2");
		condition.put("bsid", "A9BD1C79B51A4968A346A5DECE43592C");
		condition.put("fileindex", "-1");
		astCommonMapper.callAstCommonFujtpq(condition);
		System.out.println(condition.get("P_DS"));
	}

	@Test
	public void callAstCommonFujtpin() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("orgid", "F2910DDF2FD0BF52DC3ABAE2102BEB09");
		condition.put("userid", "C730D8BA8EDD4F9FA6F6DF6D71CD31ED");
		condition.put("roleid", "389F71165DF445CDA125150AFBF331F0");
		condition.put("fujtpid", "21B186697FF64BE282EDA014B2A5BF0F");
		condition.put("bsid", "4912733B800000016C300B0B1ADA2825"); // 卡片 ID
		condition.put("title", "cache");
		condition.put("extension", "png");
		condition.put("fileindex", "1");
		condition.put("datatype", "CARD");
		astCommonMapper.callAstCommonFujtpin(condition);
	}

	@Test
	public void callAstCommonFujtpout() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("orgid", "F2910DDF2FD0BF52DC3ABAE2102BEB09");
		condition.put("userid", "C730D8BA8EDD4F9FA6F6DF6D71CD31ED");
		condition.put("bsid", "4912733B800000016C300B0B1ADA2825"); // 卡片 ID
		condition.put("fileindex", "1");
		condition.put("datatype", "CARD");
		astCommonMapper.callAstCommonFujtpout(condition);
	}

	@Test
	public void uuid() throws SQLException {
		UUID uuid = UUID.randomUUID();
		System.out.println(uuid.toString());
	}

	@Test
	public void callAstCommonGetorg() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(baseCondition);
		condition.put("objcode", "179001");
		astCommonMapper.callAstCommonGetorg(condition);
		System.out.println(condition.get("P_DS"));
	}

}