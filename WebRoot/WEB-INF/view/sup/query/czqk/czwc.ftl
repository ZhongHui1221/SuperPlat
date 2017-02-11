<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>处置完成</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body class="card_body">
		<div class="container_box container_card">
			<div class="toolbar_wapper">
				<#-- 移除视图切换按钮 -->
				<#assign noViewMode = true />
				<#-- 声明一个名为 queryUrl 的变量，并为其传入查询时需要访问的 URL -->
				<#assign queryUrl = "${request.contextPath}/Query/Czqk/symx" />
				<#-- 导入工具栏模板 -->
				<#include "/base/toolbar_box.ftl" />
			</div>
			<div class="list_wapper">
				<div class="list_wapper_header">
					<table class="list_table_header">
						<tr>
							<td style="width: 4%"><div class="xuhao_header">序号</div></td>
							<td style="width: 3%"></td>
							<td class="sort" style="width: 10%">
								<a href="javascript: void(0)">
									申报单号
									<span class="card_order_jt" column="SHENBDH"></span>
								</a>
							</td>
							<td class="sort" style="width: 9%">
								<a href="javascript: void(0)">
									处置方式
									<span class="card_order_jt" column="CHUZFS"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript: void(0)">
									批复单号
									<span class="card_order_jt" column="PIFDH"></span>
								</a>
							</td>
							<td class="sort" style="width: 9%">
								<a href="javascript: void(0)">
									批复数量
									<span class="card_order_jt" column="PIFSL"></span>
								</a>
							</td>
							<td class="sort" style="width: 11%">
								<a href="javascript: void(0)">
									已处置数量
									<span class="card_order_jt" column="XUANZSL"></span>
								</a>
							</td>
							<td class="sort" style="width: 14%">
								<a href="javascript: void(0)">
									已处置金额
									<span class="card_order_jt" column="XUANZJE"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript: void(0)">
									处置收益
									<span class="card_order_jt" column="CHUZSY"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript: void(0)">
									是否送财务
									<span class="card_order_jt" column="SHIFYSCW"></span>
								</a>
							</td>
							<td style="width: 8%">业务操作</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<#list page.results as obj>
							<tr <#if obj_index % 2 != 0>style="background-color: #fafafa"</#if>>
								<td style="width: 4%; background: #fafafa" class="xuhao">${obj_index + 1}</td>
								<td class="list_td_label" style="width: 3%">
									<label class="list_label fl"><input class="chk" type="checkbox" /></label>
								</td>
								<td style="width: 10%"><a href="javascript: void(0)" class="">${obj["SHENBDH"]}</a></td>
								<td style="width: 9%">${obj["CHUZFS"]}</td>
								<td style="width: 10%"><a href="javascript: void(0)">${obj["PIFDH"]}</a></td>
								<td style="width: 9%">${obj["PIFSL"]}</td>
								<td style="width: 11%">${obj["XUANZSL"]}</td>
								<td style="width: 14%">${obj["XUANZJE"]}</td>
								<td style="width: 10%">${obj["CHUZSY"]}</td>
								<td style="width: 10%">
									<#if obj["SHIFYSCW"] == "1">是<#else>否</#if>
								</td>
								<td style="width: 8%"><a href="javascript: void(0)">查看流程</a></td>
							</tr>
						</#list>
					</table>
				</div>
			</div>
		</div>
		<form action="${request.contextPath}/Query/Czqk/symx" method="post">
			<#-- 额外参数：1 = 处置完成 -->
			<input name="extra" type="hidden" value="1" />
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
						<tr>
							<td class="more_search_item">批复数量：</td>
							<td><input name="pifsl_min" type="text" value="${pifsl_min}" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="pifsl_max" type="text" value="${pifsl_max}" /></td>
						</tr>
						<tr>
							<td class="more_search_item">批复单号：</td>
							<td><input name="pifdh" type="text" value="${pifdh}" placeholder="可模糊查询批复单号" /></td>
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
		<script>

			$(function() {
				setMaxheight(0);
			});

			window.onresize = function() {
				setMaxheight(0);
			}

		</script>
	</body>
</html>