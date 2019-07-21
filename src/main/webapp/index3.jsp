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
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>员工管理系统（CRUD）</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
				<button class="ibtn">测试Ajax</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emp-table">
					<thead>
						<tr>
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
			<div class="col-md-6" id="page-info">
			</div>
			<div class="col-md-6" id="page-nav">
			</div>
		</div>
	</div>

	<script src="${app_path }/static/js/jquery1.12.4.min.js"></script>
	<script src="${app_path }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<script src="${app_path }/static/js/empList.js" type="text/javascript"></script>

</body>
</html>