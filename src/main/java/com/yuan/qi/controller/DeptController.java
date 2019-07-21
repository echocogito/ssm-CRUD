package com.yuan.qi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuan.qi.bean.Department;
import com.yuan.qi.bean.Msg;
import com.yuan.qi.service.DepartmentService;

@Controller
public class DeptController {
	
	@Autowired
	DepartmentService departmentService;
	
	@RequestMapping("/deptList")
	@ResponseBody
	public Msg getAllWithJson() {
		List<Department> depts = departmentService.getAllDept();
		
		return Msg.success().add("depts", depts);
	}

}
