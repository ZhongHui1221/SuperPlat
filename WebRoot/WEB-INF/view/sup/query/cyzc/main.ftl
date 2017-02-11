<!DOCTYPE html>
<html class="html_media">
	<head>
		<meta charset="utf-8">
		<title>常用资产</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
		<script src="${request.contextPath}/static/js/respond.min.js"></script>
	</head>

	<body>
		<div class="container_box">
			<div class="query_box query_box_cy_media">
				<div class="search_wapper">
					<form id="query_form" action="${request.contextPath}/Query/Cyzc/main" method="get">
						<div class="query_info">购置日期：</div>
						<input id="dateStr" name="dateStr" type="text" value="${dateStr}" />
						<div class="query_button">查询</div>
					</form>
				</div>
			</div>
			<div class="chart_row chart_row_media_cy" style="height: 46.6%">
				<div class="chart_box fl chart_box_media_cy">
					<div class="chart_box_header">电脑、办公类设备<span></span></div>
					<div id="pie1" style="width: 100%; height: 90%"></div>
				</div>
				<div class="chart_box fr chart_box_media_cy">
					<div class="chart_box_header">家具、用具和装具<span></span></div>
					<div id="pie2" style="width: 100%; height: 90%"></div>
				</div>
			</div>
			<div class="chart_row chart_row_media_cy" style="height: 46.6%">
				<div class="chart_box fl chart_box_media_cy">
					<div class="chart_box_header">机动车辆<span></span></div>
					<div id="pie3" style="width: 100%; height: 90%"></div>
				</div>
				<div class="chart_box fr chart_box_media_cy">
					<div class="chart_box_header">数码电器类设备<span></span></div>
					<div id="pie4" style="width: 100%; height: 90%"></div>
				</div>
			</div>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
		<script src="${request.contextPath}/static/framework/echarts/echarts.common.min.js"></script>
		<script src="${request.contextPath}/static/js/charts.js"></script>
		<script>

			$(function() {

				/* 数据组装 —— BEGIN */
				// 电脑、办公类设备
				var cyq1Data = {
					legend: ${cyq1Legend},
					data: ${cyq1Data}
				};

				// 机动车辆
				var cyq2Data = {
					legend: ${cyq2Legend},
					data: ${cyq2Data}
				};

				// 数码电器类设备
				var cyq3Data = {
					legend: ${cyq3Legend},
					data: ${cyq3Data}
				};

				// 家具、用具和装具
				var cyq4Data = {
					legend: ${cyq4Legend},
					data: ${cyq4Data}
				};
				/* 数据组装 —— END */

				/* 创建实例 —— BEGIN */
				// 电脑、办公类设备
				var pie1 = echarts.init(document.getElementById("pie1"));

				// 家具、用具和装具
				var pie2 = echarts.init(document.getElementById("pie2"));

				// 机动车辆
				var pie3 = echarts.init(document.getElementById("pie3"));

				// 数码电器类设备
				var pie4 = echarts.init(document.getElementById("pie4"));
				/* 创建实例 —— END */

				/* 生成图表 —— BEGIN */
				// 电脑、办公类设备
				pie_option(cyq1Data, pie1, "option1", "cyzc_zcyt", "资产用途", "${request.contextPath}/Query/Cyzc/zcyt/${dateStr}");

				// 家具、用具和装具
				pie_option(cyq4Data, pie2, "option2", "cyzc_zcyt", "资产用途", "${request.contextPath}/Query/Cyzc/zcyt/${dateStr}");

				// 机动车辆
				pie_option(cyq2Data, pie3, "option3", "cyzc_zcyt", "资产用途", "${request.contextPath}/Query/Cyzc/zcyt/${dateStr}");

				// 数码电器类设备
				pie_option(cyq3Data, pie4, "option4", "cyzc_zcyt", "资产用途", "${request.contextPath}/Query/Cyzc/zcyt/${dateStr}");
				/* 生成图表 —— END */

				// 生成日历
				$("#dateStr").ligerDateEditor();
				//input框禁止编辑
				$("#dateStr").attr("readonly",true);

				// 查询
				$(".query_button").click(function() {
					// 获取当前选中页签的 tabid
					var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
					// 获取当前显示的 iframe
					var $iframe = $(window.parent.document).find("iframe[id='" + tabid + "']");
					// 页面加载动画
					$iframe.prev(".l-tab-loading").show();
					// 表单提交
					$("#query_form").submit();
				});

				if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
					setTimeout(chartResize,300);
				}

				// 响应式图表
				window.onresize = function(){
					// 判断浏览器版本是否为IE8，对IE8的图表生成做延时处理
					if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
						setTimeout(chartResize,300);
					}else{
						chartResize();
					}
				}

				function chartResize(){
					pie1.resize();
					pie2.resize();
					pie3.resize();
					pie4.resize();
				}

			});

		</script>
	</body>
</html>