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
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>Name</th>
						<th>Gender</th>
						<th>Email</th>
						<th>Department</th>
						<th>Action</th>
					</tr>
					<c:forEach var="emp" items="${pageInfo.list }">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender=="M"?"男":"女" }</td>
							<td>${emp.email }</td>
							<td>${emp.department.deptName }</td>
							<td>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true">
										修改</span>
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true">
										删除</span>
								</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<p>当前第${pageInfo.pageNum }页，共${pageInfo.pages }页，${pageInfo.total }条数据</p>
			</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					<ul class="pagination">
							<li><a href="empList">首页</a></li>

						<c:if test="${pageInfo.hasPreviousPage }">
							<li><a href="empList?pageNum=${pageInfo.pageNum-1 }" aria-label="上一页"> <span
									aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						
						
						<c:forEach var="i" items="${pageInfo.navigatepageNums }">
							<c:if test="${i == pageInfo.pageNum }">
								<li class="active"><a href="empList?pageNum=${i }">${i }</a></li>
							</c:if>
							<c:if test="${i != pageInfo.pageNum }">
								<li><a href="empList?pageNum=${i }">${i }</a></li>
							</c:if>
						</c:forEach>
						

						<c:if test="${pageInfo.hasNextPage }">
							<li><a href="empList?pageNum=${pageInfo.pageNum+1 }" aria-label="下一页"> <span
									aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
	
							<li><a href="empList?pageNum=${pageInfo.pages }">末页</a></li>					
					</ul>
				</nav>
			</div>
		</div>
	</div>

	<script src="${app_path }/static/js/jquery1.12.4.min.js"></script>
	<script
		src="${app_path }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>