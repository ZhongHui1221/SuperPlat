<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>用途分类</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>
	<body>
		<div class="container_box">
			<div class="top_deff"></div>
			<div class="chart_row chart_row_chart" style="height: 46%;">
				<div class="chart_box pr fl">
					<div class="chart_box_header">固定资产用途分类情况图（按卡片数量分析）<span></span></div>
					<div id="pie1" style="width: 100%;height:90%;"></div>
				</div>
				<div class="chart_box fr">
					<div class="chart_box_header">固定资产用途分类情况图（按卡片价值分析）<span></span></div>
					<div id="pie2" style="width: 100%;height:90%;"></div>
				</div>
			</div>
			<div class="chart_row chart_row_table" style="height: 50%;">
				<div class="table_box">
					<div class="chart_box_header">
						固定资产用途分类查询表
						<span></span>
						<div class="slide_toggle"></div>
					</div>
					<div class="chart_row_cont">
						<div class="chart_row_cont_inner" >
							<div class="query_box query_box_inner" >
								<div class="table_tips">*下表中的数据是以卡片中的购置日期为统计口径<span>单位：万元</span></div>
							</div>
							<div class="table_wapper">
								<div class="table_wapper_header">
									<table class="gdzc_table_header">
										<tr>
											<th style="width: 10%">科目名称</th>
											<th style="width: 10%;">明细科目名称</th>
											<th  style="width: 9%;">办公使用</th>
											<th style="width: 9%;">教学使用</th>
											<th style="width: 9%;">培训使用</th>
											<th style="width: 9%;">执法执勤</th>
											<th style="width: 9%;">窗口使用</th>
											<th style="width: 9%;">用于公共服务对象</th>
											<th style="width: 9%;">专业用途</th>
											<th style="width: 9%;">其他业务使用</th>
										</tr>
									</table>
								</div>
								<div class="table_wapper_cont">
									<#if detailCursor?size gt 0>
										<table class="gdzc_table clearfix" id="gdzc_table">
											<tr class="table_inner_header">
												<td style="width: 10%;">合计</td>
												<td style="width: 10%;"></td>
												<td style="text-align: right;width: 9%;">${(totalBgsy/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalJxsy/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalPxsy/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalZfzq/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalCksy/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalGgfw/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalZysy/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right;width: 9%;">${(totalQtyw/10000)?string("0.00")}&nbsp;</td>
											</tr>
											<tr>
												<td rowspan="${detailCursor?size + 1}">固定资产</td>
											</tr>
											<#list detailCursor as obj>
												<tr>
													<td>${obj["DL"]}&nbsp;</td>
													<td style="text-align: right;">${(obj["BGJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["JXJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["PXJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["ZQJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["CKJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["GGJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["ZYJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right;">${(obj["QTJIAZ"]/10000)?string("0.00")}&nbsp;</td>
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
				$(function(){

					//数据格式
					var data1 = {legend:${ytflLegend},
								data:${ytflCntList}
					}

					var data2 = {legend:${ytflLegend},
								data:${ytflPriceList}
					}

					/* 创建实例 —— BEGIN */
					//固定资产用途分类情况图（按卡片数量分析）
					var pie1 = echarts.init(document.getElementById('pie1'));

					//固定资产用途分类情况图（按卡片价值分析）
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

					//固定资产用途分类情况图（按卡片数量分析）
					pie_option(data1,pie1,"option1",condition);

					//固定资产用途分类情况图（按卡片数量分析）
					pie_option(data2,pie2,"option2",condition);
					/* 生成图表 —— END */

					//给页面table设置最大的高度
					tableMaxHeight(10);

					//图表响应式
					window.onresize = function(){
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

					//判断滚动条
					function checkScrollBar(){
						var wapper_height = $(".chart_row_cont_inner").height() - $(".query_box_inner").height() - 10;
						var t_height = wapper_height - $(".table_wapper_header").height() -5;
						if($(".table_wapper_cont table").height() <= t_height){
							$(".table_wapper_header").css({"padding-right":"0px"});
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
								$(".chart_row_table").height("80%");
								checkScrollBar();
							}else{
								$(".chart_row_table").height("46%");
								checkScrollBar();
							}
						}
					})
				})
		</script>
	</body>
</html>