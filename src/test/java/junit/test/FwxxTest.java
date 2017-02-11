package junit.test;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zheling.sup.query.mapper.FwxxMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath*:/applicationContext.xml" })
public class FwxxTest {

	@Autowired
	private FwxxMapper fwxxMapper;

	Map<String, Object> baseCondition = new HashMap<String, Object>();
	{
		baseCondition.put("orgid", "F92D0EAB0B4AB5FCF1C75D7EE2B3B6E6");
		baseCondition.put("userid", "A075922D88AB4BC58E73E9DDEBCB074A");
		baseCondition.put("deptid", "");
		baseCondition.put("roleid", "06B83490575848FEB55D5C76F1B0F07D");
	}

	@Test
	public void callAstQueryCzhzq() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		fwxxMapper.callAstQueryFwxxq(condition);
		System.out.println(condition.get("P_DS"));
	}

}