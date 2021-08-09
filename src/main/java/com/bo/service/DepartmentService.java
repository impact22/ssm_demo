package com.bo.service;

import com.bo.dao.DepartmentMapper;
import com.bo.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Bo
 * @version 1.0
 * @date 2021/8/4 22:54
 */
@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getDepartments(){
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}
