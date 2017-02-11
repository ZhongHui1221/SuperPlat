<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>平台首页</title>
		<link href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" />
		<style>
			html,body{height: 100%;}
			body{font-size: 14px;min-width: 690px;}
			.main_container{margin: 0 8%;height: 80%;min-height: 400px;}
			.main_list{display: block;min-height: 40px;height: 55%; background: #fafafa;border:1px solid #cccccc;padding: 10px;font-size: 13px;width: 170px;position: relative;}
			.main_list:hover{border-color: #f0f0f0;}
			.mian_list_icon{width: 40px;height: 40px;float: left;background-image: url(${request.contextPath}/static/image/mainicon.png);}
			.main_list_item{line-height: 20px;float: left;margin-left: 10px;color: #333;}
			.main_list_info{font-weight: bold;}
			.main_container_left{float: left;height: 100%;width: 192px;}
			.main_zczsl{background-position: 0px 0px;}
			.main_xzfcsj{margin-bottom: 0px;}
			.main_container_right{float: left;width: 60%;position: relative;margin-left: 6%;}
			.main_container_table{height: 40%;}
			table{border:2px solid #ccc;width: 100%;height: 43%;font-size: 13px;position: absolute;}
			table th{border:1px solid #ccc;text-align: center;background: #f0f0f0;}
			table td{border:1px solid #ccc;text-align: center;}
			.main_jindutiao{display: block; height: 18px;background: #4cda65;}
			.jindutiao_wapper{margin: 0 2%;cursor: pointer;}
			.jindutiao_wapper:hover .main_jindutiao{background: #F8C065;}
			.ldltj_icon{background-position: -2px 0px;}
			.syzktj_icon{background-position: 18px 0px;}
			.main_zczsl .mian_list_icon{background-position: 0px -4px;}
			.main_fczjs .mian_list_icon{background-position: -45px -4px;}
			.main_dczpfs .mian_list_icon{background-position: -90px -4px;}
			.main_tz .mian_list_icon{background-position: -135px -4px;}
			.main_zj .mian_list_icon{background-position: -180px -4px;}
			.main_xzfcsj .mian_list_icon{background-position: -225px -4px;}
			.main_list_wapper{height: 16.66%;position: relative;}
			.main_ldltj .main_jindutiao{background: #f3a923;}
			.main_syqktj .jindutiao_wapper:hover .main_jindutiao{background: #81E493;}
			.table_caption{height: 22px;line-height: 15px;position: relative;text-indent: 30px;}
			.table_caption span{position: absolute;width: 17px;height: 17px;left: 0px;top: -1px; background-image: url(${request.contextPath}/static/image/pointicon.png);}
			.main_list_inner{position: absolute;top: 50%;margin-top: -20px;}
		</style>
	</head>

	<body>
		<div class="main_top" style="height: 10%"></div>
		<div class="main_container" id="main_container">
			<div class="main_container_left">
				<div class="main_list_wapper">
					<a class="main_list main_zczsl" id="main_zczsl" href="javascript: void(0)"
						<#if hasSub == "false">onclick="toCardList(this)"<#else>onclick="toFbqk(this)"</#if>
					>
						<div class="main_list_inner">
							<div class="mian_list_icon"></div>
							<div class="main_list_item">
								<div>资产卡片总数量</div>
								<div class="main_list_info">${zdqkMap["ZICZSL"]} 件</div>
							</div>
						</div>
					</a>
				</div>
				 <div class="main_list_wapper">
					<a class="main_list main_fczjs" href="javascript: void(0)"
						<#if hasSub == "false">onclick="toCardList(this)"<#else>onclick="toFbqk(this)"</#if>
					>
						<div class="main_list_inner">
							<div class="mian_list_icon"></div>
							<div class="main_list_item">
								<div>资产总价值</div>
								<div class="main_list_info">
									<#if zdqkMap["ZICZJZ"]??>${(zdqkMap["ZICZJZ"] / 10000)?string("0.00")}<#else>0</#if> 万元
								</div>
							</div>
						</div>
					</a>
				</div>
				 <div class="main_list_wapper">
					<a class="main_list main_dczpfs" href="javascript: void(0)">
						<div class="main_list_inner">
							<div class="mian_list_icon"></div>
							<div class="main_list_item">
								<div>待处置批复数</div>
								<div class="main_list_info">${zdqkMap["CHUZDPFSL"]} 笔</div>
							</div>
						</div>
					</a>
				</div>
				 <div class="main_list_wapper">
					<a class="main_list main_tz" href="javascript: void(0)">
						<div class="main_list_inner">
							<div class="mian_list_icon"></div>
							<div class="main_list_item">
								<div>投资</div>
								<div class="main_list_info">${zdqkMap["TOUZZSL"]} 笔</div>
							</div>
						</div>
					</a>
				</div>
				 <div class="main_list_wapper">
					<a class="main_list main_zj" href="javascript: void(0)">
						<div class="main_list_inner">
							<div class="mian_list_icon"></div>
							<div class="main_list_item">
								<div>租赁</div>
								<div class="main_list_info">${zdqkMap["ZUJZSL"]} 笔</div>
							</div>
						</div>
					</a>
				</div>
				 <div class="main_list_wapper">
					<a class="main_list main_xzfcsj" id="xzfc" href="javascript: void(0)"
						<#if hasSub == "false">onclick="toCardList(this)"<#else>onclick="toFbqk(this)"</#if>
					>
						<div class="main_list_inner">
							<div class="mian_list_icon"></div>
							<div class="main_list_item">
								<div>闲置房产</div>
								<div class="main_list_info">${zdqkMap["FANGCXZS"]} 条</div>
							</div>
						</div>
					</a>
				</div>
			</div>
			<div class="main_container_right" id="main_container_right">
				<table class="main_ldltj">
					<caption class="table_caption">六大类统计<span class="ldltj_icon"></span></caption>
					<tr>
						<th style="width: 35%;">分类</th>
						<th style="width: 18%;">数量</th>
						<th style="width: 22%;">价格（万元）</th>
						<th style="width: 25%;">价值分析</th>
					</tr>
					<#list zcdlCursor as obj>
						<#if obj??>
							<tr>
								<td>${obj["ZICDL"]}</td>
								<td style="text-align: right;">${obj["CNT"]}&nbsp;</td>
								<td style="text-align: right;">
									<#if obj["JIAZ"]??>${(obj["JIAZ"] / 10000)?string("0.00")}<#else>0</#if>&nbsp;
								</td>
								<td>
									<div class="jindutiao_wapper" id="${obj['ZICDLID']}" onclick="toCardList(this)">
										<a class="main_jindutiao"  href="javascript: void(0)"
											<#if obj["JIAZ"]??>
												style="width: ${obj["JIAZ"] / zcdlTotalJiaz * 100}%"
											</#if>
										></a>
									</div>
								</td>
							</tr>
						<#else>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td><div class="jindutiao_wapper"><a class="main_jindutiao" style="width: 0%"></a></div></td>
							</tr>
						</#if>
					</#list>
				</table>
				<table style="bottom: 0px;" class="main_syqktj">
					<caption class="table_caption">使用情况统计<span class="syzktj_icon"></span></caption>
					<tr>
						<th style="width: 35%;">使用情况</th>
						<th style="width: 18%;">数量</th>
						<th style="width: 22%;">价格（万元）</th>
						<th style="width: 25%;">价值分析</th>
					</tr>
					<#list syztCursor as obj>
						<#if obj??>
							<tr>
								<td>${obj["OBJNAME"]}</td>
								<td style="text-align: right;">${obj["CNT"]}&nbsp;</td>
								<td style="text-align: right;">
									<#if obj["JIAZ"]??>${(obj["JIAZ"] / 10000)?string("0.00")}<#else>0</#if>&nbsp;
								</td>
								<td>
									<div class="jindutiao_wapper" id="${obj['SHIYZKID']}" onclick="toCardList(this)">
										<a class="main_jindutiao"  href="javascript: void(0)"
											<#if obj["JIAZ"]??>
												style="width: ${obj["JIAZ"] / syztTotalJiaz * 100}%"
											</#if>
										></a>
									</div>
								</td>
							</tr>
						<#else>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td><div class="jindutiao_wapper"><a class="main_jindutiao" style="width: 0%"></a></div></td>
							</tr>
						</#if>
					</#list>
				</table>
			</div>
		</div>
		<div class="main_bottom" style="height: 10%"></div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script>

			// GET 方式新增“分布情况”页签
			function toFbqk(obj) {
				var condition = {
					targetTabId: "fbqk_main",
					targetTabTitle: "分布情况",
					targetTabUrl: "${request.contextPath}/Query/Fbqk/main/0/${currentUser.currentOrgId}",
					method: "get",
					fromModel: ""
				};
				// 从“闲置房产”穿透
				if ($(obj).prop("id") == "xzfc") {
					condition.extra = "xzfc";
				}
				addTabByForm(condition);
			}

			// POST 方式新增“卡片列表”页签
			function toCardList(obj) {
				var condition = {
					targetTabId: "card_list",
					targetTabTitle: "卡片列表",
					targetTabUrl: "${request.contextPath}/Query/BsAstCard/list",
					method: "post",
					fromModel: ""
				};
				// 从“闲置房产”穿透
				if ($(obj).prop("id") == "xzfc") {
					condition.fromModel = "xzfc";
				}
				// 从“六大类统计”穿透
				else if ($(obj).parents(".main_ldltj").length > 0) {
					condition.fromModel = "ldltj";
					condition.zicdlrwidStr = $(obj).prop("id");
				}
				// 从“使用情况统计”穿透
				else if ($(obj).parents(".main_syqktj").length > 0) {
					condition.fromModel = "syqktj";
					condition.shiyzkidStr = $(obj).prop("id");
				}
				addTabByForm(condition);
			}

			// 动态调整表格与进度条的高度
			var $height = $(document).height();
			var $cont_height = $("#main_container").height();
			var $main_zczsl = $("#main_zczsl").height() + 22;
			var $heightDeff = $cont_height * 0.16666 - $main_zczsl;
			var height = $("#layout1").height();
			if ($height < 540) {
				$(".main_jindutiao").height(12);
			} else if ($height >= 540 && $height <= 800) {
				$(".main_jindutiao").height(14);
			}

			$("#main_container_right").height($cont_height - $heightDeff);

			window.onresize = function() {
				var $height = $(document).height();
				var $cont_height = $("#main_container").height();
				var $main_zczsl = $("#main_zczsl").height() + 22;
				var $heightDeff = $cont_height * 0.16666 - $main_zczsl;
				var height = $("#layout1").height();
				if ($height < 540) {
					$(".main_jindutiao").height(12);
				} else if ($height >= 540 && $height < 740) {
					$(".main_jindutiao").height(14);
				} else if ($height >= 740 && $height) {
					$(".main_jindutiao").height(18);
				}
				$("#main_container_right").height($cont_height - $heightDeff);
			}

		</script>
	</body>
</html>