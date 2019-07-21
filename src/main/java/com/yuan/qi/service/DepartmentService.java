package com.yuan.qi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuan.qi.bean.Department;
import com.yuan.qi.mapper.DepartmentMapper;

@Service
public class DepartmentService {
	
	@Autowired
	DepartmentMapper deptMapper;
	
	public List<Department> getAllDept(){
		return deptMapper.selectByExample(null);
	}

}
