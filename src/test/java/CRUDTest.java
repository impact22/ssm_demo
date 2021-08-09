import com.bo.dao.DepartmentMapper;
import com.bo.dao.EmployeeMapper;
import com.bo.pojo.Department;
import com.bo.pojo.Employee;
import org.apache.ibatis.session.SqlSession;
import org.aspectj.apache.bcel.util.ClassPath;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @author Bo
 * @version 1.0
 * @date 2021/8/3 10:15
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:application.xml"})
public class CRUDTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void crud(){
        //最老的方式了
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("application.xml");
//        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));

//        employeeMapper.insertSelective(new Employee(null,"张波","男","11@qq.com",1));
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 100; i++) {
//            mapper.insertSelective(new Employee(null,"zb","boy","11",1));
//        }

    }
}
