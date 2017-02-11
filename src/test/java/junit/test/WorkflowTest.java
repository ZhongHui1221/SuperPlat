package junit.test;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zheling.base.mapper.WorkflowMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath*:/applicationContext.xml" })
public class WorkflowTest {

	@Autowired
	private WorkflowMapper workflowMapper;

	Map<String, Object> baseCondition = new HashMap<String, Object>();
	{
		baseCondition.put("orgid", "4A9BC790C5C70C9AC6278BE4B24EE728");
		baseCondition.put("userid", "F1A3EB25B18A463081C7A170178E1BF9");
		baseCondition.put("deptid", "10FA98A26A6C4F5E8F7850129AE43367");
		baseCondition.put("roleid", "B1C2A17CB38945068F20A82246E87961");
	}

	@Test
	public void callCoreWfget() throws SQLException {
		Map<String, Object> condition = new HashMap<String, Object>(
				baseCondition);
		workflowMapper.callCoreWfget(condition);
		System.out.println(condition.get("P_DS"));
	}

}