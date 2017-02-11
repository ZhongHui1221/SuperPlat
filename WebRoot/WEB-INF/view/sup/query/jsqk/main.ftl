<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>减少情况</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body>
		<div class="container_box">
			<div class="top_deff"></div>
			<div class="chart_row chart_row_chart" style="height: 46%">
				<div class="chart_box pr fl">
					<div class="chart_box_header">固定资产减少情况图（按卡片数量分析）<span></span></div>
					<div id="pie1" style="width: 100%; height: 90%"></div>
				</div>
				<div class="chart_box fr">
					<div class="chart_box_header">固定资产减少情况图（按卡片价值分析）<span></span></div>
					<div id="pie2" style="width: 100%; height: 90%"></div>
				</div>
			</div>
			<div class="chart_row chart_row_table" style="height: 50%">
				<div class="table_box">
					<div class="chart_box_header">
						固定资产减少情况明细表
						<span></span>
						<div class="slide_toggle"></div>
					</div>
					<div class="chart_row_cont">
							<div class="chart_row_cont_inner">
								<div class="query_box query_box_inner">
									<div class="query_info">购置日期：</div>
									<form id="query_form" action="${request.contextPath}/Query/Jsqk/main" method="get">
										<div class="query_select">
											<select id="selectType" name="selectType">
												<option value="mouth">本月</option>
												<option value="year">本年</option>
												<option value="zdy">自定义</option>
											</select>
										</div>
										<div class="query_box_zdy">
											<input type="text" id="beginDateStr" name="beginDateStr" value="${beginDateStr}" />
											<div class="query_info" style="margin: 0px 8px">至</div>
											<input type="text" id="endDateStr" name="endDateStr" value="${endDateStr}" />
											<div class="query_button">
												查询<div class="query_button_tips">起始日期不能大于截止日期！</div>
											</div>
										</div>
									</form>
									<div class="table_tips"><span>单位：万元</span></div>
								</div>
									<div class="table_wapper">
									<div class="table_wapper_header">
										<table class="gdzc_table_header">
											<tr>
												<th style="width: 10%">科目名称</th>
												<th style="width: 10%">明细科目名称</th>
												<th style="width: 8%">无偿调拨</th>
												<th style="width: 8%">对外捐赠</th>
												<th style="width: 8%">出售（出让、转让）</th>
												<th style="width: 8%">报废</th>
												<th style="width: 8%">对外投资</th>
												<th style="width: 8%">信息更正</th>
												<th style="width: 8%">报损</th>
												<th style="width: 8%">置换</th>
												<th style="width: 8%">减持股份</th>
											</tr>
										</table>
									</div>
									<div class="table_wapper_cont">
									<#if detailCursor?size gt 0>
										<table class="gdzc_table clearfix" id="gdzc_table">
											<tr class="table_inner_header">
												<td style="width: 10%">合计</td>
												<td style="width: 10%"></td>
												<td style="text-align: right; width: 8%">${(totalWcdb/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right; width: 8%">${(totalDwjz/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right; width: 8%">${(totalCs/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right; width: 8%">${(totalBf/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right; width: 8%">${(totalDwtz/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right; width: 8%">${(totalXxgz/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right; width: 8%">${(totalBs/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right; width: 8%">${(totalZh/10000)?string("0.00")}&nbsp;</td>
												<td style="text-align: right; width: 8%">${(totalJcgf/10000)?string("0.00")}&nbsp;</td>
											</tr>
											<tr>
												<td rowspan="${detailCursor?size + 1}">固定资产</td>
											</tr>
											<#list detailCursor as obj>
												<tr>
													<td>${obj["DL"]}&nbsp;</td>
													<td style="text-align: right">${(obj["WCDBJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["DWJZJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["CSDBJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["BFJZJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["TZJZJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["GZJZJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["BSJZJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["ZHIHJIAZ"]/10000)?string("0.00")}&nbsp;</td>
													<td style="text-align: right">${(obj["JCGFJIAZ"]/10000)?string("0.00")}&nbsp;</td>
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
		<script src="${request.contextPath}/static/js/charts.js"></script>
		<script>

			$(function() {

				/* 数据组装 —— BEGIN */
				var data1 = {
					legend: ${jsqkLegend},
					data: ${jsqkCntList}
				};

				var data2 = {
					legend: ${jsqkLegend},
					data: ${jsqkPriceList}
				};
				/* 数据组装 —— END */

				/* 创建实例 —— BEGIN */
				// 固定资产减少情况图（按卡片数量分析）
				var pie1 = echarts.init(document.getElementById("pie1"));

				// 固定资产减少情况图（按卡片价值分析）
				var pie2 = echarts.init(document.getElementById("pie2"));
				/* 创建实例 —— END */

				/* 生成图表 —— BEGIN */
				// 固定资产减少情况图（按卡片数量分析）
				pie_option_noclick(data1, pie1, "option1");

				// 固定资产减少情况图（按卡片价值分析）
				pie_option_noclick(data2, pie2, "option2");
				/* 生成图表 —— END */

				// 查询
				$(".query_button").click(function() {
					var begin = $("#beginDateStr").val();
					var end = $("#endDateStr").val();
					if (compareDate(begin,end)) {
						// 获取当前选中页签的 tabid
						var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
						// 获取当前显示的 iframe
						var $iframe = $(window.parent.document).find("iframe[id='" + tabid + "']");
						// 页面加载动画
						$iframe.prev(".l-tab-loading").show();
						// 表单提交
						$("#query_form").submit();
					} else {
						if($(".query_button_tips").css("display") == "none"){
							$(".query_button_tips").fadeIn(200).delay(1000).fadeOut(400);
						}
					}
				});

				// 生成日历
				<#if beginDateStr?? && endDateStr??>
					$("#beginDateStr").ligerDateEditor();
					$("#endDateStr").ligerDateEditor();
				<#else>
					var query_date = getNowFormatDate(2);
					$("#beginDateStr").ligerDateEditor({initValue: query_date.begin});
					$("#endDateStr").ligerDateEditor({initValue: query_date.end});
				</#if>

				// 查询类型
				$("#selectType").val("${selectType}");
				<#if selectType == "zdy">
					$(".query_box_zdy").show();
				</#if>

				// 将日历文本框设为只读
				$("#endDateStr, #beginDateStr").attr("readonly", true);

				// 查询切换
				$("#selectType").change(function() {
					var val = $(this).val();
					if (val == "zdy") {
						$(".query_box_zdy").show();
					} else {
						// 获取当前选中页签的 tabid
						var tabid = $(window.parent.document).find("li[class='l-selected']").attr("tabid");
						// 获取当前显示的 iframe
						var $iframe = $(window.parent.document).find("iframe[id='" + tabid + "']");
						// 页面加载动画
						$iframe.prev(".l-tab-loading").show();
						// 表单提交
						$("#query_form").submit();
					}
				});

				// 响应式图表
				window.onresize = function() {
					tableMaxHeight(6);
					checkScrollBar();
					pie1.resize();
					pie2.resize();
				};

				// 给页面 table 设置最大高度
				tableMaxHeight(6);

				// 获取当前日期
				// sth：1 = 今天，2 = 本月，3 = 本年
				function getNowFormatDate(sth) {
					var date = new Date();
					var seperator1 = "-";
					var year = date.getFullYear();
					var month = date.getMonth() + 1;
					var strDate = date.getDate();
					if (month >= 1 && month <= 9) {
						month = "0" + month;
					}
					if (strDate >= 0 && strDate <= 9) {
						strDate = "0" + strDate;
					}
					if (sth == 1) {
						var currentdate = year + seperator1 + month + seperator1 + strDate;
					} else if (sth == 2) {
						var curmonthmays = new Date(date.getFullYear(), (date.getMonth() + 1), 0).getDate();
						var currentdate = {};
						currentdate.begin = year + seperator1 + month + seperator1 + "01";
						currentdate.end = year + seperator1 + month + seperator1 + curmonthmays;
					} else if (sth == 3) {
						var currentdate = {};
						currentdate.begin = year + seperator1 + "01" + seperator1 + "01";
						currentdate.end = year + seperator1 + "12" + seperator1 + "31";
					}
					return currentdate;
				}

				// 日期比较
				function compareDate(date1, date2) {
					var odate1 = new Date(date1.replace(/\-/g, "\/"));
					var odate2 = new Date(date2.replace(/\-/g, "\/"));
					if (odate1.getTime() > odate2.getTime()) {
						return false;
					} else {
						return true;
					}
				}

				// 判断滚动条
				function checkScrollBar() {
					var t_height = $(".table_wapper_cont table").height();
					var b_height = $(".table_wapper_cont").height();
					if (t_height <= b_height) {
						$(".table_wapper_header").css({"padding-right": "0"});
						$(".table_wapper_cont").css("overflow-y", "hidden");
						return false;
					} else {
						$(".table_wapper_header").css({"padding-right": "17px"});
						$(".table_wapper_cont").css("overflow-y", "auto");
						return true;
					}
				}

				function tableMaxHeight(hDeff) {
					var contHeight = $(".chart_row_cont").height();
					var queryHeight = $(".query_box_inner").height();
					$(".table_wapper").height(contHeight - queryHeight - hDeff);
					$(".table_wapper_cont").height(contHeight - queryHeight - 30 - hDeff);
				}

				var checkscrollbar = checkScrollBar();

				// 表格上拉切换
				$(".slide_toggle").click(function() {
					$(".chart_row_chart").slideToggle(100);
					$(this).toggleClass("active");
					if (checkscrollbar) {
						if ($(this).hasClass("active")) {
							$(".chart_row_table").height("70%");
							$(".table_wapper_header").css({"padding-right": "0"});
						} else {
							$(".chart_row_table").height("46%");
							$(".table_wapper_header").css({"padding-right": "17px"});
						}
					}
				});

			});

		</script>
	</body>
</html>