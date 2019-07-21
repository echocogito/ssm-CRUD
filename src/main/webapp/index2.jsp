<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
<link
	href="${app_path }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">

</head>
<body>
	<div class="modal fade" id="editEmp" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改员工</h4>
				</div>
				<div class="modal-body">
				<form class="form-horizontal">
					<div class="form-group">
						<label for="empName_edit" class="col-sm-2 control-label">empName</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="empName_edit"></p>
						</div>
					</div>
					<div class="form-group">
						<label for="gender_edit" class="col-sm-2 control-label">gender</label>
						<div class="col-sm-10">
							<label class="radio-inline"> <input type="radio"
								name="gender" id="gender1_edit" value="M" checked="checked">
								男
							</label> <label class="radio-inline"> <input type="radio"
								name="gender" id="gender2_edit" value="F"> 女
							</label>
						</div>
					</div>

					<div class="form-group">
						<label for="email_edit" class="col-sm-2 control-label">email</label>
						<div class="col-sm-10">
							<input type="email" class="form-control" id="email_edit"
								name="email" placeholder="westworld@gamil.com"> <span
								class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="department_edit" class="col-sm-2 control-label">department</label>
						<div class="col-sm-5">
							<select class="form-control" name="dId">
							</select>
						</div>
					</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="update_emp">更新</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Modal -->
	<div class="modal fade" id="addEmp" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Add Emp</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="empName_add"
									name="empName" placeholder="empName"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="gender_add" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add" value="M" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add" value="F"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label for="email_add" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="email_add"
									name="email" placeholder="westworld@gamil.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="department_add" class="col-sm-2 control-label">department</label>
							<div class="col-sm-5">
								<select class="form-control" name="dId" id="show_dept">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="save_emp">保存</button>
				</div>
			</div>
		</div>
	</div>


	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>员工管理系统（CRUD）</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="add_emp_btn">新增</button>
				<button class="btn btn-danger" id="delete_all">删除</button>
				<button class="ibtn">测试Ajax</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emp-table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all">
							</th>
							<th>#</th>
							<th>Name</th>
							<th>Gender</th>
							<th>Email</th>
							<th>Department</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6" id="page-info"></div>
			<div class="col-md-6" id="page-nav"></div>
		</div>
	</div>

	<script src="${app_path }/static/js/jquery1.12.4.min.js"></script>
	<script
		src="${app_path }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		var total_pages;
		var current_page;
		$(function() {
			to_page(1)
		});

		/* 异步请求员工数据 */
		function to_page(n) {
			$.ajax({
				url : "${app_path }/empList",
				type : "get",
				data : "pageNum=" + n,
				success : function(result) {
					table_data(result);
					page_info(result);
					page_nav(result)
				},
				error : function(err) {
					console.log(err);
				},
			});
		}

		/* 向页面添加员工表格详细 */
		function table_data(result) {
			$("#emp-table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,
					function(index, emp) {
						var checkBox = $("<td><input type='checkbox' class='check_item'></td>");
						var empId = $("<td></td>").append(emp.empId);
						var empName = $("<td></td>").append(emp.empName);
						var gender = $("<td></td>").append(
								emp.gender == "M" ? "男" : "女");
						var email = $("<td></td>").append(emp.email);
						var department = $("<td></td>").append(
								emp.department.deptName);
						var btn1 = $("<button></button>").addClass(
								"btn btn-primary btn-sm edit_btn").append(
								$("<span></span>").addClass(
										"glyphicon glyphicon-pencil").append(
										" 编辑"));
						btn1.attr("edit_emp_id", emp.empId);

						var btn2 = $("<button></button>").addClass(
								"btn btn-danger btn-sm delete_btn").append(
								$("<span></span>").addClass(
										"glyphicon glyphicon-trash").append(
										" 删除"));
						btn2.attr("delete_emp_id", emp.empId);
						
						var btns = $("<td></td").append(btn1).append(" ")
								.append(btn2);
						$("<tr></tr>").append(checkBox).append(empId).append(empName).append(
								gender).append(email).append(department)
								.append(btns).appendTo("#emp-table tbody");
					});
		}

		/* 向页面添加数据信息 */
		function page_info(result) {
			$("#page-info").empty();
			var method = result.extend.pageInfo;
			$("<p></P>").append(
					"当前第" + method.pageNum + "页，共" + method.pages + "页，"
							+ method.total + "条数据").appendTo("#page-info");
			total_pages = method.total;
		}

		/* 向页面添加分页导航 */
		function page_nav(result) {
			$("#page-nav").empty();
			var method = result.extend.pageInfo;
			current_page = method.pageNum;
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPage = $("<li></li>").append($("<a></a>").append("首页"));
			var prePage = $("<li></li>").append(
					$("<a></a>").append($("<span></span").append("&laquo;")));
			if (method.hasPreviousPage == false) {
				firstPage.addClass("disabled");
				prePage.addClass("disabled");
			} else {
				firstPage.click(function() {
					to_page(1)
				});
				prePage.click(function() {
					to_page(method.pageNum - 1)
				});
			}

			ul.append(firstPage).append(prePage);
			$.each(method.navigatepageNums, function(index, i) {
				var li = $("<li></li>").append($("<a></a>").append(i));
				if (method.pageNum == i) {
					li.addClass("active");
				}
				li.click(function() {
					to_page(i)
				})
				ul.append(li);
			});

			var nextPage = $("<li></li>").append(
					$("<a></a>").append($("<span></span").append("&raquo;")));
			var lastPage = $("<li></li>").append($("<a></a>").append("末页"));
			if (method.hasNextPage == false) {
				nextPage.addClass("disabled");
				lastPage.addClass("disabled");
			} else {
				nextPage.click(function() {
					to_page(method.pageNum + 1)
				});
				lastPage.click(function() {
					to_page(method.pages)
				});
			}
			ul.append(nextPage).append(lastPage);
			$("#page-nav").append(ul);
		}

		$("#add_emp_btn").click(function() {
			getDept("#show_dept");
			$('#addEmp').modal({
				backdrop : "static",
			});
		})

		/* 获取部门，用于保存员工 */
		function getDept(ele) {
			$(ele).empty();
			$.ajax({
				url : "${app_path}/deptList",
				type : "get",
				success : function(result) {
					$.each(result.extend.depts, function(index, dept) {
						$(ele).append(
								$("<option></option>").append(dept.deptName)
										.attr("value", dept.deptId));
					});
				},
				error : function(err) {
					console.log(err);
				},
			});
		}

		/* 数据校验信息 */
		function show_validate_msg(ele, status, msg) {
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		/* 数据校验 */
		function validate_add_form() {
			var empName = $("#empName_add").val();
			var reName = /(^[a-zA-Z0-9]{6,16}$)|(^[\u4E00-\u9FA5]{2,8}$)/;
			if (reName.test(empName)) {
				show_validate_msg("#empName_add", "success", "");
			} else {
				show_validate_msg("#empName_add", "error",
						"用户名必须为6-16位的英文或2-3位的中文");
				return false;
			}

			var email = $("#email_add").val();
			var reEmail = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
			if (reEmail.test(email)) {
				show_validate_msg("#email_add", "success", "");
			} else {
				show_validate_msg("#email_add", "error", "邮箱格式不正确");
				return false;
			}
			return true;
		}

		/* 校验用户名是否存在 */
		$("#empName_add").change(
				function() {
					var empName = this.value;
					$.ajax({
						url : "${app_path}/check",
						data : "empName=" + empName,
						type : "get",
						success : function(result) {
							if (result.code == 100) {
								show_validate_msg("#empName_add", "success",
										result.extend.vd_b);
								$("#save_emp").attr("ajax-vd", "success");
							} else {
								show_validate_msg("#empName_add", "error",
										result.extend.vd_b);
								$("#save_emp").attr("ajax-vd", "error");
							}
						}
					})
				})

		/* 清除表格样式 */
		function reset_form(ele) {
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
		}

		/* 保存员工 */
		$("#save_emp")
				.click(
						function() {
							if (!validate_add_form()) {
								return false;
							}
							if ($(this).attr("ajax-vd") == "error") {
								return false;
							}
							reset_form("#addEmp form");
							$
									.ajax({
										url : "${app_path}/emp",
										type : "post",
										data : $("#addEmp form").serialize(),
										success : function(result) {
											/* alert(result.msg); */
											if (result.code == 100) {
												$("#addEmp").modal("hide");
												to_page(total_pages);
											} else {
												if (undefined != result.extend.ErrorFields.email) {
													show_validate_msg(
															"#email_add",
															"error",
															result.extend.ErrorFields.email);
												}
												if (undefined != result.extend.ErrorField.empName) {
													show_validate_msg(
															"#empName_add",
															"error",
															result.extend.ErrorField.empName);
												}
											}

										},
										error : function(err) {
											console.log(err);
										},
									});
						})

		/* 编辑员工 */
		$(document).on("click", ".edit_btn", function() {
			getEmp($(this).attr("edit_emp_id"));

			getDept("#editEmp select");
			$("#update_emp").attr("edit_emp_id", $(this).attr("edit_emp_id"));
			$("#editEmp").modal({
				backdrop : "static"
			});
		})

		
		/* 获取要修改员工的信息 */
		function getEmp(id) {
			$.ajax({
				url : "${app_path}/emp/" + id,
				type : "get",
				success : function(result) {
					var emp = result.extend.emp;
					$("#empName_edit").text(emp.empName);
					$("#email_edit").val(emp.email);
					$("#editEmp input[name=gender]").val([emp.gender]);
					$("#editEmp select").val([emp.dId]);
				}
			})
		}
		
		/* 更新员工 */
		$("#update_emp").click(function(){
			var email = $("#email_edit").val();
			var reEmail = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
			if (reEmail.test(email)) {
				show_validate_msg("#email_edit", "success", "");
			} else {
				show_validate_msg("#email_edit", "error", "邮箱格式不正确");
				return false;
			}
			
			$.ajax({
				url:"${app_path}/emp/"+$(this).attr("edit_emp_id"),
				type:"put",
				data:$("#editEmp form").serialize(),
				success:function(result){
					if (result.code == 100) {
						$("#editEmp").modal("hide");
						to_page(current_page);
					} else {
						if (undefined != result.extend.ErrorFields.email) {
							show_validate_msg("#email_add","error", result.extend.ErrorFields.email);
						}
					}
				}
			})
		})
		
		/* 删除单个员工 */
		$(document).on("click", ".delete_btn", function() {
			var delName = $(this).parents("tr").find("td:eq(1)").text();
			
			if(confirm("确认删除【"+delName+"】吗？")){
				$.ajax({
					url:"${app_path}/emp/"+$(this).attr("delete_emp_id"),
					type:"delete",
					success:function(result){
						alert(result.msg);
						to_page(current_page);
					}
				})
			}
		})
		
		/* 给删除按钮添加属性 */
		$("#check_all").click(function(){
			$(".check_item").prop("checked", $(this).prop("checked"));
		})
		
		/* 给删除按钮添加属性 */
		$(document).on("click", ".check_item", function() {
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked", flag);
		})
		
		/* 删除所选择的所有员工 */
		$("#delete_all").click(function(){
			var del_names = "";
			var del_ids = "";
			$.each($(".check_item:checked"), function(){
				del_names += $(this).parents("tr").find("td:eq(2)").text()+ ",";
				del_ids += $(this).parents("tr").find("td:eq(1)").text()+ "-";
			});
			del_names = del_names.substring(0, del_names.length-1);
			del_ids = del_ids.substring(0, del_ids.length-1);
			console.log(del_ids);
			if(confirm("确认删除【"+del_names+"】吗？")){
				$.ajax({
					url:"${app_path}/emp/"+del_ids,
					type:"delete",
					success:function(result){
						alert(result.msg);
						to_page(current_page);
					}
				})
			}
		})
	</script>
</body>
</html>