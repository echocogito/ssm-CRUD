function table_data(result) {
	alert("sdds");
	$("#emp-table tbody").empty();
	var emps = result.extend.pageInfo.list;
	$.each(emps, function(index, emp) {
		var empId = $("<td></td>").append(emp.empId);
		var empName = $("<td></td>").append(emp.empName);
		var gender = $("<td></td>").append(emp.gender == "M" ? "男" : "女");
		var email = $("<td></td>").append(emp.email);
		var department = $("<td></td>").append(emp.department.deptName);
		var btn1 = $("<button></button>").addClass("btn btn-primary btn-sm")
				.append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil").append(" 编辑"));
		var btn2 = $("<button></button>").addClass("btn btn-danger btn-sm")
				.append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash").append(
										" 删除"));
		var btns = $("<td></td").append(btn1).append(" ").append(btn2);
		$("<tr></tr>").append(empId).append(empName).append(gender).append(
				email).append(department).append(btns).appendTo(
				"#emp-table tbody");
	});
}

function page_info(result) {
	$("#page-info").empty();
	var method = result.extend.pageInfo;
	$("<p></P>").append(
			"当前第" + method.pageNum + "页，共" + method.pages + "页，" + method.total
					+ "条数据").appendTo("#page-info");
}

function page_nav(result) {
	$("#page-nav").empty();
	var method = result.extend.pageInfo;
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


$(function() {
	to_page(1);
})
function to_page(n) {
	$.ajax({
		url : "${app_path }/empList",
		type : "get",
		dataType:'json',
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
