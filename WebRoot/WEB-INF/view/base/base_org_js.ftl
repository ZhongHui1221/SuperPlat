<script src="${request.contextPath}/static/framework/ligerui-lib/jquery/jquery-1.8.3.min.js"></script>
<script src="${request.contextPath}/static/framework/layer/layer.js"></script>
<script src="${request.contextPath}/static/js/respond.min.js"></script>
<#include "/base/lodop.ftl" />
<script>

	/* 全局变量 - BEGIN */
	// 获取当前选中页签的 tabid
	var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");

	// 获取当前页签对应的 iframe
	var $iframe = $(window.parent.document).find("iframe[id='" + tabid + "']");

	// 获取展示卡片详情的模态窗
	var $cardModal = $(window.parent.document).find("iframe[id='card_module']");

	// 打印控件对象
	var Lodop;
	/* 全局变量 - END */

	/* 算数相关 - BEGIN */
	// 加法函数
	function accAdd(arg1, arg2) {
		var t1 = 0, t2 = 0, m;
		try {
			t1 = arg1.toString().split(".")[1].length;
		} catch (e) {
			t1 = 0;
		}
		try {
			t2 = arg2.toString().split(".")[1].length;
		} catch (e) {
			t2 = 0;
		}
		with (Math) {
			m = Math.pow(10, Math.max(t1, t2));
			return ((arg1 * m + arg2 * m) / m).toFixed(2);
		}
	}

	// 减法函数
	function accSubtr(arg1, arg2) {
		var t1 = 0, t2 = 0, m, n;
		try {
			t1 = arg1.toString().split(".")[1].length;
		} catch (e) {
			t1 = 0;
		}
		try {
			t2 = arg2.toString().split(".")[1].length;
		} catch (e) {
			t2 = 0;
		}
		with (Math) {
			// 动态控制精度长度
			n = Math.max(t1, t2);
			m = Math.pow(10, n);
			return ((arg1 * m - arg2 * m) / m).toFixed(2);
		}
	}

	// 乘法函数
	function accMul(arg1, arg2) {
		var t1 = 0, t2 = 0, r1, r2;
		try {
			t1 = arg1.toString().split(".")[1].length;
		} catch (e) {
			t1 = 0;
		}
		try {
			t2 = arg2.toString().split(".")[1].length;
		} catch (e) {
			t2 = 0;
		}
		with (Math) {
			r1 = Number(arg1.toString().replace(".", ""));
			r2 = Number(arg2.toString().replace(".", ""));
			return (r1 * r2) / pow(10, t2 + t1);
		}
	}

	// 除法函数
	function accDiv(arg1, arg2) {
		var t1 = 0, t2 = 0, r1, r2, n;
		try {
			t1 = arg1.toString().split(".")[1].length;
		} catch (e) {
			t1 = 0;
		}
		try {
			t2 = arg2.toString().split(".")[1].length;
		} catch (e) {
			t2 = 0;
		}
		with (Math) {
			r1 = Number(arg1.toString().replace(".", ""));
			r2 = Number(arg2.toString().replace(".", ""));
			n = Math.max(t1, t2);
			return (r1 / r2) * pow(10, t2 - t1);
		}
	}

	// 为 String 类型的对象添加 add 方法
	String.prototype.add = function(arg) {
		return accAdd(arg, this);
	}

	// 为 String 类型的对象添加 subtr 方法
	String.prototype.subtr = function(arg) {
		return accSubtr(this, arg);
	}

	// 为 String 类型的对象添加 mul 方法
	String.prototype.mul = function(arg) {
		return accMul(arg, this);
	}

	// 为 String 类型的对象添加 div 方法
	String.prototype.div = function(arg) {
		return accDiv(this, arg);
	}
	/* 算数相关 - END */

	/* 验证相关 - BEGIN */
	// 通用的表单验证方法
	// index: 被验证的 form 元素的索引值 (从 0 开始计数)
	// name: 被验证的表单项的 name 值
	// reg: 验证规则
	// str: 验证未通过时要输出的错误信息
	function validate(index, name, reg, str) {
		// 根据 name 获取到对应的元素并将其封装为 jQuery 对象
		var $obj = $("form:eq(" + index + ") [name='" + name + "']");
		var objVal = $obj.val();
		// 如果内容不符合规则
		if (!reg.test(objVal)) {
			if($(".login_tips").css("display") == "none"){
				var width = str.length * 14 + 20;
				$(".login_tips").html(str).css("margin-left", - width / 2).fadeIn(200).delay(1500).fadeOut(400);
				$obj.select();
			}
			// 将验证未通过的表单项设置为选中状态
			return false;
		}
		return true;
	}

	// 获取当前日期
	// sth：1 = 今天，2 = 本月，3 = 本年
	function getNowFormatDate(sth) {
		var date = new Date();
		var seperator1 = "-";
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var strDate = date.getDate();
		if (month >= 1 && month <= 9) {
			month = "0" + month;
		}
		if (strDate >= 0 && strDate <= 9) {
			strDate = "0" + strDate;
		}
		if (sth == 1) {
			var currentdate = year + seperator1 + month + seperator1 + strDate;
		} else if (sth == 2) {
			var curmonthmays = new Date(date.getFullYear(), (date.getMonth() + 1), 0).getDate();
			var currentdate = {};
			currentdate.begin = year + seperator1 + month + seperator1 + "01";
			currentdate.end = year + seperator1 + month + seperator1 + curmonthmays;
		} else if (sth == 3) {
			var currentdate = {};
			currentdate.begin = year + seperator1 + "01" + seperator1 + "01";
			currentdate.end = year + seperator1 + "12" + seperator1 + "31";
		}
		return currentdate;
	}

	// 日期比较
	function compareDate(date1, date2) {
		var odate1 = new Date(date1.replace(/\-/g, "\/"));
		var odate2 = new Date(date2.replace(/\-/g, "\/"));
		if (odate1.getTime() > odate2.getTime()) {
			return false;
		} else {
			return true;
		}
	}
	/* 验证相关 - END */

	/* 打印相关 */
	// 前置函数
	function prePrint(strTaskName) {
		// 隐藏工具栏
		$(".toolbar_wapper").hide();
		// 获取控件对象
		Lodop = getLodop();
		// 打印初始化
		Lodop.PRINT_INIT(strTaskName);
	}

	// 后置函数
	function postPrint() {
		// 打印预览
		Lodop.PREVIEW();
		// 显示工具栏
		$(".toolbar_wapper").show();
	}

	// 超文本打印（普通模式）
	function printHTM(strTaskName) {
		prePrint(strTaskName);
		// 增加超文本打印项（普通模式），参数：上边距、左边距、宽度、高度、超文本内容
		Lodop.ADD_PRINT_HTM(10, 0, "100%", "100%", "<!DOCTYPE html>" + document.getElementsByTagName("html")[0].innerHTML);
		postPrint();
	}

	// 超文本打印（图形模式）
	function printHTML(strTaskName) {
		prePrint(strTaskName);
		// 增加超文本打印项（图形模式），参数：上边距、左边距、宽度、高度、超文本内容
		Lodop.ADD_PRINT_HTML(10, 0, "100%", "100%", "<!DOCTYPE html>" + document.getElementsByTagName("html")[0].innerHTML);
		postPrint();
	}
	/* 打印相关 - END */

	/* 页签相关 - BEGIN */
	// 表单提交方式新增页签
	function addTabByForm(condition) {
		var error = "缺失必要的属性：";
		if (condition.targetTabId == undefined) {
			error += "targetTabId、";
		}
		if (condition.targetTabTitle == undefined) {
			error += "targetTabTitle、";
		}
		if (condition.targetTabUrl == undefined) {
			error += "targetTabUrl、";
		}
		if (condition.method == undefined) {
			error += "method、";
		}
		if (condition.fromModel == undefined) {
			error += "fromModel、";
		}
		if (error != "缺失必要的属性：") {
			alert(error.substring(0, error.length - 1));
			return;
		}

		window.parent.f_addTab(condition.targetTabId, condition.targetTabTitle);
		// 获取当前选中页签的 tabid
		var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
		// 获取当前显示的 iframe
		var $div = $(window.parent.document).find("div[tabid='" + tabid + "']");
		// 每次创建元素前清空iframe容器内的内容
		$div.empty();
		var htmlStr = '<div class="l-tab-loading" style="display: block"></div>';
		htmlStr += '<iframe id="' + tabid + '" name="' + tabid + '" src="' + condition.targetTabUrl + '" frameborder="0"></iframe>';
		htmlStr += '<form id="' + tabid + '" action="' + condition.targetTabUrl + '" target="' + tabid + '" method="' + condition.method + '">';
		// 遍历 condition 的各项属性，并循环追加隐藏域
		for (var field in condition) {
			if ((field != "targetTabId") && (field != "targetTabTitle") && (field != "targetTabUrl") && (field != "method")) {
				htmlStr += '<input name="' + field + '" type="hidden" value="' + condition[field] + '" />';
			}
		}
		htmlStr += '</form>';
		$div.append(htmlStr);
		$(window.parent.document).find("form[id='" + tabid + "']").submit();
	}
	/* 页签相关 - END */

	/* 卡片修改相关 - BEGIN */
	// 将页面字段转换为字符串
	function fieldsToStr() {
		var strArr = new Array();
		$("input[disabled!='disabled'], select[disabled!='disabled'], textarea[disabled!='disabled']").each(function() {
			var fieldName = $(this).prop("name");
			var fieldValue = $(this).val();
			if (fieldName != "") {
				// 日期类型的字段使用特殊格式
				if ($(this).hasClass("card_datedit")) {
					strArr.push(fieldName + "=@START'" + fieldValue + "'@END");
				} else {
					strArr.push(fieldName + "='" + fieldValue + "'");
				}
			}
		});
		return strArr.join();
	}
	/* 卡片修改相关 - END */

	/* 日常类业务 - BEGIN */
	// 申请报修
	function applyForRepair() {
		var idArr = new Array();
		var count = 0;
		$("input[class='chk']:checked").each(function() {
			idArr[count] = $(this).val();
			count++;
		});

		if (count == 0) {
			layer.alert("请选择卡片", {icon : 7, title : "提示"});
			return false;
		}

		layer.confirm(
			"是否要申请报修选择的卡片（未登账的卡片将不会进入报修申请流程）？",
			{icon : 3, title : "提示"},
			function() {
				var loadid = layer.load(2);
				$.post(
					"${request.contextPath}/orgHome/applyForRepair",
					{"_method": "PUT", "checkedIdStr": idArr.join()},
					function(data) {
						layer.close(loadid);
						if (data == "SUCCESS") {
							$(".toobar_search .query_form").submit();
						} else {
							layer.alert(data, {title : "提示"});
						}
					}
				);
			}
		);
	}

	// 申请处置
	function applyForDeal() {
		var idArr = new Array();
		var count = 0;
		$("input[class='chk']:checked").each(function() {
			idArr[count] = $(this).val();
			count++;
		});

		if (count == 0) {
			layer.alert("请选择卡片", {icon : 7, title : "提示"});
			return false;
		}

		layer.confirm(
			"是否要申请处置？",
			{icon : 3, title : "提示"},
			function() {
				var loadid = layer.load(2);
				$.post(
					"${request.contextPath}/orgHome/applyForDeal",
					{"_method": "PUT", "checkedIdStr": idArr.join()},
					function(data) {
						layer.close(loadid);
						if (data == "SUCCESS") {
							$(".toobar_search .query_form").submit();
						} else {
							layer.alert(data, {title : "提示"});
						}
					}
				);
			}
		);
	}

	// 申请转移
	function applyForTransfer() {
		var idArr = new Array();
		var count = 0;
		$("input[class='chk']:checked").each(function() {
			idArr[count] = $(this).val();
			count++;
		});

		if (count == 0) {
			layer.alert("请选择卡片", {icon : 7, title : "提示"});
			return false;
		}

		layer.confirm(
			"是否要申请转移？",
			{icon : 3, title : "提示"},
			function() {
				var loadid = layer.load(2);
				$.post(
					"${request.contextPath}/orgHome/applyForTransfer",
					{"_method": "PUT", "checkedIdStr": idArr.join()},
					function(data) {
						layer.close(loadid);
						if (data == "SUCCESS") {
							$(".toobar_search .query_form").submit();
						} else {
							layer.alert(data, {title : "提示"});
						}
					}
				);
			}
		);
	}

	// 申请更正
	function applyForCorrect() {
		var idArr = new Array();
		var count = 0;
		$("input[class='chk']:checked").each(function() {
			idArr[count] = $(this).val();
			count++;
		});

		if (count == 0) {
			layer.alert("请选择卡片", {icon : 7, title : "提示"});
			return false;
		}

		layer.confirm(
			"是否要申请更正？",
			{icon : 3, title : "提示"},
			function() {
				var loadid = layer.load(2);
				$.post(
					"${request.contextPath}/orgHome/applyForCorrect",
					{"_method": "PUT", "checkedIdStr": idArr.join()},
					function(data) {
						layer.close(loadid);
						if (data == "SUCCESS") {
							$(".toobar_search .query_form").submit();
						} else {
							layer.alert(data, {title : "提示"});
						}
					}
				);
			}
		);
	}

	// 申请对外投资
	function applyForInvest() {
		var idArr = new Array();
		var count = 0;
		$("input[class='chk']:checked").each(function() {
			idArr[count] = $(this).val();
			count++;
		});

		if (count == 0) {
			layer.alert("请选择卡片", {icon : 7, title : "提示"});
			return false;
		}

		layer.confirm(
			"是否要申请对外投资？",
			{icon : 3, title : "提示"},
			function() {
				var loadid = layer.load(2);
				$.post(
					"${request.contextPath}/orgHome/applyForInvest",
					{"_method": "PUT", "checkedIdStr": idArr.join()},
					function(data) {
						layer.close(loadid);
						if (data == "SUCCESS") {
							$(".toobar_search .query_form").submit();
						} else {
							layer.alert(data, {title : "提示"});
						}
					}
				);
			}
		);
	}

	// 申请归还
	function applyForReturn() {
		var idArr = new Array();
		var count = 0;
		$("input[class='chk']:checked").each(function() {
			idArr[count] = $(this).val();
			count++;
		});

		if (count == 0) {
			layer.alert("请选择卡片", {icon : 7, title : "提示"});
			return false;
		}

		layer.confirm(
			"是否要申请归还？",
			{icon : 3, title : "提示"},
			function() {
				var loadid = layer.load(2);
				$.post(
					"${request.contextPath}/orgHome/applyForReturn",
					{"_method": "PUT", "checkedIdStr": idArr.join()},
					function(data) {
						layer.close(loadid);
						if (data == "SUCCESS") {
							$(".toobar_search .query_form").submit();
						} else {
							layer.alert(data, {title : "提示"});
						}
					}
				);
			}
		);
	}

	// 申请出租
	function applyForLease() {
		var idArr = new Array();
		var count = 0;
		$("input[class='chk']:checked").each(function() {
			idArr[count] = $(this).val();
			count++;
		});

		if (count == 0) {
			layer.alert("请选择卡片", {icon : 7, title : "提示"});
			return false;
		}

		var index = layer.confirm(
			"是否要申请出租？",
			{icon : 3, title : "提示"},
			function() {
				layer.close(index);
				// 点击确定后才生成日历
				$("#beginDateStr_m").ligerDateEditor({initValue : getNowFormatDate(1)});
				$("#endDateStr_m").ligerDateEditor();
				layer.open({
					type : 1,
					area : ["300px", "200px"],
					skin : "content_class",
					title : "出租时间",
					btn : ["确定", "取消"],
					content : $(".date_range_modal"),
					yes : function(index) {
						// ajax
						// ...
					}

				});
			}
		);
	}
	/* 日常类业务 - END */

	/* 标记类业务 - BRGIN */
	// （取消）标记为公用资产
	function markAsPublic(isPublic) {
		var idArr = new Array();
		var count = 0;
		var info = "";

		if (isPublic == 1) {
			info = "是否要标记为公用资产？";
		}else {
			info = "是否要取消公用资产标记？";
		}

		$("input[class='chk']:checked").each(function() {
			idArr[count] = $(this).val();
			count++;
		});

		if (count == 0) {
			layer.alert("请选择卡片", {icon : 7, title : "提示"});
			return false;
		}

		layer.confirm(
			info,
			{icon : 3, title : "提示"},
			function() {
				var loadid = layer.load(2);
				$.post(
					"${request.contextPath}/orgHome/markAsPublic",
					{"_method": "PUT", "isPublic": isPublic, "checkedIdStr": idArr.join()},
					function(data) {
						layer.close(loadid);
						if (data == "SUCCESS") {
							$(".toobar_search .query_form").submit();
						} else {
							layer.alert(data, {title : "提示"});
						}
					}
				);
			}
		);
	}
	/* 标记类业务 - END */

	/* 父页面刷新 - BEGIN */
	function refreshParentFrame(parentFrameId) {
		var parentFrame = window.parent.document.getElementById(parentFrameId).contentWindow.document;
		$(parentFrame).find(".query_form").submit();
	}
	/* 父页面窗口刷新 - END */

	$(function() {

		/* 全局效果 - BEGIN */
		// 每次触发文档就绪事件时，均先隐藏页面加载动画（可解决无限动画的问题）
		$iframe.prev(".l-tab-loading").hide();

		// 在提交表单的同时，显示页面加载动画
		$("form").submit(function() {
			var $action = $(this).prop("action");
			// 仅在导出操作时屏蔽动画
			if ($action.indexOf("export") < 0) {
				$iframe.prev(".l-tab-loading").show();
			}
		});

		// 判断浏览器版本是否为IE7，对空的td添加空字符，解决ie7空td无法显示边框
		if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/7./i)=="7.") {
			var aTd = document.getElementsByTagName("td");
				for(i = 0; i < aTd.length; i++) {
				if(aTd[i].innerHTML == "") aTd[i].innerHTML = "&nbsp;";
			}
		}

		// 文字过长时，鼠标悬停显示完整内容
		$(".list_wapper_content td").mouseenter(function() {
			if($(this).hasClass("list_img_item")){
				return;
			}
			if (this.offsetWidth < this.scrollWidth) {
				var that = $(this);
				if(that.children("a").html() == undefined){
					that.prop("title", that.html());
				}else{
					that.prop("title", that.children("a").html());
				}
			}
		});
		//针对图片列表的文字过长鼠标悬浮显示完整内容
		$(".list_name_wapper").mouseenter(function(){
			if(this.offsetWidth < this.scrollWidth){
				$(this).prop("title",$(this).children("a").html());
			}
		})
		/* 全局效果 - END */

		/* 复选框相关 - BEGIN */
		var chkCheckedNum = 0;
		var chkCheckedPrice = 0;
		// 本页卡片的总个数
		var cardsCountThisPage = $("input[class='chk']").length;
		// 本页卡片的总价值
		var cardsPriceThisPage = 0;
		$("input[class='chk']").each(function() {
			var price = $(this).attr("price");
			cardsPriceThisPage = accAdd(cardsPriceThisPage, price);
		});

		$(document).on("click", ".toobar_chosethis label", function() {
			var $input = $(this).children("input");
			var $list = $(".list_label");
			if ($input.prop("checked")) {
				$input.prop("checked", false);
				$list.children("input").prop("checked", false);
				$(this).removeClass("active");
				$list.removeClass("active");
				// 计算卡片的选中个数及总价值
				chkCheckedNum = "0";
				chkCheckedPrice = "0.00";
			} else {
				$input.prop("checked", true);
				$list.children("input").prop("checked", true);
				$(this).addClass("active");
				$list.addClass("active");
				// 计算卡片的选中个数及总价值
				chkCheckedNum = cardsCountThisPage;
				chkCheckedPrice = cardsPriceThisPage;
			}
			$("#total_number").text(chkCheckedNum);
			$("#total_price").text(chkCheckedPrice);
			return false;
		});

		$(document).on("click", ".list_label", function() {
			var $input = $(this).children("input");
			var price = $input.attr("price");
			if ($input.prop("checked")) {
				$input.prop("checked", false);
				$(this).removeClass("active");
				$(".toobar_chosethis label").children("input").prop("checked", false);
				$(".toobar_chosethis label").removeClass("active");
				// 计算卡片的选中个数及总价值
				chkCheckedNum --;
				chkCheckedPrice = accSubtr(chkCheckedPrice, price);
			} else {
				$input.prop("checked", true);
				$(this).addClass("active");
				// 状态为选中的复选框个数
				var chkCheckedCount = $("input[class='chk']:checked").length;
				if (cardsCountThisPage == chkCheckedCount) {
					$("#chkThisPage").prop("checked", true);
					$("#chkThisPage").parent().addClass("active");
				}
				// 计算卡片的选中个数及总价值
				chkCheckedNum ++;
				chkCheckedPrice = accAdd(chkCheckedPrice, price);
			}
			$("#total_number").text(chkCheckedNum);
			$("#total_price").text(chkCheckedPrice);
			return false;
		});
		/* 复选框相关 - END */

		/* 导出相关 - BEGIN */
		$(".toolbar_dc").click(function() {
			var idArr = new Array();
			var count = 0;
			$("input[class='chk']:checked").each(function() {
				idArr[count] = $(this).val();
				count++;
			});
			if (idArr.length > 0) {
				$("#checkedIdStr").val(idArr);
				var $action = $(".toobar_search .query_form").prop("action");
				$(".toobar_search .query_form").prop("action", "${exportUrl}").submit();
				$(".toobar_search .query_form").prop("action", $action);
			} else {
				// 提示框
				$(".toolbar_tips").fadeIn(200).delay(800).fadeOut(400);
			}
		});
		/* 导出相关 - END */

		/* 翻页相关 - BEGIN */
		$(".toobar_jt").click(function() {
			var able = $(this).attr("able");
			if (able == undefined) {
				return;
			}
			var pageNo = $(this).attr("pageNo");
			$("#pageNo").val(pageNo);
			$(".toobar_search .query_form").submit();
		});

		$("#page_switch").change(function() {
			var pageNo = $(this).val();
			var reg = /^\+?[1-9]\d{0,3}(\.\d*)?$/;
			if (!reg.test(pageNo)) {
				$(this).val("1");
			} else {
				$("#pageNo").val(pageNo);
				$(".toobar_search .query_form").submit();
			}
		});
		/* 翻页相关 - END */

		/* 模式切换相关 - BEGIN */
		<#if VIEW_MODE != "CARD_MODE">
			// 切换至卡片模式
			$("#toCard").click(function() {
				$("#viewMode").val("CARD_MODE");
				$(".toobar_search .query_form").submit();
			});
		</#if>

		<#if VIEW_MODE != "IMG_LIST_MODE">
			// 切换至图片列表模式
			$("#toImgList").click(function() {
				$("#viewMode").val("IMG_LIST_MODE");
				$(".toobar_search .query_form").submit();
			});
		</#if>

		<#if VIEW_MODE != "LIST_MODE">
			// 切换至列表模式
			$("#toList").click(function() {
				$("#viewMode").val("LIST_MODE");
				$(".toobar_search .query_form").submit();
			});
		</#if>
		/* 模式切换相关 - END */

		/* 排序相关 - BEGIN */
		var tmp = "${sortpartStr}".split("order by ")[1];
		if (tmp != undefined) {
			var column = tmp.split(" ")[0];
			var order = tmp.split(" ")[1];
			var newClass = "orderup";
			if (order == "desc") {
				newClass = "orderdown";
			}
			$("span[column='" + column + "']").addClass(newClass);
		}

		$(".sort").click(function() {
			var $arrow = $(this).find(".card_order_jt");
			var column = $arrow.attr("column");
			var order = "asc";
			if ($arrow.hasClass("orderup")) {
				order = "desc";
				$arrow.removeClass("orderup");
				$arrow.addClass("orderdown");
			} else if ($arrow.hasClass("orderdown")) {
				$arrow.removeClass("orderdown");
				$arrow.addClass("orderup");
			} else {
				$arrow.addClass("orderup");
			}
			var finalVal = "order by " + column + " " + order;
			if (column == "default") {
				finalVal = "";
			}
			$("input[name='sortpartStr']").val(finalVal);
			$(".toobar_search .query_form").submit();
		});
		/* 排序相关 - END */

		// 查看卡片详情
		$(".item_card_info_list").click(function() {
			var rwid = $(this).attr("rwid");
			var editable = $(this).attr("editable");
			$cardModal.prop("src", "${request.contextPath}/Query/BsAstCard/card/" + rwid + "/" + editable);
			window.parent.alertCard();
		});

		/* 工具栏效果相关 - BEGIN */
		// toolbar搜索框提示文字
		if(!$(".toobar_search input[name = 'keyvalueStr']").val()){
			$(".searchcard_tip").show();
		}
		$(".searchcard_tip").click(function(){
			$(this).hide();
			$(".toobar_search input[name = 'keyvalueStr']").focus();
		});
		$(".toobar_search input[name = 'keyvalueStr']").blur(function(){
		 	if(!$(this).val()){
		 		$(".searchcard_tip").show();
		 	}
		});
		// toolbar_box翻页样式功能
		$(".toobar_jt").mouseenter(function(){
			if($(this).attr("able")){
				$(this).css("background", "#3e9aef");
			}
		}).mouseleave(function(){
			$(this).css("background","#fff");
		}).mousedown(function(){
			if($(this).attr("able")){
				$(this).css("background", "#277fd0");
			}
		});
		// toolbar下拉功能列表鼠标样式
		$(".toolbar_item").mousedown(function(){
			$(this).addClass("active");
		}).mouseup(function(){
			$(this).removeClass("active");
		});
		$(".yewu_rclyw").click(function(event){
			event.stopPropagation();
			$(".bjlyw_list").hide();
			$(".yewu_bjlyw").removeClass("active");
			if($(".rclyw_list").css("display") == "none"){
				$(this).addClass("active");
				$(".rclyw_list").show();
			}else{
				$(this).removeClass("active");
				$(".rclyw_list").hide();
			}
		});
		$(".yewu_bjlyw").click(function(event){
			event.stopPropagation();
			$(".rclyw_list").hide();
			$(".yewu_rclyw").removeClass("active");
			if($(".bjlyw_list").css("display") == "none"){
				$(this).addClass("active");
				$(".bjlyw_list").show();
			}else{
				$(this).removeClass("active");
				$(".bjlyw_list").hide();
			}
		});
		$(".bjlyw_list, .rclyw_list").click(function(event){
			event.stopPropagation();
		})
		$(document).click(function(){
			$(".yewu_rclyw, .yewu_bjlyw").removeClass("active");
			$(".rclyw_list, .bjlyw_list").hide();
		});
		/* 工具栏效果相关 - END */

		/* 工具栏功能相关 - BEGIN */

		/* 工具栏功能相关 - END */

		/* 资产列表相关操作 - BEGIN */
		// 申请报修
		$(".wpcz_sqbx").click(function(){
			var zcId = $(this).parent(".wpcz_wapper").attr("zc_id");
			if($(".action_tips").length == 0){
				createTips();
			}
			$(".a_tips").html("该物品是否确定要报修？");
			$(".action_qd").attr("zc_id", zcId);
			$(".action_tips, .tips_cover").show();

		});
		// 申请转移
		$(".wpcz_sqzy").click(function(){
			var zcId = $(this).parent(".wpcz_wapper").attr("zc_id");
			if($(".action_tips").length == 0){
				createTips();
			}
			$(".a_tips").html("该物品是否确定要转移？");
			$(".action_qd").attr("zc_id", zcId);
			$(".action_tips, .tips_cover").show();
		});
		// 申请处置
		$(".wpcz_sqcz").click(function(){
			var zcId = $(this).parent(".wpcz_wapper").attr("zc_id");
			if($(".action_tips").length == 0){
				createTips();
			}
			$(".a_tips").html("该物品是否确定要处置？");
			$(".action_qd").attr("zc_id", zcId);
			$(".action_tips, .tips_cover").show();
		});
		// 确认收货
		$(".ywcz_qrsh").click(function(){
			var zcId = $(this).parent(".wpcz_wapper").attr("zc_id");
			if($(".action_tips").length == 0){
				createTips();
			}
			$(".a_tips").html("该物品确认收货吗？");
			$(".action_qd").attr("zc_id", zcId);
			$(".action_tips, .tips_cover").show();
		});
		// 取消收货
		$(".ywcz_qxsh").click(function(){
			var zcId = $(this).parent(".wpcz_wapper").attr("zc_id");
			if($(".action_tips").length == 0){
				createTips();
			}
			$(".a_tips").html("该物品确定取消收货吗？");
			$(".action_qd").attr("zc_id", zcId);
			$(".action_tips, .tips_cover").show();
		});
		// 查看流程
		$(".ywcz_cklc").click(function(){
			var zcId = $(this).attr("zc_id");
			if($(".liucheng_wapper").length == 0){
				createProcedure();
			}
			$(".liucheng_wapper, .tips_cover").show();
		});
		// 查看流程关闭按钮
		$("body").on("click", ".lc_icon_close", function(){
			$(".liucheng_wapper, .tips_cover").hide();
		});
		// 操作提示框点击确定事件
		$("body").on("click", ".action_qd", function(){
			var zcId = $(this).attr("zc_id");
			alert(zcId);
		});
		// 操作提示框点击取消事件
		$("body").on("click", ".action_qx", function(){
			$(".action_tips, .tips_cover").hide();
		});
		/* 资产列表相关操作 - END */

		/* 更多筛选条件相关 */
		// 弹出搜索框
		$(".toobar_moresearch").click(function(){
			var height = $(".more_search").height();
			var w_height = $(window).height();
			var top = $(".toobar_moresearch").offset().top;
			var left = $(".toobar_moresearch").offset().left;

			if(height > w_height - top){
				$(".more_search_main").height(w_height - top - 120);
			}
			$(".more_search").css({"top": top + 34,"left": left}).fadeToggle(200);

		});
		// 清空
		$(".iframe_btn_qk").click(function(){
			$(".more_search_main input").val("");
			$(".more_search_main select").val("");
		});
		// 取消
		$(".iframe_btn_qx").click(function(){
			$(".more_search").fadeOut(200);
		});
		// 更多筛选条件表单提交事件
		$(".filter_form").submit(function() {
			var canSubmit = true;
			$(".search_date").each(function(key, val){
				if(!compareDate($(val).find("input").eq(0).val(), $(val).find("input").eq(1).val())){
					// 获取当前选中页签的 tabid
					var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
					// 获取当前显示的 iframe
					var $iframe = $(window.parent.document).find("iframe[id='" + tabid + "']");
					// 隐藏页面加载动画
					$iframe.prev(".l-tab-loading").hide();
					if($(".query_button_tips").css("display") == "none"){
						$(".query_button_tips").css({"top":"84px", "left":"221px"}).fadeIn(200).delay(1000).fadeOut(400);
					}
					canSubmit = false;
				}
			})
			if(!canSubmit){
				return false;
			}
		});
		/* 更多筛选条件相关 - END */

		// iframe页面的弹框关闭按钮
		$(".ifm_close, .iframe_btn_qx").click(function(){
			$(this).parents(".xxgz_edit_container").hide();
		});

		/*
		<#if prompt?exists>
			alert("${prompt}");
		</#if>

		<#if error?exists>
			alert("${error}");
		</#if>

		<#if targetUrl?exists>
			$("input[name='pageNo']").keyup(function(e) {
				if (e.keyCode == 13) {
					var pageNo = $(this).val();
					var reg = /^\+?[1-9]\d{0,3}(\.\d*)?$/;
					if (!reg.test(pageNo)) {
						$(this).val("1");
					} else {
						location.href = "${targetUrl}/" + pageNo;
					}
				}
			});
		</#if>
		*/

	});

	// 卡片列表模式页面动态给列表赋值最大高度
	function setMaxheight(hdeff) {
		$(".list_wapper").height($(".container_card").height() - 140 - hdeff);
		$(".list_wapper .list_wapper_content").height($(".list_wapper").height() - 50);
		if ($(".list_wapper_content").height() > $(".list_wapper_content table").height()) {
			$(".list_wapper_header").css("padding-right", "0");
		} else {
			$(".list_wapper_header").css("padding-right", "17px");
		}
	}

	// loading显示功能
	function displayLoad() {
		var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
		var $iframe = $(window.parent.document).find("iframe[id='" + tabid + "']");
		$iframe.prev(".l-tab-loading").show();
	}

	// 生成操作提示弹框
	function createTips(){
		var tip = $("<div class='action_tips'>").appendTo($("body"));
		$("<div class='tips_cover'></div>").appendTo($("body"));
		tip.html("<div class='a_tips_header'>提示</div><div class='a_tips'></div><div class='a_action'><div class='action_qd'>是</div><div class='action_qx'>否</div></div>");
	}

	// 生成查看流程弹出框
	function createProcedure() {
		var wapper = $("<div class='liucheng_wapper'>").appendTo($("body"));
		$("<div class='tips_cover'></div>").appendTo($("body"));
		wapper.html("<div class='liucheng_header'><div class='lc_header'>查看流程</div><div class='lc_icon'></div><div class='lc_icon_close'></div></div><div class='lc_content'></div>");
	}

</script>