package com.bo.controller;

import com.bo.pojo.Employee;
import com.bo.pojo.Msg;
import com.bo.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @author Bo
 * @version 1.0
 * @date 2021/8/3 17:38
 * 这个其实应该叫employeeController的--------------------
 */
@Controller
public class listController {

    @Autowired
    EmployeeService employeeService;

//    @RequestMapping(value = "/list")
    public String toList(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        //使用分页插件pageHelper分页,输入参数即可
        PageHelper.startPage(pn,5);
        List<Employee> list = employeeService.getAll();
        //pageInfo详细信息，可以获得连续6个分页1 2 3 [4] 5 6此类
        PageInfo<Employee> page = new PageInfo<>(list,6);
        model.addAttribute("pageInfo",page);
        return "list";
    }

    @RequestMapping("/list")
    @ResponseBody
    public Msg info(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        PageHelper.startPage(pn,5);
        List<Employee> list = employeeService.getAll();
        PageInfo<Employee> PageInfo = new PageInfo<>(list);
        model.addAttribute("pageInfo",PageInfo);
//        System.out.println(PageInfo);
        return Msg.success().add("pageInfo",PageInfo);
    }

    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    //自动封装employee,@Valid判断是否有校验错误，BindingResult收集这些错误
    public Msg addSave(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            List<FieldError> fieldErrors = result.getFieldErrors();
            HashMap<String, Object> map = new HashMap<>();
            //遍历同时将错误属性，错误信息放入map中
            for (FieldError fieldError : fieldErrors){
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("FieldErrors",map);
        }else {
            employeeService.empSave(employee);
            return Msg.success();
        }
    }

    /**
     * 检验名字是否重复
     */
    @RequestMapping("/checkName")
    @ResponseBody
    public Msg checkName(@RequestParam(value = "empName") String empName){
        //前端校验，先前端后后端
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }
        //后端查重校验
        boolean b = employeeService.checkName(empName);
        if (b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }
//-------------------------------------下面为修改员工操作了------------------------------------
    /**
     * 1.查询员工信息
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
       Employee employee = employeeService.getEmp(id);
        System.out.println(employee);
       return Msg.success().add("emp",employee);
    }
    /**
     * 2.更新员工的信息
     * 这里参数为{empId}，是为了将参数empId的值封装进
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg update(Employee employee){
        System.out.println(employee);
        employeeService.empUpdate(employee);
       return Msg.success();
    }
   //---------------------------------删除员工信息------------------------------------
    /**
     * 删除单个员工,该方法被替代了
     */
//    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
//    @ResponseBody
//    public Msg Emp(@PathVariable(value = "id") Integer id){
//        employeeService.empDelete(id);
//        return Msg.success();
//    }
    /**
     * 删除多个员工或一个
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deletetAll(@PathVariable("ids") String ids){
        //批量删除
        if(ids.contains("-")){
            String[] str_ids = ids.split("-");
            List<Integer> del_ids = new ArrayList<Integer>();

            //组装id的集合
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

}
