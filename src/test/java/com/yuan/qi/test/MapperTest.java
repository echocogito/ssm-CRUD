package com.yuan.qi.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yuan.qi.bean.Department;
import com.yuan.qi.bean.Employeee;
import com.yuan.qi.mapper.DepartmentMapper;
import com.yuan.qi.mapper.EmployeeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testDeptCRUD() {
		departmentMapper.insertSelective(new Department(null, "人事部"));
	}
	
	@Test
	public void testEmpCRUD() {
		employeeMapper.insertSelective(new Employeee(null, "小明","M", "10010@qq.com", 1));
		employeeMapper.insertSelective(new Employeee(null, "小红","F", "10086@qq.com", 1));
		employeeMapper.insertSelective(new Employeee(null, "Jack","F", "10001@qq.com", 2));
		employeeMapper.insertSelective(new Employeee(null, "Mary","F", "10099@qq.com", 2));
	}

	@Test
	public void testInsert() {
		EmployeeeMapper mapper = sqlSession.getMapper(EmployeeeMapper.class);
		for(int i=0; i<100; i++) {
			String uuid = UUID.randomUUID().toString().substring(0,8) + i;
			mapper.insertSelective(new Employeee(null, uuid, "F", uuid+"@yahoo.com", 2));
		}
	}

}
