<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>资产用途</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body>
		<div class="container_box">
			<div class="top_deff"></div>
			<div class="chart_row" style="height: 46%">
				<div class="chart_box pr fl">
					<div class="chart_box_header">资产用途情况图（按资产数量分析）<span></span></div>
					<div id="ddbar1" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar">单位：件</div>
				</div>
				<div class="chart_box pr fr">
					<div class="chart_box_header">资产用途情况图（按资产价值分析）<span></span></div>
					<div id="ddbar2" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar">单位：万元</div>
				</div>
			</div>
			<div class="chart_row" style="height: 50%">
				<div class="table_box">
					<div class="chart_box_header">资产用途查询表<span></span></div>
					<div class="chart_row_cont">
						<div class="chart_row_cont_inner">
							<div class="query_box query_box_inner">
								<div class="table_tips">*下表中的数据是以卡片中的购置日期为统计口径</div>
							</div>
							<div class="table_wapper">
								<div class="table_wapper_header">
									<table class="gdzc_table_header">
										<tr>
											<th style="width: 14%;">用途分类</th>
											<th style="width: 14%;">总件数（件）</th>
											<th style="width: 15%;">总价值（万元）</th>
											<th style="width: 14%;">未到使用年限数量（件）</th>
											<th style="width: 14%;">已到使用年限数量（件）</th>
											<th style="width: 15%;">未到使用年限价值（万元）</th>
											<th style="width: 14%;border-right: none;">已到使用年限价值（万元）</th>
										</tr>
									</table>
								</div>
								<div class="table_wapper_cont">
									<table class="gdzc_table clearfix" id="gdzc_table">
										<tr class="table_inner_header">
											<td style="width: 14%;">合计</td>
											<td style="text-align: right;width: 14%;">${totalNum}&nbsp;</td>
											<td style="text-align: right;width: 15%;">${(totalPrice / 10000)?string("0.00")}&nbsp;</td>
											<td style="text-align: right;width: 14%;">${totalUnexpiredNum}&nbsp;</td>
											<td style="text-align: right;width: 14%;">${totalExpiredNum}&nbsp;</td>
											<td style="text-align: right;width: 15%;">${(totalUnexpiredPrice / 10000)?string("0.00")}&nbsp;</td>
											<td style="text-align: right;width: 14%;">${(totalExpiredPrice / 10000)?string("0.00")}&nbsp;</td>
										</tr>
										<#list zcytCursor as obj>
											<tr>
												<td>${obj["OBJNAME"]}</td>
												<td style="text-align: right">${obj["QSHUL"]}&nbsp;</td>
												<td style="text-align: right">${(obj["QJIAZ"] / 10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right">${obj["ZSHUL"]}&nbsp;</td>
												<td style="text-align: right">${obj["DBFSHUL"]}&nbsp;</td>
												<td style="text-align: right">${(obj["ZJIAZ"] / 10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right">${(obj["DBFJIAZ"] / 10000)?string("0.00")}&nbsp;</td>
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
		<script src="${request.contextPath}/static/js/charts.js"></script>
		<script>

			$(function() {

				/* 数据组装 —— BEGIN */
				// 资产用途情况图（按资产数量分析）
				var numData = {
					legend: ["未到使用年限", "已到使用年限"],
					used: ${zcytUsed},
					data: [
						{"name": "未到使用年限", "value": ${unexpiredNumList}},
						{"name": "已到使用年限", "value": ${expiredNumList}}
					]
				};

				// 资产用途情况图（按资产价值分析）
				var priceData = {
					legend: ["未到使用年限", "已到使用年限"],
					used: ${zcytUsed},
					data: [
						{"name": "未到使用年限", "value": ${unexpiredPriceList}},
						{"name": "已到使用年限", "value": ${expiredPriceList}}
					]
				};
				/* 数据组装 —— END */

				/* 创建实例 —— BEGIN */
				// 资产用途情况图（按资产数量分析）
				var ddbar1 = echarts.init(document.getElementById("ddbar1"));

				// 资产用途情况图（按资产价值分析）
				var ddbar2 = echarts.init(document.getElementById("ddbar2"));
				/* 创建实例 —— END */

				/* 生成图表 —— BEGIN */
				// 资产用途情况图（按资产数量分析）
				ddbar_option(numData, ddbar1, "option1", "总量", "cyzc_syzk", "使用状况", "${request.contextPath}/Query/Cyzc/syzk/${dateStr}/${zicflidStr}");

				// 资产用途情况图（按资产价值分析）
				ddbar_option(priceData, ddbar2, "option2", "总量", "cyzc_syzk", "使用状况", "${request.contextPath}/Query/Cyzc/syzk/${dateStr}/${zicflidStr}");
				/* 生成图表 —— END */

				// 响应式图表
				window.onresize = function() {
					ddbar1.resize();
					ddbar2.resize();
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