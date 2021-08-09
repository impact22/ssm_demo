<%--
  Created by IntelliJ IDEA.
  User: MI
  Date: 2021/8/3
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%--    <base href="http://localhost:3306/SSM">--%>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript"
            src="http://localhost:8080/ssm/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="http://localhost:8080/ssm/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="http://localhost:8080/ssm/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
<!-- 添加模态框（Modal）------------------------------------------- -->
<div class="modal fade" id="addModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工名字</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName_add_input" name="empName" placeholder="请输入名字">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email_add_input" name="email" placeholder="请输入邮箱">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dpId" id="depts_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="add_save_btn">提交</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- ----------------------------修改信息模态框（Modal）------------------------------------------- --------->
<div class="modal fade" id="updateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="update">修改员工信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工名字</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email_update_input" name="email" placeholder="请输入邮箱">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="boy" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="girl"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dpId" id="depts_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="update_save_btn">更新修改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<!-- ------------------------------搭建显示页面-------------------- -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>

    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <!-- 显示分页信息 -->
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_word_info"></div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>

</div>

<script type="text/javascript">
    //定义一个变量记录当前页面后面好用
    var currentPage;
    $(function (){
        to_page(1);
    });
    //去第几页
    function to_page(pn){
            $.ajax({
                url:"http://localhost:8080/ssm/list",
                data:"pn=" + pn,
                type:"get",
                success:function (result){
                    //解析并展示员工数据
                    console.log(result);
                    build_emp_table(result);
                    //分页信息
                    page_info(result);
                    //分页条
                    page_nav(result);
                }
            });
        }

        //----------分页信息构建------------------
        function build_emp_table(result){
        //清空table表
            $("#emps_table tbody").empty();
            //获取页面信息
            var list = result.extend.pageInfo.list;
            //遍历信息,index索引，item为单个
            $.each(list,function(index,item){
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=='boy'?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.dpName);

                //编辑按钮
                var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
                //为编辑按钮添加一个自定义的属性，来表示当前员工id
                editBtn.attr("edit-id", item.empId);
                //删除按钮
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
                //为删除按钮添加一个自定义的属性，来表示当前员工id
                delBtn.attr("del-id", item.empId);

                //把两个按钮放到一个单元格中，并且按钮之间留点空隙
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //append方法执行完成以后还是会返回原来的元素，所以可以一直.append添加元素，
                //将上面的td添加到同一个tr里

                $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody")
            })

        }

        //分页信息函数----------------
        function page_info(result){
         $("#page_word_info").empty();
            var page = result.extend.pageInfo;
            $("#page_word_info").append("当前"+ page.pageNum+" 页","总" +page.pages +"页","总"+ page.total +"条记录");
            currentPage = page.pageNum;
        }
        function build_page_info(result){
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
                result.extend.pageInfo.pages+"页,总"+
                result.extend.pageInfo.total+"条记录");
            totalRecord = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }
        //解析显示分页条，点击分页要能去下一页....--------------
        function page_nav(result){
            //page_nav_area，清除多余的
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>").addClass("pagination");

            //构建元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if(result.extend.pageInfo.hasPreviousPage == false){
                //设置为不可点击
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加点击翻页的事件
                firstPageLi.click(function(){
                    to_page(1);
                });
                prePageLi.click(function(){
                    to_page(result.extend.pageInfo.pageNum -1);
                });
            }

            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if(result.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function(){
                    to_page(result.extend.pageInfo.pageNum +1);
                });
                lastPageLi.click(function(){
                    to_page(result.extend.pageInfo.pages);
                });
            }
            //添加首页和前一页 的提示
            ul.append(firstPageLi).append(prePageLi);
            //1,2，3遍历给ul中添加页码提示
            $.each(result.extend.pageInfo.navigatepageNums,function(index,item){

                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if(result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                //单击跳转
                numLi.click(function(){
                    to_page(item);
                });
                ul.append(numLi);
            });
            //添加下一页和末页 的提示
            ul.append(nextPageLi).append(lastPageLi);

            //把ul加入到nav
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }
    //----------------------模态框调用,启动模态框------------------------------------------------
        //模态框调用main----
    $("#emp_add_model").click(function (){
        //表单重置，清空表单
        reset_form("#addModel form");
        //获得部门信息
        getDepts("#depts_add_select");

        //模态框启动
        $("#addModel").modal({
            backdrop:"static"
        });
    })
    //清空表单样式及内容
    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
        //在模态框启动前获取部门信息并放入下拉框select中
        function getDepts(ele){
            //先清除部门信息
            $(ele).empty();
            $.ajax({
                url:"http://localhost:8080/ssm/depts",
                type:"get",
                success:function (result){
                    console.log(result);
                    $.each(result.extend.depts,function (){
                        //下拉列表添加部门
                        $(ele).append($("<option></option>").append(this.dpName).attr("value",this.dpId));
                    });
                }
            });
        }
      //--------------------校验信息，检查信息是否对的函数-------------------------------\

    function testForm(){
        //检验姓名：
        var empName = $("#empName_add_input").val();
        var empNameTest = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if (!empNameTest.test(empName)){
            form_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        }else{
            form_msg("#empName_add_input", "success", "");
        };
        //检验邮箱
        var email = $("#email_add_input").val();
        var emailTest = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!emailTest.test(email)){
            form_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        }else{
            form_msg("#email_add_input", "success", "");
        }
        return true;
    }
    //表单错误提示信息
    function form_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //检验员工姓名是否重复----------
    $("#empName_add_input").change(function (){
        checkName();
    })
    function checkName(){
        var empName = $("#empName_add_input").val();
        $.ajax({
            url:"http://localhost:8080/ssm/checkName",
            type:"get",
            data:"empName=" + empName,
            success:function (result){
                if (result.code == 100) {
                    form_msg("#empName_add_input", "success", "用户名可用");
                    //用户名可用设置属性为成功，可以提交
                    $("#add_save_btn").attr("ajax-va","success");
                }else{
                    form_msg("#empName_add_input", "error", result.extend.va_msg);
                    //用户名可用设置属性为失败，不可以提交
                    $("#add_save_btn").attr("ajax-va","error");
                }
            }
        })
    }

    //--------------------------添加员工main函数XXXXXX，同时调用检验的函数-------------------------------------
    $("#add_save_btn").click(function (){
        //、判断之前的ajax用户名校验是否成功。如果成功。
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        //添加时先前端校验
        if(!testForm()){
            return false;
        }
        // alert($("#addModel form").serialize()) 可以序列化表单获得表单那信息
        $.ajax({
            url:"http://localhost:8080/ssm/list",
            type:"POST",
            data:$("#addModel form").serialize(),
            success:function (result){
                //jr303后端校验
                if (result.code == 100){
                    //提交后关闭模板框
                    $("#addModel").modal('hide')
                    //关闭后页面去到最后一页
                    to_page(99999999);
                }else{
                    //显示失败信息
                    //console.log(result);
                    //有哪个字段的错误信息就显示哪个字段的；
                    if (undefined != result.extend.FieldErrors.empName){
                        form_msg("#empName_add_input","error",result.extend.FieldErrors.empName);
                    }
                    if (undefined != result.extend.FieldErrors.email){
                        form_msg("#email_add_input","error",result.extend.FieldErrors.email);
                    }
                }
            }
        })
    })
    //---------------------------------------------------修改员工main函数XXXXXX，-----------------------------------------
    $(document).on("click",".edit_btn",function (){
        //1、查出部门信息，并显示部门列表
        //获得部门信息
        getDepts("#depts_update_select");

        //模态框启动
        $("#updateModel").modal({
            backdrop:"static"
        });
        //2、查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        //3、把员工的id传递给模态框的更新按钮
        $("#update_save_btn").attr("edit-id",$(this).attr("edit-id"));

        // $("#empUpdateModal").modal({
        //     backdrop:"static"
        // });
    });
    //发送根据id查询员工ajax请求
    function getEmp(id){
        $.ajax({
            url:"http://localhost:8080/SSM/emp/" + id,
            type:"GET",
            success:function (result){
                var emp = result.extend.emp;
                $("#empName_update_static").text(emp.empName);
                $("#email_update_input").val(emp.email);
                $("#updateModel input[name=gender]").val([emp.gender]);
                $("#updateModel select").val([emp.dpId]);
            }
        });
    }
    //修改完后对员工进行更新保存
    $("#update_save_btn").click(function (){
        $.ajax({
            url:"http://localhost:8080/ssm/emp/" + $(this).attr("edit-id"),
            type:"PUT",
            data:$("#updateModel form").serialize(),
            success:function (result){
                //1.关闭模态框
                $("#updateModel").modal("hide");
                //回到当前页
                to_page(currentPage);
            }
        });
    })

    //---------------------------删除员工了-------------------------------------------------
    //删除单个员工
    $(document).on("click",".delete_btn",function (){
        //1.弹出对话框判断是否要删除
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if(confirm("你确定要删除"+ empName +"吗？")){
            $.ajax({
                url:"http://localhost:8080/ssm/emp/" + $(this).attr("del-id"),
                type:"DELETE",
                success:function (result){
                    //1.提示一下
                    alert(result.msg);
                    //回到当前页
                    to_page(currentPage);
                }
            });
        }
    })

    //全选框一选都选
    $("#check_all").click(function (){
        //attr获取checked是undefined;
        //我们这些dom原生的属性；attr获取自定义属性的值；
        //prop修改和读取dom原生属性的值
        var status = $(this).prop("checked");
        $(".check_item").prop("checked",status);
    });
    //多个合体判断是否全选
    $(document).on("click",".check_item",function (){
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    })

    //多个删除，将选中的都删除
    $("#emp_delete_all_btn").click(function (){
        var empNameStr = "";
        var idStr = "";
        $.each($(".check_item:checked"),function (){
            empNameStr+=$(this).parents("tr").find("td:eq(2)").text() + ",";
            idStr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        })
        empNameStr= empNameStr.substring(0,empNameStr.length - 1);
        idStr=idStr.substring(0,idStr.length-1);
        if (confirm("你确定要删除【"+empNameStr +"】吗？")){
            $.ajax({
                url:"http://localhost:8080/SSM/emp/"+idStr,
                type:"DELETE",
                success:function (result){
                    //响应
                    alert(result.msg);
                    //跳回页面
                    to_page(currentPage);
                }
            })
        }
    })




</script>
</body>
</html>
