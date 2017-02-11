<!DOCTYPE html>
<html class="html_media">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<title>待报废情况</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
		<script src="${request.contextPath}/static/js/respond.min.js"></script>
	</head>

	<body>
		<div class="container_box">
			<div class="top_deff top_deff_media"></div>
			<div class="chart_row chart_row_chart chart_row_media">
				<div class="chart_box pr fl chart_box_media">
					<div class="chart_box_header">待报废资产情况图（按卡片数量分析）<span></span></div>
					<div id="ddbar1" style="width: 100%;height:100%;"></div>
					<div class="danwei_bar">单位：张</div>
				</div>
				<div class="chart_box fr chart_box_media">
					<div class="chart_box_header">待报废资产情况图（按卡片价值分析）<span></span></div>
					<div id="pie1" style="width: 100%;height:90%;"></div>
				</div>
			</div>
			<div class="chart_row chart_row_table chart_row_table_media" style="height: 50%">
				<div class="table_box">
					<div class="chart_box_header">
						待报废资产情况统计表
						<span></span>
						<div class="slide_toggle"></div>
					</div>
					<div class="chart_row_cont">
						<div class="chart_row_cont_inner chart_row_cont_inner_media">
							<div class="query_box query_box_inner" >
									<div class="table_tips">*下表中的数据是以卡片中的购置日期为统计口径<span>单位：万元</span></div>
							</div>
							<div class="table_wapper">
								<div class="table_wapper_header">
									<table class="gdzc_table_header">
										<tr>
											<th style="width: 10%">科目名称</th>
											<th style="width: 10%;">明细科目名称</th>
											<th style="width: 9%;">0-3年</th>
											<th style="width: 9%;">3-5年</th>
											<th style="width: 9%;">5-8年</th>
											<th style="width: 9%;">8-10年</th>
											<th style="width: 9%;">10-15年</th>
											<th style="width: 9%;">15-20年</th>
											<th style="width: 9%;">20年以上</th>
										</tr>
									</table>
								</div>
								<div class="table_wapper_cont">
									<#if detailCursor?size gt 0>
										<table class="gdzc_table clearfix" id="gdzc_table">
											<tr class="table_inner_header">
												<td style="width: 10%;">合计</td>
												<td style="width: 10%;"></td>
												<td style="text-align: right;width: 9%;">${(totalA/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalB/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalC/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalD/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalE/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalF/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalG/10000)?string("0.00")}&nbsp;</td>
											</tr>
											<tr>
												<td rowspan="${detailCursor?size+1}">固定资产</td>
											</tr>
											<#list detailCursor as obj>
												<tr>
													<td>${obj["DL"]}&nbsp;</td>
													<td style="text-align: right;">${(obj["AJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["BJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["CJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["DJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["EJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["FJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["GJIAZ"]/10000)?string("0.00")}&nbsp;</td>
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
			$(function(){

				//数据格式
				var data1 = {legend: ['全部', '待报废'],
							used:${dbfLegend},
							data:[
								{"name":"全部","value":${zCntList}},
								{"name":"待报废","value":${dbfCntList}}
							]
				}
				var data2 = {legend:${dbfLegend},
							data:${dbfPriceList}
				}

				/* 创建实例 —— BEGIN */
				//待报废资产情况图（按卡片数量分析）
				var ddbar1 = echarts.init(document.getElementById('ddbar1'));

				//待报废资产情况图（按卡片价值分析）
				var pie1 = echarts.init(document.getElementById('pie1'));
				/* 创建实例 —— END */

				/* 生成图表 —— BEGIN */

				//获取当前iframe的tabID
				var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
				var condition = {
					ifstack: null,
					targetTabId: "card_list",
					targetTabTitle: "卡片列表",
					targetTabUrl: "${request.contextPath}/Query/BsAstCard/list",
					fromModel:tabid
				};

				//待报废资产情况图（按卡片数量分析）
				ddbar_option(data1,ddbar1,"option1",condition);

				//待报废资产情况图（按卡片价值分析）
				pie_option(data2,pie1,"option1",condition);
				/* 生成图表 —— END */

				//给页面table设置最大的高度
				tableMaxHeight(6);

				//图表响应式
				window.onresize = function(){
					tableMaxHeight(6);
					checkScrollBar();
					// 判断浏览器版本是否为IE8，对IE8的图表生成做延时处理
					if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
						setTimeout(chartResize,200);
					}else{
						chartResize();
					}
				};

				// 判断浏览器版本是否为IE8，对IE8的图表生成做延时处理
				if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
					setTimeout(chartResize,200);
				}

				// 图表自适应
				function chartResize(){
					ddbar1.resize();
					pie1.resize();
				}

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
							$(".table_wapper").height("86%");
							$(".table_wapper_header").css({"padding-right": "0"});
						}else{
							$(".chart_row_table").height("46%");
							$(".table_wapper").height("82%");
							$(".table_wapper_header").css({"padding-right": "17px"});
						}
					}
				})
			})
		</script>
	</body>
</html>