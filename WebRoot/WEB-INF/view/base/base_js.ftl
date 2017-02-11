<script src="${request.contextPath}/static/js/jquery-1.9.0.min.js"></script>
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
				$(".tips_dc_wushuju").fadeIn(200).delay(800).fadeOut(400);
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
		<#if VIEW_MODE == "LIST_MODE">
			// 切换至卡片模式
			$("#toCard").click(function() {
				$("#viewMode").val("CARD_MODE");
				$(".toobar_search .query_form").submit();
			});
		</#if>

		<#if VIEW_MODE == "CARD_MODE">
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
				$(this).css("background", "#EDF4FC");
			}
		}).mouseleave(function(){
			$(this).css("background","#fff");
		});

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
		$(".list_wapper").height($(".container_box").height() - 50 - hdeff);
		$(".list_wapper .list_wapper_content").height($(".list_wapper").height() - 42);
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

</script>