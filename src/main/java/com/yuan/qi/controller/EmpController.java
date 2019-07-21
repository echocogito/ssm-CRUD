package com.yuan.qi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yuan.qi.bean.Employeee;
import com.yuan.qi.bean.Msg;
import com.yuan.qi.service.EmployeeeService;

@Controller
public class EmpController {
	
	@Autowired
	EmployeeeService employeeService;
	
	@RequestMapping(value="/emp/{ids}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids")String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			
			employeeService.deleteBatch(del_ids);
		}else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		
		return Msg.success();
	}
	
	/**
	 * 获取员工列表
	 * @param pageNum
	 * @return
	 */
	@RequestMapping("/empList")
	@ResponseBody
	public Msg getAllWithJson(@RequestParam(value="pageNum", defaultValue ="1") Integer pageNum) {
		PageHelper.startPage(pageNum, 6);//6为每页显示个数, 这个既然还有顺序，必须的放在要分页的对象的前面。
		List<Employeee> employees = employeeService.getAllEmps();
		PageInfo<Employeee> page = new PageInfo<Employeee>(employees, 5);//5为连续显示的页码数
		
		return Msg.success().add("pageInfo", page);
	}
	
	/**
	 * 添加员工
	 * @param emp
	 * @param result
	 * @return
	 */
	@RequestMapping(value="/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employeee emp, BindingResult result) {
		if(result.hasErrors()) {
			Map<String, Object> map = new HashMap<>();
			List<FieldError> error = result.getFieldErrors();
			for (FieldError fieldError : error) {
				System.out.println("字段：" + fieldError.getField());
				System.out.println("信息：" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("ErrorFields", map);
		}
		employeeService.saveEmp(emp);
		return Msg.success();
	}
	
	/**
	 * 更新员工
	 * @param emp
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employeee emp) {
		System.out.println(emp);
		employeeService.updateEmp(emp);
		return Msg.success();
	}
	
	
	/**
	 * 获取单个员工信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employeee employee = employeeService.getEmp(id);
		
		return Msg.success().add("emp", employee);
	}
	
	/**
	 * 对员工姓名进行校验
	 * @param empName
	 * @return
	 */
	@RequestMapping(value="/check")
	@ResponseBody
	public Msg checkEmpName(String empName) {
		String re = "(^[a-zA-Z0-9]{6,16}$)|(^[\u4E00-\u9FA5]{2,8}$)";
		if(!empName.matches(re)) {
			return Msg.fail().add("vd_b", "用户名必须为6-16位的英文或2-3位的中文233333");
		}
		
		Boolean b = employeeService.checkEmpName(empName);
		if(b) {
			return Msg.success().add("vd_b", "用户名可用");
		}else {
			return Msg.fail().add("vd_b", "用户名不可用");
		}
	}
	
//	@RequestMapping("/empList")
	public String getAllEmps(@RequestParam(value="pageNum", defaultValue ="1") Integer pageNum, Model model) {
		PageHelper.startPage(pageNum, 6);//6为每页显示个数, 这个既然还有顺序，必须的放在要分页的对象的前面。
		List<Employeee> employees = employeeService.getAllEmps();
		PageInfo<Employeee> page = new PageInfo<Employeee>(employees, 5);//5为连续显示的页码数
		model.addAttribute("pageInfo", page);
		
		return "list";
	}

}
