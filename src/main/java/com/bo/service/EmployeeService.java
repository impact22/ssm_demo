package com.bo.service;

import com.bo.dao.EmployeeMapper;
import com.bo.pojo.Employee;
import com.bo.pojo.EmployeeExample;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Bo
 * @version 1.0
 * @date 2021/8/3 17:42
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;


    public List<Employee>  getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void empSave(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public boolean checkName(String empName) {
        //example来拼接sql设置筛选条件,不然就直接查全部了
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        int count = employeeMapper.countByExample(example);
        return count == 0;
    }

    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void empUpdate(Employee employee) {
        int i = employeeMapper.updateByPrimaryKeySelective(employee);
        return;
    }

    public void empDelete(Integer id) {
        int i = employeeMapper.deleteByPrimaryKey(id);
        return;
    }

    public void deleteBatch(List<Integer> del_ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from xxx where emp_id in(1,2,3)
        criteria.andEmpIdIn(del_ids);
        employeeMapper.deleteByExample(example);
    }

    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }
}
