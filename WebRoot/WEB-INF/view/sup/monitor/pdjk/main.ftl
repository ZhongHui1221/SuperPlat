<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>盘点监控</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body class="card_body">
		<div class="container_box container_card">
			<div style="height: 2%"></div>
			<div class="bread_menu_wapper ">
				<div class="fl bread_menu bread_menu_pd">
					<span>当前位置：</span>
					<#list orgs as obj>
						<#if obj_has_next>
							<a href="${request.contextPath}/Monitor/Pdjk/main/${qcjzr}/0/${obj.rwid}" onclick="displayLoad()">${obj.objname}</a>
						<#else>
							<#-- 路径的末项使用特殊样式，并禁止点击 -->
							<a class="bread_menu_last">${obj.objname}</a>
						</#if>
						<#-- 去除路径末尾的尖括号 -->
						<#if obj_has_next><i>></i></#if>
					</#list>
				</div>
			</div>
			<div class="toolbar_wapper">
				<div class="toolbar_box">
					<div class="toolbar_left fl">
						<div class="pd_jizhunri fl">盘点基准日：</div>
						<div class="pd_timeselect fl">
							<form id="pdjk_main" action="${request.contextPath}/Monitor/Pdjk/main/0/0/0" method="get">
								<select id="qcjzr" name="qcjzr">
									<#list orgPdjzrCursor as obj>
										<#if obj["QINGCJZR"]??>
											<#assign qcjzrStr = obj["QINGCJZR"]?string("yyyy-MM-dd") />
											<option value="${qcjzrStr}"
												<#if qcjzrStr == qcjzr>selected</#if>
											>${qcjzrStr}</option>
										</#if>
									</#list>
								</select>
							</form>
						</div>
					</div>
					<div class="toolbar_right fr">
						<div class="toolbar_dy fl" onclick="printHTML('盘点监控')">
							打印 / 预览<span></span>
							<div class="tips_dy_wushuju">您未勾选数据，请选择需要打印的数据！</div>
						</div>
					</div>
				</div>
			</div>
			<div class="list_wapper">
				<div class="list_wapper_header">
					<table class="list_table_header">
						<tr>
							<td style="width: 4%"><div class="xuhao_header">序号</div></td>
							<td style="width: 19%">名称</td>
							<td style="width: 11%">账面数量（件）</td>
							<td style="width: 20%">盘点进度</td>
							<td style="width: 12%">完成盘点时间</td>
							<td style="width: 12%">无盈亏数量（件）</td>
							<td style="width: 11%">盘盈数量（件）</td>
							<td style="width: 11%">盘亏数量（件）</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<#list orgPddtCursor as obj>
							<tr class="list_pandian" <#if obj_index % 2 != 0>style="background-color: #fafafa"</#if>>
								<td style="width: 4%; background: #fafafa" class="xuhao">${obj_index + 1}</td>
								<td style="width: 19%"><a
									<#if qcjzr != 0>
										<#if obj["ISLEAF"]??>
											onclick="displayLoad()"
											href="${request.contextPath}/Monitor/Pdjk/main/0/0/${obj['ORGID']}"
										<#elseif (obj["STATFLDTYPE"] == 1) || (obj["STATFLDTYPE"] == 2)>
											href="javascript: void(0)" onclick="toCardList('${obj["STATFLDTYPE"]}', '${obj["STATFLDRWID"]}')"
										<#elseif obj["STATFLDTYPE"] == 3>
											onclick="displayLoad()"
											href="${request.contextPath}/Monitor/Pdjk/main/0/${obj['STATFLDTYPE']}/${obj['STATFLDRWID']}"
										</#if>
									</#if>
								>${obj["STATFLD"]}</a></td>
								<td style="width: 11%">${obj["ZMSL"]}</td>
								<td style="width: 20%">
									<a class="jindutiao_wapper"
										<#if qcjzr != 0>
											<#if obj["ISLEAF"]??>
												onclick="displayLoad()"
												href="${request.contextPath}/Monitor/Pdjk/main/0/0/${obj['ORGID']}"
											<#else>
												href="javascript: void(0)" onclick="toPdCard('${obj["STATFLDTYPE"]}', '${obj["STATFLDRWID"]}', 'wp')"
											</#if>
										</#if>
									>
										<div class="pandian_jdt_last">还剩 ${obj["WPSL"]} 件资产未盘点</div>
										<div class="pandian_jdt"
											<#if obj['ZMSL'] gt 0>
												style="width: ${(obj['ZMSL'] - obj['WPSL']) / obj['ZMSL'] * 100}%"
											<#else>
												style="width: 0%"
											</#if>
										></div>
									</a>
									<div class="fenbu_bfb">${obj["PDJD"]}%</div>
								</td>
								<td style="width: 12%"></td>
								<td style="width: 12%">
									<a
										<#if qcjzr != 0>
											<#if obj["ISLEAF"]??>
												onclick="displayLoad()"
												href="${request.contextPath}/Monitor/Pdjk/main/0/0/${obj['ORGID']}"
											<#else>
												href="javascript: void(0)" onclick="toPdCard('${obj["STATFLDTYPE"]}', '${obj["STATFLDRWID"]}', 'wyk')"
											</#if>
										</#if>
									>${obj["WYKSL"]}</a>
								</td>
								<td style="width: 11%">
									<a
										<#if qcjzr != 0>
											<#if obj["ISLEAF"]??>
												onclick="displayLoad()"
												href="${request.contextPath}/Monitor/Pdjk/main/0/0/${obj['ORGID']}"
											<#else>
												href="javascript: void(0)" onclick="toPdCard('${obj["STATFLDTYPE"]}', '${obj["STATFLDRWID"]}', 'py')"
											</#if>
										</#if>
									>${obj["PYSL"]}</a>
								</td>
								<td style="width: 11%">
									<a
										<#if qcjzr != 0>
											<#if obj["ISLEAF"]??>
												onclick="displayLoad()"
												href="${request.contextPath}/Monitor/Pdjk/main/0/0/${obj['ORGID']}"
											<#else>
												href="javascript: void(0)" onclick="toPdCard('${obj["STATFLDTYPE"]}', '${obj["STATFLDRWID"]}', 'pk')"
											</#if>
										</#if>
									>${obj["PKSL"]}</a>
								</td>
							</tr>
						</#list>
					</table>
				</div>
			</div>
		</div>
		<div class="total_price">
			<div class="container_box">
				无盈亏：<span>${wykTotalCount}</span>&nbsp;件、盘盈：<span>${pyTotalCount}</span>&nbsp;件、盘亏：<span>${pkTotalCount}</span>&nbsp;件
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您还有&nbsp;<span>${wpdTotalCount}</span>&nbsp;件资产未盘点
			</div>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script>

			// POST 方式新增“盘点卡片列表”页签
			function toCardList(queryType, rwid) {
				var condition = {
					targetTabId: "pd_card_list",
					targetTabTitle: "盘点卡片列表",
					targetTabUrl: "${request.contextPath}/Monitor/Pdjk/list",
					method: "post",
					fromModel: "pdjk_main",
					qcjzr: "${qcjzr}",
					pdjkType: queryType,
					pdjkRwid: rwid,
					pdjkOrgid: "${pdjkOrgid}",
					pdjkDeptid: "${pdjkDeptid}"
				};
				addTabByForm(condition);
			}

			// POST 方式新增“盘点卡片”页签
			function toPdCard(queryType, rwid, colType) {
				var condition = {
					targetTabId: "pd_card",
					targetTabTitle: "盘点卡片",
					targetTabUrl: "${request.contextPath}/Monitor/Pdjk/pdCard",
					method: "post",
					fromModel: "pdjk_main",
					qcjzr: "${qcjzr}",
					pdjkType: queryType,
					pdjkRwid: rwid,
					pdjkOrgid: "${pdjkOrgid}",
					pdjkDeptid: "${pdjkDeptid}",
					colType: colType
				};
				addTabByForm(condition);
			}

			window.onresize = function() {
				setMaxheight(70);
			}

			$(function() {
				setMaxheight(70);
				// 盘点基准日切换查询
				$("#qcjzr").change(function() {
					var qcjzr = $(this).val();
					$("#pdjk_main").prop("action", "${request.contextPath}/Monitor/Pdjk/main/" + qcjzr + "/0/${pdjkOrgid}");
					$("#pdjk_main").submit();
				});
			});

		</script>
	</body>
</html>