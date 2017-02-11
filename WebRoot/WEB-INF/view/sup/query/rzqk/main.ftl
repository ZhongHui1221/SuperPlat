<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>入账情况</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body>
		<div class="container_box">
			<div class="top_deff"></div>
			<div class="chart_row chart_row_chart" style="height: 46%">
				<div class="chart_box pr" style="width: 90%; margin: 0 auto">
					<div class="chart_box_header">固定资产入账情况图（按卡片数量分析）<span></span></div>
					<div id="ddbar1" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar">单位：张</div>
				</div>
			</div>
			<div class="chart_row chart_row_table" style="height: 50%">
				<div class="table_box">
					<div class="chart_box_header">
						固定资产入账情况表
						<span></span>
						<div class="slide_toggle"></div>
					</div>
					<div class="chart_row_cont">
						<div class="chart_row_cont_inner">
							<div class="query_box query_box_inner query_box_rzqk">
								<form id="query_form" action="${request.contextPath}/Query/Rzqk/main" method="get">
									<div class="query_box_zdy" style="display: block">
										<input type="text" id="beginDateStr" name="beginDateStr" value="${beginDateStr}" />
										<div class="query_info" style="margin: 0px 8px">至</div>
										<input type="text" id="endDateStr" name="endDateStr" value="${endDateStr}" />
										<div class="query_button">
											查询<div class="query_button_tips">起始日期不能大于截止日期！</div>
										</div>
									</div>
								</form>
								<div class="table_tips table_tips_rzqk">*下表中的数据是以卡片中的购置日期为统计口径<span>单位：万元</span></div>
							</div>
							<div class="table_wapper">
								<div class="table_wapper_header">
									<table class="gdzc_table_header">
										<tr>
											<th style="width: 15%">科目名称</th>
											<th style="width: 25%">明细科目名称</th>
											<th style="width: 15%">期初价值</th>
											<th style="width: 15%">借方</th>
											<th style="width: 15%">贷方</th>
											<th style="width: 15%">期末价值</th>
										</tr>
									</table>
								</div>
								<div class="table_wapper_cont">
									<#if zzCursor?size gt 0>
										<table class="gdzc_table clearfix" id="gdzc_table">
											<tr class="table_inner_header">
												<td style="width: 15%">合计</td>
												<td style="width: 25%"></td>
												<td style="text-align: right; width: 15%">${(totalCqjz/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right; width: 15%">${(totalJf/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right; width: 15%">${(totalDf/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right; width: 15%">${(totalMqjz/10000)?string("0.00")}&nbsp;</td>
											</tr>
											<tr>
												<td rowspan="${zzCursor?size + 1}">固定资产</td>
											</tr>
											<#list zzCursor as obj>
												<tr>
													<td>${obj["DL"]}&nbsp;</td>
													<td style="text-align: right">${(obj["QIC"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["ZENGJ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["JIANS"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["QIM"]/10000)?string("0.00")}&nbsp;</td>
												</tr>
											</#list>
										</table>
									</#if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
		<script src="${request.contextPath}/static/framework/echarts/echarts.common.min.js"></script>
		<script src="${request.contextPath}/static/js/chartsToCards.js"></script>
		<script>

			$(function() {

				var data1 = {
					legend: ["已入账", "未入账"],
					used: ${rzqkX},
					data: [
						{"name": "已入账", "value": ${ydzList}},
						{"name": "未入账", "value": ${wrzList}}
					]
				};

				/* 创建实例 —— BEGIN */
				var ddbar1 = echarts.init(document.getElementById("ddbar1"));
				/* 创建实例 —— END */

				/* 生成图表 —— BEGIN */
				// 获取当前选中页签的 tabid
				var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");

				var condition = {
					ifstack: "two",
					targetTabId: "card_list",
					targetTabTitle: "卡片列表",
					targetTabUrl: "${request.contextPath}/Query/BsAstCard/list",
					fromModel: tabid
				};

				ddbar_option(data1, ddbar1, "option1", condition);
				/* 生成图表 —— END */

				// 查询
				$(".query_button").click(function() {
					var begin = $("#beginDateStr").val();
					var end = $("#endDateStr").val();
					if (compareDate(begin, end)) {
						// 获取当前选中页签的 tabid
						var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
						// 获取当前显示的 iframe
						var $iframe = $(window.parent.document).find("iframe[id='" + tabid + "']");
						// 页面加载动画
						$iframe.prev(".l-tab-loading").show();
						// 表单提交
						$("#query_form").submit();
					} else {
						if($(".query_button_tips").css("display") == "none"){
							$(".query_button_tips").fadeIn(200).delay(1000).fadeOut(400);
						}
					}
				});

				// 生成日历
				<#if beginDateStr?? && endDateStr??>
					$("#beginDateStr").ligerDateEditor();
					$("#endDateStr").ligerDateEditor();
				<#else>
					var query_date = getNowFormatDate(2);
					$("#beginDateStr").ligerDateEditor({initValue: query_date.begin});
					$("#endDateStr").ligerDateEditor({initValue: query_date.end});
				</#if>

				// 将日历文本框设为只读
				$("#endDateStr, #beginDateStr").attr("readonly", true);

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

				// 给页面 table 设置最大高度
				tableMaxHeight(10);

				// 响应式图表
				window.onresize = function() {
					tableMaxHeight(10);
					checkScrollBar();
					ddbar1.resize();
				}

				function tableMaxHeight(hDeff) {
					var contHeight = $(".chart_row_cont").height();
					var queryHeight = $(".query_box_inner").height();
					$(".table_wapper").height(contHeight - queryHeight - hDeff);
					$(".table_wapper_cont").height(contHeight - queryHeight - 30 - hDeff);
				}

				// 判断滚动条
				function checkScrollBar() {
					var t_height = $(".table_wapper_cont table").height();
					var b_height = $(".table_wapper_cont").height();
					if (t_height <= b_height) {
						$(".table_wapper_header").css({"padding-right": "0"});
						$(".table_wapper_cont").css("overflow-y", "hidden");
						return false;
					} else {
						$(".table_wapper_header").css({"padding-right": "17px"});
						$(".table_wapper_cont").css("overflow-y", "auto");
						return true;
					}
				}

				var checkscrollbar = checkScrollBar();

				// 表格上拉切换
				$(".slide_toggle").click(function() {
					$(".chart_row_chart").slideToggle(100);
					$(this).toggleClass("active");
					if (checkscrollbar) {
						if ($(this).hasClass("active")) {
							$(".chart_row_table").height("70%");
							$(".table_wapper_header").css({"padding-right": "0"});
						} else {
							$(".chart_row_table").height("46%");
							$(".table_wapper_header").css({"padding-right": "17px"});
						}
					}
				});

			});

		</script>
	</body>
</html>