<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>处置待审批</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body class="card_body">
		<div class="container_box container_card">
			<div class="toolbar_wapper">
				<#-- 移除视图切换按钮 -->
				<#assign noViewMode = true />
				<#-- 声明一个名为 queryUrl 的变量，并为其传入查询时需要访问的 URL -->
				<#assign queryUrl = "${request.contextPath}/Query/Czqk/czdsp" />
				<#-- 声明一个名为 printFunction 的变量，并指定打印操作需要执行的 JS 函数 -->
				<#assign printFunction = "printHTML('处置待审批')" />
				<#-- 导入工具栏模板 -->
				<#include "/base/toolbar_box.ftl" />
			</div>
			<div class="list_wapper">
				<div class="list_wapper_header">
					<table class="list_table_header">
						<tr>
							<td style="width: 4%"><div class="xuhao_header">序号</div></td>
							<td style="width: 4%"></td>
							<td class="sort" style="width: 10%">
								<a href="javascript:void(0)">
									申报单号
									<span class="card_order_jt" column="SHENBDH"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript:void(0)">
									处置方式
									<span class="card_order_jt" column="CHUZFS"></span>
								</a>
							</td>
							<td class="sort" style="width: 11%">
								<a href="javascript:void(0)">
									申请时间
									<span class="card_order_jt" column="SHENQSJ"></span>
								</a>
							</td>
							<td class="sort" style="width: 7%">
								<a href="javascript:void(0)">
									数量
									<span class="card_order_jt" column="SHUL"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript:void(0)">
									原值（元）
									<span class="card_order_jt" column="JIAZ"></span>
								</a>
							</td>
							<td class="sort" style="width: 15%">
								<a href="javascript:void(0)">
									累计折旧（摊销）
									<span class="card_order_jt" column="LEIJZJ"></span>
								</a>
							</td>
							<td class="sort" style="width: 9%">
								<a href="javascript:void(0)">
									净值（元）
									<span class="card_order_jt" column="JINGZ"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript:void(0)">
									评估价值
									<span class="card_order_jt" column="PINGGJZ"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript:void(0)">
									单据状态
									<span class="card_order_jt" column="PIFZT"></span>
								</a>
							</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<#list page.results as obj>
							<tr <#if obj_index % 2 != 0>style="background-color: #fafafa"</#if>>
								<td style="width: 4%; background: #fafafa" class="xuhao">${obj_index + 1}</td>
								<td class="list_td_label" style="width: 4%">
									<label class="list_label fl"><input class="chk" type="checkbox" /></label>
								</td>
								<td style="width: 10%"><a href="javascript: void(0)">${obj["SHENBDH"]}</a></td>
								<td style="width: 10%">${obj["CHUZFS"]}</td>
								<td style="width: 11%">${obj["SHENQSJ"]}</td>
								<td style="width: 7%">${obj["SHUL"]}</td>
								<td style="width: 10%">${obj["JIAZ"]}</td>
								<td style="width: 15%">${obj["LEIJZJ"]}</td>
								<td style="width: 9%">${obj["JINGZ"]}</td>
								<td style="width: 10%">${obj["PINGGJZ"]}</td>
								<td style="width: 10%"><a href="javascript: void(0)">${obj["PIFZT"]}</a></td>
							</tr>
						</#list>
					</table>
				</div>
			</div>
		</div>
		<form class="filter_form" action="${request.contextPath}/Query/Czqk/czdsp" method="post">
			<div class="more_search">
				<div class="more_search_main">
					<table>
						<tr>
							<td class="more_search_item">申报单号：</td>
							<td><input name="shenbdh" type="text" value="${shenbdh}" placeholder="可模糊查询申报单号" /></td>
							<td class="more_search_item">处置方式：</td>
							<td>
								<select name="czfsid">
									<option value="">请选择…</option>
									<#list czfsList as obj>
										<option value="${obj.rwid}" <#if obj.rwid == czfsid>selected</#if>>${obj.objname}</option>
									</#list>
								</select>
							</td>
						</tr>
						<tr class="search_date">
							<td class="more_search_item">申请时间：</td>
							<td class="search_datebox"><input id="shenqsj_begin" name="shenqsj_begin" type="text" value="${shenqsj_begin}" /></td>
							<td class="more_search_item" style="text-align: center">
								至
								<div class="query_button_tips">起始日期不能大于截止日期！</div>
							</td>
							<td class="search_datebox"><input id="shenqsj_end" name="shenqsj_end" type="text" value="${shenqsj_end}" /></td>
						</tr>
						<tr>
							<td class="more_search_item">数量：</td>
							<td><input name="shul_min" type="text" value="${shul_min}" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="shul_max" type="text" value="${shul_max}" /></td>
						</tr>
						<tr>
							<td class="more_search_item">净值：</td>
							<td><input name="jingz_min" type="text" value="${jingz_min}" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="jingz_max" type="text" value="${jingz_max}" /></td>
						</tr>
					</table>
				</div>
				<div class="more_search_bottom">
					<div class="iframe_btn iframe_btn_qk">清空</div>
					<input type="submit" class="iframe_btn iframe_btn_qd" value="确定" />
					<div class="iframe_btn iframe_btn_qx">取消</div>
				</div>
			</div>
		</form>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
		<script>

			window.onresize = function() {
				setMaxheight(0);
			}

			$(function() {

				setMaxheight(0);

				// 更多搜索框生成日历
				$("#shenqsj_begin").ligerDateEditor();
				$("#shenqsj_end").ligerDateEditor();
				$("#shenqsj_begin, #shenqsj_end").attr("readonly", true);

			});

		</script>
	</body>
</html>