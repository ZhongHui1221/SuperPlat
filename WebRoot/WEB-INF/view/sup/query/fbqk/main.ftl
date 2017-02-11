<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>分布情况</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body>
		<div class="container_box">
			<div class="bread_menu_wapper">
				<div class="fl bread_menu">
					<span>当前位置：</span>
					<#list orgs as obj>
						<#if obj_has_next>
							<a href="${request.contextPath}/Query/Fbqk/main/0/${obj.rwid}" onclick="displayLoad()">${obj.objname}</a>
						<#else>
							<#-- 路径的末项使用特殊样式，并禁止点击 -->
							<a class="bread_menu_last">${obj.objname}</a>
						</#if>
						<#-- 去除路径末尾的尖括号 -->
						<#if obj_has_next><i>></i></#if>
					</#list>
				</div>
			</div>
			<div class="container_inner_fb">
				<div class="chart_box_header">资产分布情况表<span></span></div>
				<div class="chart_row_cont_fb">
					<div class="chart_row_cont_inner">
						<div class="query_box query_box_inner">
							<div class="table_tips">*下表中的数据是以卡片中的购置日期为统计口径</div>
						</div>
						<div class="table_wapper_coontent">
							<div class="table_wapper_header">
								<table class="gdzc_table_header">
									<tr>
										<th style="width: 35%">单位名称</th>
										<th style="width: 20%">卡片数量（张）</th>
										<th style="width: 20%">价值（万元）</th>
										<th style="width: 25%;border-right:none;">所占比例</th>
									</tr>
								</table>
							</div>
							<div class="table_wapper_cont">
								<table class="gdzc_table clearfix" id="gdzc_table">
									<#list fbqkCursor as obj>
										<tr class="table_inner_header">
											<td style="width: 35%">${obj["OBJNAME"]}</td>
											<td style="width: 20%">${obj["CNT"]}</td>
											<td style="width: 20%">${(obj["JIAZ"] / 10000)?string("0.00")}</td>
											<td style="width: 25%">
												<a class="fenbu_jdt_wapper"
													<#if extra == "xzfc">
														href="javascript: void(0)" onclick="toCardList('${obj["TYPE"]}', '${obj["BMID"]}', 'xzfc')"
													<#else>
														<#if (obj["TYPE"] == 0) || (obj["TYPE"] == 2)>
															href="${request.contextPath}/Query/Fbqk/main/${obj['TYPE']}/${obj['BMID']}" onclick="displayLoad()"
														<#elseif (obj["TYPE"] == 1) || (obj["TYPE"] == 3)>
															href="javascript: void(0)" onclick="toCardList('${obj["TYPE"]}', '${obj["BMID"]}', 'fbqk_main')"
														</#if>
													</#if>
												>
													<div class="fenbu_jdt"
														<#if obj["JIAZ"]??>
															style="width: ${obj["JIAZ"] / fbqkTotalJiaz * 100}%"
														</#if>
													></div>
												</a>
												<div class="fenbu_bfb">${obj["JIAZ"] / fbqkTotalJiaz * 100}%</div>
											</td>
										</tr>
									</#list>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script>

			// POST 方式新增“卡片列表”页签
			function toCardList(typeStr, idStr, fromModel) {
				var condition = {
					targetTabId: "card_list",
					targetTabTitle: "卡片列表",
					targetTabUrl: "${request.contextPath}/Query/BsAstCard/list",
					method: "post",
					shiyzkidStr: idStr,
					fbqkType: typeStr,
					fbqkOrgid: "${fbqkOrgid}",
					fbqkDeptid: "${fbqkDeptid}",
					fromModel: fromModel
				};
				addTabByForm(condition);
			}

			function checkHeight(heightDeff) {
				var c_height = $(".container_box").height() - 28;
				$(".container_inner_fb").height(c_height - heightDeff);
				$(".chart_row_cont_fb").height(c_height - 36);
				var q_height = $(".query_box_inner").height();
				$(".table_wapper_coontent").height(c_height - heightDeff - 36 - q_height);
				$(".table_wapper_cont").height(c_height - heightDeff - 64 - q_height)

			}

			window.onresize = function() {
				checkHeight(16);
			}

			$(function() {

				// 判断滚动条
				var t_height = $(".table_wapper_cont table").height();
				var b_height = $(".table_wapper_cont").height();
				if (t_height <= b_height) {
					$(".table_wapper_header").css({"padding-right": "0px"});
				}
				checkHeight(16);
			});

		</script>
	</body>
</html>