<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>所有资产 - 图片列表模式</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
	</head>

	<body>
		<div class="container_card">
			<div class="main_tabs">
				<div class="container">
					<ul class="main_tabs_list">
						<li><a class="active" href="">所有资产</a><span class="sanjx_jt active"></span></li>
						<li><a href="">待收货</a><span class="sanjx_jt"></span></li>
						<li><a href="">待维修</a><span class="sanjx_jt"></span></li>
						<li><a href="">待转移</a><span class="sanjx_jt"></span></li>
						<li><a href="">待处置</a><span class="sanjx_jt"></span></li>
					</ul>
				</div>
			</div>
			<div class="toolbar_wapper container">
				<#-- 声明一个名为 queryUrl 的变量，并为其传入查询时需要访问的 URL -->
				<#assign queryUrl = "${request.contextPath}/orgHome/main" />
				<#-- 导入工具栏模板 -->
				<#include "/base/toolbar_box_org.ftl" />
			</div>
			<div class="list_wapper container">
				<div class="list_wapper_header">
					<table class="list_table_header">
						<colgroup>
							<col width="20%"></col>
							<col width="12%"></col>
							<col width="10%"></col>
							<col width="7%"></col>
							<col width="10%"></col>
							<col width="7%"></col>
							<col width="14%"></col>
							<col width="10%"></col>
							<col width="10%"></col>
						</colgroup>
						<tr>
							<td class="sort">
								<a href="javascript: void(0)">
									资产名称
									<span class="card_order_jt" column="ZICMC"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									规格型号
									<span class="card_order_jt" column="GUIGXH"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									单价（元）
									<span class="card_order_jt" column="DANJ"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									数量
									<span class="card_order_jt" column="SHUL"></span>
								</a>
							</td>
							<td>物品操作</td>
							<td class="sort">
								<a href="javascript: void(0)">
									价值
									<span class="card_order_jt" column="JIAZ"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									使用部门（人）
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									资产状态
									<span class="card_order_jt" column="SHIYZK"></span>
								</a>
							</td>
							<td>业务操作</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<colgroup>
							<col width="20%"></col>
							<col width="12%"></col>
							<col width="10%"></col>
							<col width="7%"></col>
							<col width="10%"></col>
							<col width="7%"></col>
							<col width="14%"></col>
							<col width="10%"></col>
							<col width="10%"></col>
						</colgroup>
						<#list page.results as obj>
							<tr class="list_infolist">
								<td colspan="9">
									<ul>
										<li>${obj_index + 1}</li>
										<li class="list_td_label"><label class="list_label fl"><input class="chk" type="checkbox" value="${obj['RWID']}" price="${obj['JIAZ']}" /></label></li>
										<li>购置日期：${obj["GOUZRQ"]}</li>
										<li>资产编号：${obj["OBJCODE"]}</li>
										<li>财务入账日期：${obj["CAIWRZRQ"]}</li>
										<li class="infolist_fskp"><a href="javascript:void(0)">附属卡片n张</a></li>
									</ul>
								</td>
							</tr>
							<tr class="list_imglist">
								<td class="list_img_item">
									<div class="list_img_wapper">
										<div class="list_img_content">
											<#if obj["FILENAME1"]??>
												<img src="${prefixPath}/FileFolder/${obj['FILENAME1']}.${obj['EXTENSION1']}" />
											<#else>
												<img src="${request.contextPath}/static/image/errorload.png" />
											</#if>
										</div>
									</div>
									<a class="list_name_wapper" href="javascript: void(0)" rwid="${obj['RWID']}" objectid="${obj['OBJECTID']}">${obj["ZICMC"]}</a>
									<div class="list_marks">
										<ul>
											<#-- 导入卡片标签模板 -->
											<#include "/base/card_tips.ftl" />
										</ul>
									</div>
								</td>
								<td>${obj["GUIGXH"]}</td>
								<td>${obj["DANJ"]}</td>
								<td>${obj["SHUL"]}</td>
								<td>
									<div class="wpcz_wapper">
										<div class="wpcz_sqbx"><a href="javascript:void(0)">申请报修</a></div>
										<div class="wpcz_sqzy"><a href="javascript:void(0)">申请转移</a></div>
										<div class="wpcz_sqcz"><a href="javascript:void(0)">申请处置</a></div>
									</div>
								</td>
								<td>${obj["JIAZ"]}</td>
								<td>${obj["SHIYBM"]}<#if obj["SHIYR"]??>（${obj["SHIYR"]}）</#if></td>
								<td>${obj["SHIYZK"]}</td>
								<td></td>
							</tr>
						</#list>
					</table>
				</div>
			</div>
		</div>
		<#-- 导入更多筛选主模板 -->
		<#include "/org/home/filter_form_main.ftl" />

		<div class="total_price">
			<div class="container">
				您所选的资产共计：<span id="total_number">0</span>&nbsp;条，金额共计：<span id="total_price">0.00</span>&nbsp;元
			</div>
		</div>

		<#include "/base/base_org_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
		<script>
			$(function(){

				setMaxheight(0);

				// 生成日历
				$("#gouzrq_begin").ligerDateEditor();
				$("#gouzrq_end").ligerDateEditor();
				$("#caiwrzrq_begin").ligerDateEditor();
				$("#caiwrzrq_end").ligerDateEditor();
				$("#kxdateBegin").ligerDateEditor();
				$("#kxdateEnd").ligerDateEditor();

			})
			window.onresize = function(){
				setMaxheight(0);
			}
		</script>
	</body>
</html>