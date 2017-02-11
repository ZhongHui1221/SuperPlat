<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>使用状况</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body>
		<div class="container_box">
			<div class="top_deff"></div>
			<div class="chart_row" style="height: 46%">
				<div class="chart_box pr" style="width: 90%; margin: 0 auto">
					<div class="chart_box_header">资产使用状况图（按资产数量分析）<span></span></div>
					<div id="bar1" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar">单位：件</div>
				</div>
			</div>
			<div class="chart_row" style="height: 50%">
				<div class="table_box">
					<div class="chart_box_header">资产使用状况查询表<span></span></div>
					<div class="chart_row_cont">
						<div class="chart_row_cont_inner">
							<div class="query_box query_box_inner">
								<div class="table_tips">*下表中的数据是以卡片中的购置日期为统计口径</div>
							</div>
							<div class="table_wapper">
								<div class="table_wapper_header">
									<table class="gdzc_table_header">
										<tr>
											<th style="width: 30%">使用状况</th>
											<th style="width: 35%">数量（件）</th>
											<th style="width: 35%; border-right: none">价值（万元）</th>
										</tr>
									</table>
								</div>
								<div class="table_wapper_cont">
									<table class="gdzc_table clearfix" id="gdzc_table">
										<#list syzkList as obj>
											<tr class="table_inner_header">
												<td style="width: 30%">${obj.syzk}</td>
												<td style="text-align: right; width: 35%">${obj.num}&nbsp;</td>
												<td style="text-align: right; width: 35%">${obj.price}&nbsp;</td>
											</tr>
										</#list>
									</table>
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
		<script src="${request.contextPath}/static/framework/echarts/echarts.common.min.js"></script>
		<script src="${request.contextPath}/static/js/chartsToCards.js"></script>
		<script>

			$(function() {

				/* 数据组装 —— BEGIN */
				// 资产使用状况图（按资产数量分析）
				var numData = {
					legend: ${syzkLegend},
					data: ${syzkData}
				}
				/* 数据组装 —— END */

				/* 创建实例 —— BEGIN */
				// 资产使用状况图（按资产数量分析）
				var bar1 = echarts.init(document.getElementById("bar1"));
				/* 创建实例 —— END */

				/* 生成图表 —— BEGIN */
				// 资产使用状况图（按资产数量分析）
				//获取当前iframe的tabID
				var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
				var condition = {
					targetTabId: "card_list",
					targetTabTitle: "卡片列表",
					targetTabUrl: "${request.contextPath}/Query/BsAstCard/list",
					fromModel:tabid,
					dateStr: "${dateStr}",
					zicflidStr: "${zicflidStr}",
					yongtidStr: "${yongtidStr}"
				};

				bar_option(numData, bar1, "option1", condition);
				/* 生成图表 —— END */

				// 响应式图表
				window.onresize = function() {
					bar1.resize();
				};

				// 判断滚动条
				var t_height = $(".table_wapper_cont table").height();
				var b_height = $(".table_wapper_cont").height();
				if (t_height <= b_height) {
					$(".table_wapper_header").css({"padding-right": "0"});
				}

			});

		</script>
	</body>
</html>