<!DOCTYPE html>
<html class="html_media">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<title>总体情况</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
		<script src="${request.contextPath}/static/js/respond.min.js"></script>
	</head>

	<body>
		<div class="container_box">
			<div class="top_deff top_deff_media"></div>
			<div class="chart_row chart_row_chart chart_row_media chart_row_zt">
				<div class="chart_box pr fl chart_box_media">
					<div class="chart_box_header">本年度各月固定资产趋势图（按卡片数量分析）<span></span></div>
					<div id="line1" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar danwei_bar_line">单位：张</div>
				</div>
				<div class="chart_box pr fr chart_box_media">
					<div class="chart_box_header">本年度各月固定资产趋势图（按卡片价值分析）<span></span></div>
					<div id="line2" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar danwei_bar_line">单位：万元</div>
				</div>
			</div>
			<div class="chart_row chart_row_chart chart_row_media chart_row_zt">
				<div class="chart_box pr fl chart_box_media">
					<div class="chart_box_header">近十年固定资产趋势图（按卡片数量分析）<span></span></div>
					<div id="line3" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar danwei_bar_line">单位：张</div>
				</div>
				<div class="chart_box pr fr chart_box_media">
					<div class="chart_box_header">近十年固定资产趋势图（按卡片价值分析）<span></span></div>
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
			$(function(){

				/* 数据组装 —— BEGIN */
				var monthCntData = {
					legend: ${ztqkMonthList},
					data: ${ztqkMonthCntList}
				};

				var monthPriceData = {
					legend: ${ztqkMonthList},
					data: ${ztqkMonthPriceList}
				};

				var yearCntData = {
					legend: ${ztqkYearList},
					data: ${ztqkYearCntList}
				};

				var yearPriceData = {
					legend: ${ztqkYearList},
					data: ${ztqkYearPriceList}
				};
				/* 数据组装 —— END */

				/* 创建实例 —— BEGIN */
				// 本年度各月固定资产趋势图（按卡片数量分析）
				var line1 = echarts.init(document.getElementById("line1"));

				// 本年度各月固定资产趋势图（按卡片价值分析）
				var line2 = echarts.init(document.getElementById("line2"));

				// 近十年固定资产趋势图（按卡片数量分析）
				var line3 = echarts.init(document.getElementById("line3"));

				// 近十年固定资产趋势图（按卡片价值分析）
				var line4 = echarts.init(document.getElementById("line4"));
				/* 创建实例 —— END */

				/* 生成图表 —— BEGIN */
				// 本年度各月固定资产趋势图（按卡片数量分析）
				line_option(monthCntData, line1, "option1", "卡片数量", false);

				// 本年度各月固定资产趋势图（按卡片价值分析）
				line_option(monthPriceData, line2, "option2", "卡片价值", false);

				// 近十年固定资产趋势图（按卡片数量分析）
				line_option(yearCntData, line3, "option3", "卡片数量", false);

				// 近十年固定资产趋势图（按卡片价值分析）
				line_option(yearPriceData, line4, "option4", "卡片价值", false);
				/* 生成图表 —— END */

				// 响应式图表
				window.onresize = function(){
					// 判断浏览器版本是否为IE8，对IE8的图表生成做延时处理
					if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
						setTimeout(chartResize,200);
					}else{
						chartResize();
					}
				}

				if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
					setTimeout(chartResize,200);
				}

				function chartResize(){
					line1.resize();
					line2.resize();
					line3.resize();
					line4.resize();
				}
			})

		</script>
	</body>
</html>