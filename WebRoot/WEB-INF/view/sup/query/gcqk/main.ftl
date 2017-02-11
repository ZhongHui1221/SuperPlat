<!DOCTYPE html>
<html class="html_media">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<title>构成情况</title>
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
					<div class="chart_box_header">固定资产构成情况图（按卡片数量分析）<span></span></div>
					<div id="bar1" style="width: 100%; height: 100%"></div>
					<div class="danwei_bar">单位：张</div>
				</div>
				<div class="chart_box fr chart_box_media">
					<div class="chart_box_header">固定资产构成情况图（按卡片价值分析）<span></span></div>
					<div id="pie1" style="width: 100%; height: 90%"></div>
				</div>
			</div>
			<div class="chart_row chart_row_table chart_row_table_media" style="height: 50%">
				<div class="table_box">
					<div class="chart_box_header">
						固定资产构成情况明细表
						<span></span>
						<div class="slide_toggle"></div>
					</div>
					<div class="chart_row_cont">
						<div class="chart_row_cont_inner chart_row_cont_inner_media">
							<div class="query_box query_box_inner">
								<form id="query_form" action="${request.contextPath}/Query/Gcqk/main" method="get">
									<div class="query_info">购置日期：</div>
									<input id="dateStr" name="dateStr" type="text" value="${dateStr}" />
									<div class="query_button">查询</div>
								</form>
								<div class="table_tips">*下表中的数据是以卡片中的购置日期为统计口径</div>
							</div>
							<div class="table_wapper">
								<div class="table_wapper_header">
									<table class="gdzc_table_header">
										<tr>
											<th style="width: 15%">科目名称</th>
											<th style="width: 25%">明细科目名称</th>
											<th style="width: 20%">数量（张）</th>
											<th style="width: 20%">价值（万元）</th>
											<th style="width: 20%; border-right: none">业务操作</th>
										</tr>
									</table>
								</div>
								<div class="table_wapper_cont table_wapper_cont_media">
									<#if gcqkCursor?size gt 0>
										<table class="gdzc_table clearfix" id="gdzc_table">
											<tr class="table_inner_header">
												<td style="width: 15%">合计</td>
												<td style="width: 25%"></td>
												<td style="text-align: right; width: 20%">${totalNum}&nbsp;</td>
												<td style="text-align: right; width: 20%">${(totalPrice / 10000)?string("0.00")}&nbsp;</td>
												<td style="width: 20%"></td>
											</tr>
											<tr id="table_info">
												<td rowspan="${gcqkCursor?size + 1}">固定资产</td>
											</tr>
											<#list gcqkCursor as obj>
												<tr>
													<td>${obj["ZICDL"]}&nbsp;</td>
													<td style="text-align: right">${obj["CNT"]}&nbsp;</td>
													<td style="text-align: right">${(obj["JIAZ"] / 10000)?string("0.00")}&nbsp;</td>
													<td><a class="a_tocardslist" href="javascript: void(0);" dlid="${obj["ZICDLID"]}">查看卡片明细</a></td>
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
				//获得当前选中iframe的tabid
				var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");

				/* 数据组装 —— BEGIN */
				var data1 = {
					legend: ${gcqkLegend},
					data: ${gcqkCntList}
				};

				var data2 = {
					legend: ${gcqkLegend},
					data: ${gcqkPriceList}
				};
				/* 数据组装 —— END */

				/* 创建实例 —— BEGIN */
				// 固定资产构成情况图（按卡片数量分析）
				var bar1 = echarts.init(document.getElementById('bar1'));

				// 固定资产构成情况图（按卡片价值分析）
				var pie1 = echarts.init(document.getElementById('pie1'));

				/* 创建实例 —— END */

				var condition = {
					targetTabId: "card_list",
					targetTabTitle: "卡片列表",
					targetTabUrl: "${request.contextPath}/Query/BsAstCard/list",
					fromModel:tabid,
					dateStr: "${dateStr}"
				};

				// 固定资产构成情况图（按卡片数量分析）
				pie_option(data2,pie1,"option1",condition);

				// 固定资产构成情况图（按卡片价值分析）
				bar_option(data1,bar1,"option2",condition);

				// 生成日历
				$("#dateStr").ligerDateEditor();
				//input框禁止编辑
				$("#dateStr").attr("readonly",true);

				// 查询
				$(".query_button").click(function() {
					// 获取当前显示的 iframe
					var $iframe = $(window.parent.document).find("iframe[id='" + tabid + "']");
					// 页面加载动画
					$iframe.prev(".l-tab-loading").show();
					// 表单提交
					$("#query_form").submit();
				});

				//表格查看卡片明细操作
				$(".a_tocardslist").click(function(){
					window.parent.f_addTab("card_list", "卡片列表");
					//获取本记录大类id
					var dlid = $(this).attr("dlid");

					//获得当前选中iframe的tabid
					var tabid1 = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
					var $div = $(window.parent.document).find("div[tabid='" + tabid1 + "']");
					// 每次创建元素前清空iframe容器内的内容
					$div.empty();
					var htmlStr = '<div class="l-tab-loading" style="display: block"></div>';
					htmlStr += '<iframe id="' + tabid1 + '" name="' + tabid1 + '" src="${request.contextPath}/Query/BsAstCard/list" frameborder="0"></iframe>';
					htmlStr += '<form id="' + tabid1 + '" action="${request.contextPath}/Query/BsAstCard/list" target="' + tabid1 + '" method="post">';
					htmlStr += '<input name="fromModel" type="hidden" value="' + tabid + '" />';
					htmlStr += '<input name="dateStr" type="hidden" value="${dateStr}" />';
					htmlStr += '<input name="zicdlrwidStr" type="hidden" value="' + dlid + '" />';
					htmlStr += '</form>';
					$div.append(htmlStr);
					$(window.parent.document).find("form[id='" + tabid1 + "']").submit();
				});

				// 响应式图表
				window.onresize = function() {
					tableMaxHeight(6);
					checkScrollBar();
					// 判断浏览器版本是否为IE8，对IE8的图表生成做延时处理
					if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
						$(".chart_row_table_media").css("height", "215px!important");
						setTimeout(chartResize,200);
					}else{
						chartResize();
					}
				};

				// 判断浏览器版本是否为IE8，对IE8的图表生成做延时处理
				if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8."){
					setTimeout(chartResize,200);
				}

				// 给页面table设置最大的高度
				tableMaxHeight(6);

				// 图表自适应
				function chartResize(){
					bar1.resize();
					pie1.resize();
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

				function tableMaxHeight(hDeff){
					var contHeight = $(".chart_row_cont").height();
					var queryHeight = $(".query_box_inner").height();
					$(".table_wapper").height(contHeight - queryHeight - hDeff);
					$(".table_wapper_cont").height(contHeight - queryHeight - 30 - hDeff);
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