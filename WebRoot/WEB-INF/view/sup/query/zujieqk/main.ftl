<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>租借情况</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body>
		<div class="container_box">
			<div style="height: 2%"></div>
			<div class="chart_row">
				<div class="chart_box pr fl">
					<div class="chart_box_header">本年度各月租借趋势图（按批复单数量分析）<span></span></div>
					<div id="line1" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar danwei_bar_line">单位：笔</div>
				</div>
				<div class="chart_box pr fr">
					<div class="chart_box_header">本年度各月租借趋势图（按批复金额分析）<span></span></div>
					<div id="line2" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar danwei_bar_line">单位：万元</div>
				</div>
			</div>
			<div class="chart_row">
				<div class="chart_box pr fl">
					<div class="chart_box_header">近十年租借趋势图（按批复单数量分析）<span></span></div>
					<div id="line3" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar danwei_bar_line">单位：笔</div>
				</div>
				<div class="chart_box pr fr">
					<div class="chart_box_header">近十年租借趋势图（按批复金额分析）<span></span></div>
					<div id="line4" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar danwei_bar_line">单位：万元</div>
				</div>
			</div>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/echarts/echarts.common.min.js"></script>
		<script src="${request.contextPath}/static/js/charts.js"></script>
		<script>

			$(function() {

				// 数据格式
				var data = {
					legend: ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月'],
					data: [{"value":"221","hash":"fdsfds"},{"value":"221","hash":"fdsfds"},{"value":"221","hash":"fdsfds"},{"value":"221","hash":"fdsfds"},{"value":"221","hash":"fdsfds"},{"value":"221","hash":"fdsfds"},{"value":"221","hash":"fdsfds"},{"value":"221","hash":"fdsfds"},{"value":"221","hash":"fdsfds"},{"value":"221","hash":"fdsfds"}]
				}

				/* 创建实例 —— BEGIN */
				// 本年度各月租借趋势图（按批复单数量分析）
				var line1 = echarts.init(document.getElementById("line1"));

				// 本年度各月租借趋势图（按批复金额分析）
				var line2 = echarts.init(document.getElementById("line2"));

				// 近十年租借趋势图（按批复单数量分析）
				var line3 = echarts.init(document.getElementById("line3"));

				// 近十年租借趋势图（按批复金额分析）
				var line4 = echarts.init(document.getElementById("line4"));
				/* 创建实例 —— END */

				/* 生成图表 —— BEGIN */
				// 本年度各月租借趋势图（按批复单数量分析）
				line_option(data, line1, "option1", "批复单数量", true);

				// 本年度各月租借趋势图（按批复金额分析）
				line_option(data, line2, "option2", "批复金额", true);

				// 近十年租借趋势图（按批复单数量分析）
				line_option(data, line3, "option3", "批复单数量", true);

				// 近十年租借趋势图（按批复金额分析）
				line_option(data, line4, "option4", "批复金额", true);

				// 响应式图表
				window.onresize = function() {
					line1.resize();
					line2.resize();
					line3.resize();
					line4.resize();
				}

			});

		</script>
	</body>
</html>