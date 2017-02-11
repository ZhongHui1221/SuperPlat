<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>维修情况</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body>
		<div class="container_box">
			<div class="top_deff"></div>
			<div class="chart_row" style="height: 45%">
				<div class="chart_box chart_box_allheight pr fl">
					<div class="chart_box_header">近十年固定资产维修趋势图<span></span></div>
					<div id="line1" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar danwei_bar_line">单位：万元</div>
				</div>
				<div class="chart_box chart_box_allheight pr fr">
					<div class="chart_box_header">本年度各月资产维修趋势图<span></span></div>
					<div id="line2" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar danwei_bar_line">单位：万元</div>
				</div>
			</div>
			<div class="query_box query_box_wxqk">
				<div class="search_wapper">
					<div class="query_info">入账日期：</div>
					<form id="query_form" action="${request.contextPath}/Query/Wxqk/main" method="get">
						<input id="ndDataStr" type="text" name="ndDataStr" value="${ndDataStr}" />
						<div class="query_select query_select_zjqk">
							<select id="selectType" name="selectType">
								<option value="all">全年</option>
								<option value="1">01月</option>
								<option value="2">02月</option>
								<option value="3">03月</option>
								<option value="4">04月</option>
								<option value="5">05月</option>
								<option value="6">06月</option>
								<option value="7">07月</option>
								<option value="8">08月</option>
								<option value="9">09月</option>
								<option value="10">10月</option>
								<option value="11">11月</option>
								<option value="12">12月</option>
							</select>
						</div>
						<div class="query_button">查询</div>
					</form>
				</div>
			</div>
			<div class="chart_row" style="height: 45%">
				<div class="chart_box chart_box_allheight pr fl">
					<div class="chart_box_header">维修情况趋势图（按卡片数量分析）<span></span></div>
					<div id="bar1" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar">单位：件</div>
				</div>
				<div class="chart_box chart_box_allheight pr fr">
					<div class="chart_box_header">维修情况趋势图（按维修费用分析）<span></span></div>
					<div id="bar2" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar">单位：万元</div>
				</div>
			</div>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerSpinner.js"></script>
		<script src="${request.contextPath}/static/framework/echarts/echarts.common.min.js"></script>
		<script src="${request.contextPath}/static/js/chartsToCards.js"></script>
		<script>

			$(function() {

				var data1 = {
					legend: ${tenYearsMap}.tenYearsLegend,
					data: ${tenYearsMap}.tenYearsData
				};

				var data2 = {
					legend: ${oneYearMap}.oneYearLegend,
					data: ${oneYearMap}.oneYearData
				};

				var data3 = {
					legend: ${wxqkLegend},
					data: ${shuLList}
				};

				var data4 = {
					legend: ${wxqkLegend},
					data: ${feiYList}
				};

				// 生成日历
				$("#ndDataStr").ligerSpinner({
					height: 24, type: "int", isNegative: false, minValue: 1990, value: Number(${ndDataStr})
				});

				// 将日历文本框设为只读
				$("#ndDataStr").attr("readonly", true);

				/* 创建实例 —— BEGIN */
				// 近十年固定资产维修趋势图
				var line1 = echarts.init(document.getElementById("line1"));

				// 本年度各月资产维修趋势图
				var line2 = echarts.init(document.getElementById("line2"));

				// 维修情况趋势图（按卡片数量分析）
				var bar1 = echarts.init(document.getElementById("bar1"));

				// 维修情况趋势图（按维修费用分析）
				var bar2 = echarts.init(document.getElementById("bar2"));
				/* 创建实例 —— END */

				/* 生成图表 —— BEGIN */
				// 获取当前选中页签的 tabid
				var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
				var condition = {
					targetTabId: "card_list",
					targetTabTitle: "卡片列表",
					targetTabUrl: "${request.contextPath}/Query/BsAstCard/list",
					fromModel:tabid,
					timeStr: "${ndDataStr}",
					mothStr: "${selectType}"
				};

				// 近十年固定资产维修趋势图
				line_option(data1, line1, "option1", "卡片价值", false);

				// 本年度各月资产维修趋势图
				line_option(data2, line2, "option2", "卡片价值", false);

				// 维修情况趋势图（按卡片数量分析）
				bar_option(data3, bar1, "option3", condition);

				// 维修情况趋势图（按维修费用分析）
				bar_option(data4, bar2, "option4", condition);
				/* 生成图表 —— END */

				$(".query_button").click(function() {
					$("#query_form").submit();
				});

				// 查询类型
				$("#selectType").val("${selectType}");

				// 响应式图表
				window.onresize = function(){
					line1.resize();
					line2.resize();
					bar1.resize();
					bar2.resize();
				}
			});

		</script>
	</body>
</html>