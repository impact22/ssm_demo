package com.bo.controller;

import com.bo.pojo.Department;
import com.bo.pojo.Msg;
import com.bo.service.DepartmentService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Bo
 * @version 1.0
 * @date 2021/8/4 22:52
 */
@Controller
public class departmentController {
    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepartments(){
        List<Department> departments = departmentService.getDepartments();
        return Msg.success().add("depts",departments);
    }
}
