<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>卡片列表 - 列表模式</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body class="card_body">
		<div class="container_box container_card">
			<div class="toolbar_wapper">
				<#-- 移除更多筛选条件 -->
				<#assign noFilter = true />
				<#-- 声明一个名为 queryUrl 的变量，并为其传入查询时需要访问的 URL -->
				<#assign queryUrl = "${request.contextPath}/Query/BsAstCard/list" />
				<#-- 声明一个名为 exportUrl 的变量，并为其传入导出时需要访问的 URL（暂时屏蔽维修情况导出）-->
				<#if fromModel != "wxqk_main"><#assign exportUrl = "${request.contextPath}/Query/BsAstCard/exportExcel" /></#if>
				<#-- 导入工具栏模板 -->
				<#include "/base/toolbar_box.ftl" />
			</div>
			<div class="list_wapper">
				<div class="list_wapper_header">
					<table class="list_table_header">
						<tr>
							<td style="width: 3%"></td>
							<td class="sort" style="width: 10%">
								<a href="javascript: void(0)">
									资产名称
									<span class="card_order_jt" column="ZICMC"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript: void(0)">
									资产编号
									<span class="card_order_jt" column="OBJCODE"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript: void(0)">
									规格型号
									<span class="card_order_jt" column="GUIGXH"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript: void(0)">
									购置日期
									<span class="card_order_jt" column="GOUZRQ"></span>
								</a>
							</td>
							<td class="sort" style="width: 12%">
								<a href="javascript: void(0)">
									财务入账日期
									<span class="card_order_jt" column="CAIWRZRQ"></span>
								</a>
							</td>
							<td class="sort" style="width: 6%">
								<a href="javascript: void(0)">
									数量
									<span class="card_order_jt" column="SHUL"></span>
								</a>
							</td>
							<td class="sort" style="width: 9%">
								<a href="javascript: void(0)">
									计量单位
									<span class="card_order_jt" column="JILDW"></span>
								</a>
							</td>
							<td class="sort" style="width: 8%">
								<a href="javascript: void(0)">
									价值
									<span class="card_order_jt" column="JIAZ"></span>
								</a>
							</td>
							<td class="sort" style="width: 9%">
								<a href="javascript: void(0)">
									资产状态
									<span class="card_order_jt" column="SHIYZK"></span>
								</a>
							</td>
							<td class="sort" style="width: 11%">
								<a href="javascript: void(0)">
									单位名称
									<span class="card_order_jt" column="DANWMC"></span>
								</a>
							</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<#list page.results as obj>
							<tr <#if obj_index % 2 != 0>style="background: #fafafa"</#if>>
								<td style="width: 3%" class="list_td_label"><label class="list_label fl"><input class="chk" type="checkbox" value="${obj['RWID']}" price="${obj['JIAZ']}" /></label></td>
								<td style="width: 10%"><a class="item_card_info_list" href="javascript: void(0)" rwid="${obj['RWID']}" editable="1">${obj["ZICMC"]}</a></td>
								<td style="width: 10%">${obj["OBJCODE"]}</td>
								<td style="width: 10%">${obj["GUIGXH"]}</td>
								<td style="width: 10%">${obj["GOUZRQ"]}</td>
								<td style="width: 12%"><#if obj["CAIWRZRQ"]??>${obj["CAIWRZRQ"]}<#else>未登账</#if></td>
								<td style="width: 6%">${obj["SHUL"]}</td>
								<td style="width: 9%">${obj["JILDW"]}</td>
								<td style="width: 8%">${obj["JIAZ"]}</td>
								<td style="width: 9%">${obj["SHIYZK"]}</td>
								<td style="width: 11%">${obj["DANWMC"]}</td>
							</tr>
						</#list>
					</table>
				</div>
			</div>
		</div>
		<div class="total_price">
			<div class="container_box">
				您所选的资产共计：<span id="total_number">0</span>&nbsp;条，金额共计：<span id="total_price">0.00</span>&nbsp;元
			</div>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script>
			$(function(){
				setMaxheight(36);
			})
			window.onresize = function(){
				setMaxheight(36);
			}
		</script>
	</body>
</html>