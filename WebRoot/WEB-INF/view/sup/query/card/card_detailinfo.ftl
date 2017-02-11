<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>卡片详情</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<style>
			html{height: 100%;}
			body{font-family: "微软雅黑";font-size: 13px;color: #333;height: 100%;}
			.card_img{float: left;width: 182px;height: 180px;}
			.card_bigimg{height: 130px;border:1px solid #ccc;}
			.card_imglist li{float: left;width: 39px;height: 39px;margin: 5px 6px 5px 0;border:1px solid #ccc;}
			.card_maininfo{float: left;padding-left: 30px; font-size: 13px;}
			.card_maininfo li{height: 24px;line-height: 24px;}
			.detail_card_header{overflow: hidden;padding: 8px 0px 3px 8px;}
			.detail_card_tab{height: 34px;clear: both;border-top:1px solid #ccc;background:#d7e9fe;}
			.detail_card_tab ul{padding-left: 10px;}
			.detail_card_tab li{float: left;width: 80px;height: 30px;line-height: 30px;margin-top: 4px;font-size: 14px;text-align: center;cursor: pointer;border-top-left-radius: 4px;border-top-right-radius: 4px;}
			.card_info_list{height: 340px;overflow-y: auto;}
			.card_tab_selsect{background:#fff;}
			.detail_card_info{font-size: 13px;}
			.detail_card_info td{width: 114px;height: 34px;line-height: 34px;}
			.detail_card_info td input{width: 112px;height: 22px;line-height: 22px;border:1px solid #ccc;text-indent: 5px;}
			.detail_card_info .text-idt{text-indent: 16px;width: 136px;position: relative;}
			.detail_card_info{margin-top: 20px;padding-bottom: 10px;border-bottom: 1px solid #ccc;}
			.detail_card_info table{table-layout: fixed;}
			.detail_card_info select{width: 114px;height: 24px;border:1px solid #ccc;font-family: "微软雅黑";}
			.detail_card_info textarea{width: 362px;background:#fff;border:1px solid #ccc;color:#999;margin-top:5px;}
			.card_imglist li img{width: 100%;height: 100%;line-height: 40px;}
			.card_bigimg img{width: 100%;height: 100%;}
			.text-idt span{color: red;position: absolute;left: -6px;top: 0px;}
			input[disabled],input:disabled{background:#fff;color: #999;}
			.weixiu_header,.rizhi_header,.fushu_header,.zhejiu_header{padding-top: 2px;}
			.weixiu_header table{width: 100%;text-align: center;}
			.weixiu_header table td{border:1px solid #ccc;height: 26px;line-height: 26px;}
			.rizhi_header table{width: 100%;text-align: center;}
			.rizhi_header table td{border:1px solid #ccc;height: 26px;line-height: 26px;}
			.card_info_zhejiu table,.card_info_fushu table{width: 100%;text-align: center;}
			.card_info_zhejiu table td{width: 7.6%;border:1px solid #ccc;height: 26px;line-height: 26px;}
			.card_info_fushu table td{border:1px solid #ccc;height: 26px;line-height: 26px;}
			.card_info_item{display: none;}
			.bg_list{background:#fafafa}
			.detail_card_info .colspan_width input{width:362px;}
			.louceng_cont{height: 306px;border-top:1px solid #ccc;border-bottom: 1px solid #ccc;}
			.louceng_cont_bg{height: 406px}
			.louceng_tree{float: left;width: 25%;height: 100%;}
			.louceng_tree_inner{height: 100%;border-right: 1px solid #ccc;overflow-x: hidden;}
			.loucent_table{float: left;width: 75%;}
			.louceng_bottom{height: 32px;line-height: 32px;padding-left: 8px;}
			.loucent_table table{width: 100%;text-align: center;table-layout: fixed;}
			.loucent_table table td{border:1px solid #ccc;height: 26px;line-height: 26px;overflow: hidden;white-space: nowrap;text-overflow:ellipsis;}
			.l-tree a, .l-tree span{color: #333;}
			.l-selected{background:#fff!important;}
			#tree1 .l-selected span{color: #333!important;}
			#tree1 .l-over{background:#fff;}
			.zika_header table{width: 100%;text-align: center;}
			.zika_header table td{border:1px solid #ccc;height: 26px;line-height: 26px;}
			.rizhi_detail{width: 560px;height: 340px;position: fixed;top: 25%;left: 50%;margin-left: -280px;background:#fff;border:1px solid #2f89f4;display: none;z-index: 999;}
			.rizhi_detail_header{height: 32px;background:#2f89f4;position: relative;}
			.rizhi_detail_close{width: 16px;height: 16px;position: absolute;right: 10px;top: 8px;color: #fff;cursor: pointer;background-image:url(${request.contextPath}/static/image/card.png);background-position: -31px 0px;background-repeat: no-repeat;}
			.rizhi_detail_close:hover{background-position: -61px 0px;}
			.rizhi_detail_info{height: 32px;line-height: 32px;color: #fff;padding-left: 32px;}
			.rizhi_detail_icon{width: 16px;height: 16px;position: absolute;top: 8px;left: 8px;background-image:url(${request.contextPath}/static/image/card.png);background-position: -0px 0px;background-repeat: no-repeat;}
			.rizhi_detail_content{overflow-y: auto;}
			.rizhi_detail_content table{width: 100%;text-align: center;}
			.rizhi_detail_content table th,.rizhi_detail_content table td{height: 26px;line-height: 26px;border:1px solid #ccc;text-align: center;}
			.rizhi_detail_content table th{border-bottom: none;}
			.card_cover{position: fixed;left: 0;top: 0;width: 100%;height: 100%;display: none;z-index: 998;}
			.log_detail a{color:#2f88f3;}
		</style>
	</head>

	<body>
		<div class="detail_card_header">
			<div class="card_img">
				<div class="card_bigimg">
					<#if cardDetailInfo["FILENAME1"]??>
						<img src="${prefixPath}/FileFolder/${cardDetailInfo['FILENAME1']}.${cardDetailInfo['EXTENSION1']}" />
					<#else>
						<img src="${request.contextPath}/static/image/errorload.png" />
					</#if>
				</div>
				<div class="card_imglist">
					<ul>
						<li>
							<#if cardDetailInfo["FILENAME1"]??>
								<img src="${prefixPath}/FileFolder/${cardDetailInfo['FILENAME1']}.${cardDetailInfo['EXTENSION1']}" />
							<#else>
								<img src="${request.contextPath}/static/image/errorload.png" />
							</#if>
						</li>
						<li>
							<#if cardDetailInfo["FILENAME2"]??>
								<img src="${prefixPath}/FileFolder/${cardDetailInfo['FILENAME2']}.${cardDetailInfo['EXTENSION2']}" />
							<#else>
								<img src="${request.contextPath}/static/image/errorload.png" />
							</#if>
						</li>
						<li>
							<#if cardDetailInfo["FILENAME3"]??>
								<img src="${prefixPath}/FileFolder/${cardDetailInfo['FILENAME3']}.${cardDetailInfo['EXTENSION3']}" />
							<#else>
								<img src="${request.contextPath}/static/image/errorload.png" />
							</#if>
						</li>
						<li style="margin-right: 0">
							<#if cardDetailInfo["FILENAME4"]??>
								<img src="${prefixPath}/FileFolder/${cardDetailInfo['FILENAME4']}.${cardDetailInfo['EXTENSION4']}" />
							<#else>
								<img src="${request.contextPath}/static/image/errorload.png" />
							</#if>
						</li>
					</ul>
				</div>
			</div>
			<div class="card_maininfo">
				<ul>
					<li>资产名称：${cardDetailInfo["ZICMC"]}</li>
					<li>资产编号：${cardDetailInfo["OBJCODE"]}</li>
					<li>资产分类：${cardDetailInfo["ZICFL"]}</li>
					<li>资产属性：${cardDetailInfo["ZICSX"]}</li>
					<li>数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量：${cardDetailInfo["SHUL"]}</li>
					<li>总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：${((cardDetailInfo["JIAZ"]?string("0.00"))!"0.00")}元</li>
					<li>使用状况：${cardDetailInfo["SHIYZK"]}</li>
				</ul>
			</div>
		</div>
		<div class="detail_card_cont">
			<div class="detail_card_tab">
				<ul>
					<li class="card_tab_selsect info_main" tabid="info_main">基本信息</li>
					<#list listSubtab as subtab>
						<li class="${subtab["tabidOrClass"]}" tabid="${subtab["tabidOrClass"]}">${subtab["name"]}</li>
					</#list>
					<!--
					<li class="info_weixiu" tabid="info_weixiu">维修记录</li>
					<li class="info_zika" tabid="info_zika">子卡信息</li>
					<li class="info_rizhi" tabid="info_rizhi">业务日志</li>
					<li class="info_louceng" tabid="info_louceng">楼层信息</li>
					<li class="info_fushu" tabid="info_fushu">附属卡片</li>
					-->
				</ul>
			</div>
			<div class="card_info_list">
				<#-- 基本信息模版 -->
				<#include "${baseInfoByModelId_URL}" />
				<!-- 折旧信息 -->
				<div class="card_info_zhejiu card_info_item">
					<div class="zhejiu_header">
						<table>
							<tr class="bg_list">
								<td style="border-left: none">年份：</td>
								<td>1月</td>
								<td>2月</td>
								<td>3月</td>
								<td>4月</td>
								<td>5月</td>
								<td>6月</td>
								<td>7月</td>
								<td>8月</td>
								<td>9月</td>
								<td>10月</td>
								<td>11月</td>
								<td>12月</td>
							</tr>
							<#list depreciationCursor as obj>
								<tr>
									<td style="border-left: none">${obj["ZHEJQJN"]}</td>
									<td>${obj["ZHJJE1"]}</td>
									<td>${obj["ZHJJE2"]}</td>
									<td>${obj["ZHJJE3"]}</td>
									<td>${obj["ZHJJE4"]}</td>
									<td>${obj["ZHJJE5"]}</td>
									<td>${obj["ZHJJE6"]}</td>
									<td>${obj["ZHJJE7"]}</td>
									<td>${obj["ZHJJE8"]}</td>
									<td>${obj["ZHJJE9"]}</td>
									<td>${obj["ZHJJE10"]}</td>
									<td>${obj["ZHJJE11"]}</td>
									<td>${obj["ZHJJE12"]}</td>
								</tr>
							</#list>
						</table>
					</div>
				</div>
				<!-- 维修信息 -->
				<div class="card_info_weixiu card_info_item">
					<div class="weixiu_header">
						<table>
							<tr class="bg_list">
								<td style="border-left: none">维修时间</td>
								<td>维修商</td>
								<td>维修原因</td>
								<td>维修内容</td>
								<td>维修方式</td>
								<td>维修费用</td>
								<td>维修结果</td>
								<td>登帐方式</td>
							</tr>
							<#list weixCursor as obj>
								<tr <#if obj_index % 2 != 0>class="bg_list"</#if>>
									<td>${obj["AUDITTIME"]}</td>
									<td>${obj["WEIXS"]}</td>
									<td>${obj["WEIXYY"]}</td>
									<td>${obj["WEIXNR"]}</td>
									<td>${obj["WEIXFS"]}</td>
									<td>${obj["WEIXFY"]}</td>
									<td>${obj["WEIXJG"]}</td>
									<td>${obj["dengzfs"]}</td>
								</tr>
							</#list>
						</table>
					</div>
				</div>
				<!-- 子卡信息 -->
				<div class="card_info_zika card_info_item">
					<div class="zika_header">
						<table>
							<tr>
								<td style="border-left: none">资产编码</td>
								<td>资产名称</td>
								<td>单价</td>
								<td>数量</td>
								<td>价值</td>
								<td>规格型号</td>
								<td>使用部门</td>
								<td>使用人</td>
								<td>存放地</td>
								<td>资产状态</td>
							</tr>
						</table>
					</div>
				</div>
				<!-- 日志信息 -->
				<div class="card_info_rizhi card_info_item">
					<div class="rizhi_header">
						<table>
							<tr class="bg_list">
								<td style="width: 25%; border-left: none">业务时间</td>
								<td style="width: 15%">业务内容</td>
								<td style="width: 45%">详细内容</td>
								<td style="width: 15%">操作人</td>
							</tr>
							<#list logCursor as obj>
								<tr <#if obj_index % 2 != 0>class="bg_list"</#if>>
									<td style="border-left: none">${obj["yewsj"]}</td>
									<td>${obj["YEWNR"]}</td>
									<td class="log_detail" data-detail='${obj["DETAIL"]}'></td>
									<td>${obj["CAOZR"]}</td>
								</tr>
							</#list>
						</table>
					</div>
				</div>
				<!-- 楼层信息 -->
				<div class="card_info_louceng card_info_item">
					<div class="louceng_cont">
						<div class="louceng_tree">
							<div class="louceng_tree_inner">
								<!-- 复选框树菜单 -->
								<ul id="tree1"></ul>
							</div>
						</div>
						<div class="loucent_table">
							<table>
								<tr>
									<td style="width: 5%"></td>
									<td style="width: 15%; border-left: none">房间号</td>
									<td style="width: 20%">建筑面积（m²）</td>
									<td style="width: 10%">房证号</td>
									<td style="width: 10%">用途</td>
									<td style="width: 15%">使用部门</td>
									<td style="width: 20%; border-right: none">租借日期</td>
								</tr>
								<#list roomCursor as obj>
									<#if (obj["LOUCID"]??) && (obj["LOUCID"] != "")>
										<tr loucid="${obj["LOUCID"]}">
											<td style="width: 5%"><input type="checkbox" /></td>
											<td style="border-left: none" class="fangjh">${obj["FANGJH"]}</td>
											<td>${obj["MIANJ"]}</td>
											<td >${obj["FANGZH"]}</td>
											<td>${obj["YONGTMC"]}</td>
											<td>${obj["SHIYBM"]}</td>
											<td style="border-right: none" class="cujrq">
											<#if (obj["ZUJSDATE"]??) && (obj["ZUJSDATE"] != "")&&(obj["ZUJEDATE"]??) && (obj["ZUJEDATE"] != "")>${obj["ZUJSDATE"]}至${obj["ZUJEDATE"]}</#if>
											</td>
										</tr>
									</#if>
								</#list>
							</table>
						</div>
					</div>
					<div class="louceng_bottom">剩余面积：${xianzmj}平方米</div>
				</div>
				<!-- 附属卡片 -->
				<div class="card_info_fushu card_info_item">
					<div class="fushu_header">
						<table>
							<tr class="bg_list">
								<td style="border-left: none">资产名称</td>
								<td>资产编号</td>
								<td>规格型号</td>
								<td>财务入账日期</td>
								<td>单价（元）</td>
								<td>数量</td>
								<td>存放地点</td>
								<td>资产状态</td>
								<td>使用部门（人）</td>
								<td>业务操作</td>
							</tr>
							<#list additionCardsCursor as obj>
								<tr>
									<td style="border-left: none">${obj["ZICMC"]}</td>
									<td>${obj["OBJCODE"]}</td>
									<td>${obj["GUIGXH"]}</td>
									<td>${obj["CAIWRZRQ"]}</td>
									<td>${obj["DANJ"]}</td>
									<td>${obj["SHUL"]}</td>
									<td>${obj["CUNFDD"]}</td>
									<td>${obj["SHIYZK"]}</td>
									<td>${obj["SHIYBM"]}<#if obj["SHIYR"]??>(${obj["SHIYR"]})</#if></td>
									<td>转主</td>
								</tr>
							</#list>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="rizhi_detail">
			<div class="rizhi_detail_header">
				<div class="rizhi_detail_info">卡片修改信息查看</div>
				<div class="rizhi_detail_icon"></div>
				<div class="rizhi_detail_close"></div>
			</div>
			<div class="rizhi_detail_content">
				<table>
					<tr style="background: #f5f5f5">
						<th style="width: 10%">序号</th>
						<th style="width: 20%">修改字段</th>
						<th style="width: 35%">修改前</th>
						<th style="width: 35%">修改后</th>
					</tr>
					<table class="rizhi_detail_content_info"></table>
				</table>
			</div>
		</div>
		<div class="card_cover"></div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerTree.js"></script>
		<script>

			$(function() {

				// 动态设置 card_info_list 高度
				$(".card_info_list").height($("body").height() - $(".detail_card_header").height() - 35 - 11);
				// 楼层框动态赋值最大高度
				$(".louceng_cont").height($(".card_info_list").height() - 34);

				var treedata = [${floorVo}];

				// 配置楼层信息复选框树
				$("#tree1").ligerTree({
					data: treedata,
					checkbox: true,
					slide: true,
					nodeWidth: 149,
					treeLine: false,
					parentIcon: null,
					childIcon: null,
					onCheck: function() {
						// 楼层树和表格关联
						var obj = this.getChecked();
						var $tr = $(".loucent_table tr");
						$(".loucent_table input").prop("checked", false);
						for (var i = 0; i < obj.length; i ++) {
							var id = obj[i].data.id;
							$tr.each(function(key, val) {
								if ($(val).attr("loucid") == id) {
									$(val).find("input").prop("checked", true);
								}
							});
						}
					}
				});

				// 页面加载完成给房间号添加对应的楼层信息
				if(treedata.length != 0){
					$(".loucent_table tr").each(function(key, val){
						var id = $(val).attr("loucid");
						if(treedata[0].children.length != 0){
							for(var i = 0; i < treedata[0].children.length; i ++){
								if (treedata[0].children[i].id == id){
									var html = $(val).children(".fangjh").html();
									$(val).children(".fangjh").html(html + " [" + treedata[0].children[i].text + "]");
								}
							}
						}
						$(val).children(".cujrq").prop("title", $(val).children(".cujrq").html());
					});
				}

				// 业务日志判断
				$(".log_detail").each(function(key, val) {
					var detaildata = $(val).data("detail");
					if (typeof(detaildata) == "string") {
						val.innerHTML = detaildata;
					} else if (typeof(detaildata) == "object") {
						val.innerHTML = "<a href='javascript: void(0)'>查看详情</a>"
					}
				});

				// 鼠标悬浮图片切换
				$(".card_imglist li").mouseenter(function() {
					$(".card_bigimg img").attr("src", $(this).children("img").attr("src"));
				});

				// 选项卡切换
				$(".detail_card_tab ul li").click(function() {
					$(this).addClass("card_tab_selsect").siblings("li").removeClass("card_tab_selsect");
					var tab_id = ".card_" + $(this).attr("tabid");
					$(tab_id).show().siblings("div").hide();
				});

				// 业务日志弹出框显示隐藏
				$(".log_detail").on("click", "a", function() {
					$(".rizhi_detail_content_info").empty();
					$.each($(this).parent(".log_detail").data("detail"), function(key, val) {
						var tr = $("<tr>");
						$("<td style='width: 10%'>").html(key + 1).appendTo(tr);
						$("<td style='width: 20%'>").html(val[0]).appendTo(tr);
						$("<td style='width: 35%'>").html(val[1]).appendTo(tr);
						$("<td style='width: 35%'>").html(val[2]).appendTo(tr);
						tr.appendTo($(".rizhi_detail_content_info"));
					});
					$(".rizhi_detail, .card_cover").show();
				});

				$(".rizhi_detail_close").click(function() {
					$(".rizhi_detail, .card_cover").hide();
				});
			});

		</script>
	</body>
</html>