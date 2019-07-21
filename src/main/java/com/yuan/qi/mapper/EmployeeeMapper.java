package com.yuan.qi.mapper;

import com.yuan.qi.bean.Employeee;
import com.yuan.qi.bean.EmployeeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeeMapper {
    long countByExample(EmployeeeExample example);

    int deleteByExample(EmployeeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employeee record);

    int insertSelective(Employeee record);

    List<Employeee> selectByExample(EmployeeeExample example);

    Employeee selectByPrimaryKey(Integer empId);
    
    List<Employeee> selectByExampleWithDept(EmployeeeExample example);

    Employeee selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Employeee record, @Param("example") EmployeeeExample example);

    int updateByExample(@Param("record") Employeee record, @Param("example") EmployeeeExample example);

    int updateByPrimaryKeySelective(Employeee record);

    int updateByPrimaryKey(Employeee record);
}