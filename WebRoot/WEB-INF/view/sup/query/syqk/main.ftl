<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>使用情况</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body>
		<div class="container_box">
			<div class="top_deff"></div>
			<div class="chart_row chart_row_chart" style="height: 46%;">
				<div class="chart_box pr fl">
					<div class="chart_box_header">固定资产使用情况图（按卡片数量分析）<span></span></div>
					<div id="pie1" style="width: 100%; height: 90%"></div>
				</div>
				<div class="chart_box fr">
					<div class="chart_box_header">固定资产使用情况图（按卡片价值分析）<span></span></div>
					<div id="pie2" style="width: 100%; height: 90%"></div>
				</div>
			</div>
			<div class="chart_row chart_row_table" style="height: 50%">
				<div class="table_box">
					<div class="chart_box_header">
						固定资产使用状况查询表
						<span></span>
						<div class="slide_toggle"></div>
					</div>
					<div class="chart_row_cont">
						<div class="chart_row_cont_inner">
							<div class="query_box query_box_inner">
								<div class="table_tips">*下表中的数据是以卡片中的购置日期为统计口径</div>
							</div>
							<div class="table_wapper">
								<div class="table_wapper_header">
									<table class="gdzc_table_header">
										<tr>
											<th style="width: 10%;">科目名称</th>
											<th style="width: 18%;">明细科目名称</th>
											<th style="width: 12%;">入库（万元）</th>
											<th style="width: 12%;">自用（万元）</th>
											<th style="width: 12%;">公用（万元）</th>
											<th style="width: 12%;">出租（万元）</th>
											<th style="width: 12%;">出借（万元）</th>
											<th style="width: 12%;">闲置（万元）</th>
										</tr>
									</table>
								</div>
								<div class="table_wapper_cont">
									<#if detailCursor?size gt 0>
										<table class="gdzc_table clearfix" id="gdzc_table">
											<tr class="table_inner_header">
												<td style="width: 10%;">合计</td>
												<td style="width: 18%;"></td>
												<td style="text-align: right;width: 12%;">${(rkjzTotal / 10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 12%;">${(zyjzTotal / 10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 12%;">${(gyjzTotal / 10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 12%;">${(czjzTotal / 10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 12%;">${(cjjzTotal / 10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 12%;">${(xzjzTotal / 10000)?string("0.00")}&nbsp;</td>
											</tr>
											<tr>
												<td rowspan="${detailCursor?size+1}">固定资产</td>
											</tr>
											<#list detailCursor as obj>
												<tr>
													<td>${obj["DL"]}</td>
													<td style="text-align: right">${(obj["RKJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["ZYJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["GYJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["CZJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["CJJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["XZJIAZ"]/10000)?string("0.00")}&nbsp;</td>
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
		<script src="${request.contextPath}/static/framework/echarts/echarts.common.min.js"></script>
		<script src="${request.contextPath}/static/js/chartsToCards.js"></script>
		<script>

			$(function() {

				/* 数据组装 —— BEGIN */
				// 资产数量分配图
				var data1 = {legend:${chartLegend},
							data:${chart1Data}
				};

				// 资产价值分配图
				var data2 = {legend:${chartLegend},
							data:${chart2Data}
				};
				/* 数据组装 —— END */

				/* 创建实例 —— BEGIN */
				var pie1 = echarts.init(document.getElementById('pie1'));
				var pie2 = echarts.init(document.getElementById('pie2'));
				/* 创建实例 —— END */

				/* 生成图表 —— BEGIN */
				//获取当前iframe的tabID
				var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
				var condition = {
					targetTabId: "card_list",
					targetTabTitle: "卡片列表",
					targetTabUrl: "${request.contextPath}/Query/BsAstCard/list",
					fromModel:tabid
				};
				pie_option(data1,pie1,"option1",condition);
				pie_option(data2,pie2,"option2",condition);
				/* 生成图表 —— END */

				// 给页面table设置最大的高度
				tableMaxHeight(10);

				// 响应式图表
				window.onresize = function() {
					tableMaxHeight(10);
					checkScrollBar();
					pie1.resize();
					pie2.resize();
				};

				function tableMaxHeight(hDeff){
					var contHeight = $(".chart_row_cont").height();
					var queryHeight = $(".query_box_inner").height();
					$(".table_wapper").height(contHeight - queryHeight - hDeff);
					$(".table_wapper_cont").height(contHeight - queryHeight - 30 - hDeff);
				}

				// 判断滚动条
				function checkScrollBar(){
					var t_height = $(".table_wapper_cont table").height();
					var b_height = $(".table_wapper_cont").height();
					if (t_height <= b_height) {
						$(".table_wapper_header").css({"padding-right": "0"});
						$(".table_wapper_cont").css("overflow-y","hidden");
						return false;
					}else{
						$(".table_wapper_header").css({"padding-right": "17px"});
						$(".table_wapper_cont").css("overflow-y","auto");
						return true;
					}
				}

				var checkscrollbar = checkScrollBar();

				//表格上拉切换
				$(".slide_toggle").click(function(){
					$(".chart_row_chart").slideToggle(100);
					$(this).toggleClass("active");
					if(checkscrollbar){
						if($(this).hasClass("active")){
							$(".chart_row_table").height("70%");
							$(".table_wapper_header").css({"padding-right": "0"});
						}else{
							$(".chart_row_table").height("46%");
							$(".table_wapper_header").css({"padding-right": "17px"});
						}
					}
				})

			});

		</script>
	</body>
</html>