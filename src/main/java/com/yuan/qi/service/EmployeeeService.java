package com.yuan.qi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuan.qi.bean.Employeee;
import com.yuan.qi.bean.EmployeeeExample;
import com.yuan.qi.bean.EmployeeeExample.Criteria;
import com.yuan.qi.mapper.EmployeeeMapper;

@Service
public class EmployeeeService {

	@Autowired
	EmployeeeMapper employeeMapper;
	
	public List<Employeee> getAllEmps() {
		EmployeeeExample example = new EmployeeeExample();
		example.setOrderByClause("emp_id");
//		return employeeMapper.selectByExampleWithDept(null);
		return employeeMapper.selectByExampleWithDept(example);
	}
	
	public void saveEmp(Employeee employeee) {
		employeeMapper.insertSelective(employeee);
	}

	public Boolean checkEmpName(String empName) {
		EmployeeeExample example = new EmployeeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count==0;
	}

	public Employeee getEmp(Integer id) {
		return  employeeMapper.selectByPrimaryKey(id);
		
	}

	public void updateEmp(Employeee emp) {
		employeeMapper.updateByPrimaryKeySelective(emp);
		
	}

	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
		
	}

	public void deleteBatch(List<Integer> ids) {
		EmployeeeExample example = new EmployeeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
		
	}

}
