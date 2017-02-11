<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>卡片列表 - 卡片模式</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body style="background: #fff">
		<div class="container_box container_card">
			<div class="toolbar_wapper_card">
				<div class="toolbar_wapper_h">
					<#-- 移除更多筛选条件 -->
					<#assign noFilter = true />
					<#-- 声明一个名为 queryUrl 的变量，并为其传入查询时需要访问的 URL -->
					<#assign queryUrl = "${request.contextPath}/Query/BsAstCard/list" />
					<#-- 声明一个名为 exportUrl 的变量，并为其传入导出时需要访问的 URL（暂时屏蔽维修情况导出）-->
					<#if fromModel != "wxqk_main"><#assign exportUrl = "${request.contextPath}/Query/BsAstCard/exportExcel" /></#if>
					<#-- 导入工具栏模板 -->
					<#include "/base/toolbar_box.ftl" />
					<div class="toolbar_order">
						<ul>
							<li>排序：</li>
							<li class="sort">
								<a href="javascript: void(0)">
									综合排序
									<span class="card_order_jt" column="default"></span>
								</a>
							</li>
							<li class="sort">
								<a href="javascript: void(0)">
									购置日期
									<span class="card_order_jt" column="GOUZRQ"></span>
								</a>
							</li>
							<li class="sort">
								<a href="javascript: void(0)">
									财务入账日期
									<span class="card_order_jt" column="CAIWRZRQ"></span>
								</a>
							</li>
							<li class="sort">
								<a href="javascript: void(0)">
									数量
									<span class="card_order_jt" column="SHUL"></span>
								</a>
							</li>
							<li class="sort">
								<a href="javascript: void(0)">
									价值
									<span class="card_order_jt" column="JIAZ"></span>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="list_wapper_card">
				<#list page.results as obj>
					<div class="item_card_wapper col-media">
						<div class="item_card">
							<label class="fl item_card_label"><input class="chk" type="checkbox" value="${obj['RWID']}" price="${obj['JIAZ']}" /></label>
							<div class="item_card_header">
								<div class="item_card_img">
									<#if obj["FILENAME1"]??>
										<img src="${prefixPath}/FileFolder/${obj['FILENAME1']}.${obj['EXTENSION1']}" />
									<#else>
										<img src="${request.contextPath}/static/image/errorload.png" />
									</#if>
								</div>
								<a class="item_card_info" rwid="${obj['RWID']}" editable="1">
									<ul>
										<li>${obj["OBJCODE"]}</li>
										<li>${obj["ZICMC"]}</li>
										<li>${obj["GUIGXH"]}</li>
									</ul>
								</a>
							</div>
							<div class="item_card_price">
								<span>￥${obj["JIAZ"]}</span>
								<span>数量：${obj["SHUL"]}</span>
								<!--
									<div class="item_card_findlike">
										<span><a href="javascript: void(0)">找同类</a></span>
										<span><a href="javascript: void(0)">找相似</a></span>
									</div>
								-->
							</div>
							<div class="item_card_middle">
								<ul>
									<li>购置日期：${obj["GOUZRQ"]}</li>
									<li>财务入账：<#if obj["CAIWRZRQ"]??>${obj["CAIWRZRQ"]}<#else>未登账</#if></li>
									<li>使<font style="margin: 0 6.4px 0">用</font>人：${obj["SHIYR"]}</li>
									<li>状　　态：${obj["SHIYZK"]}</li>
								</ul>
							</div>
							<div class="item_card_bottom">
								<ul class="card_tips">
									<#-- 导入卡片标签模板 -->
									<#include "/base/card_tips.ftl" />
								</ul>
							</div>
						</div>
					</div>
				</#list>
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

			$(function() {

				// 如需重写基础 JS 模版中的事件，应当事先移除本页所有已绑定的函数，否则可能会产生一些难以处理的 bug
				$(document).off();

				/* 复选框相关 - BEGIN */
				var chkCheckedNum = 0;
				var chkCheckedPrice = 0;
				// 本页卡片的总个数
				var cardsCountThisPage = $("input[class='chk']").length;
				// 本页卡片的总价值
				var cardsPriceThisPage = 0;
				$("input[class='chk']").each(function() {
					var price = $(this).attr("price");
					cardsPriceThisPage = accAdd(cardsPriceThisPage, price);
				});

				$(document).on("click", ".toobar_chosethis label", function() {
					var $input = $(this).children("input");
					var $list = $(".item_card_label");
					if ($input.prop("checked")) {
						$input.prop("checked", false);
						$list.children("input").prop("checked", false);
						$(this).removeClass("active");
						$list.removeClass("active");
						// 计算卡片的选中个数及总价值
						chkCheckedNum = "0";
						chkCheckedPrice = "0.00";
					} else {
						$input.prop("checked", true);
						$list.children("input").prop("checked", true);
						$(this).addClass("active");
						$list.addClass("active");
						// 计算卡片的选中个数及总价值
						chkCheckedNum = cardsCountThisPage;
						chkCheckedPrice = cardsPriceThisPage;
					}
					$("#total_number").text(chkCheckedNum);
					$("#total_price").text(chkCheckedPrice);
					return false;
				});

				$(document).on("click", ".item_card_label", function() {
					var $input = $(this).children("input");
					var price = $input.attr("price");
					if ($input.prop("checked")) {
						$input.prop("checked", false);
						$(this).removeClass("active");
						$(".toobar_chosethis label").children("input").prop("checked", false);
						$(".toobar_chosethis label").removeClass("active");
						// 计算卡片的选中个数及总价值
						chkCheckedNum --;
						chkCheckedPrice = accSubtr(chkCheckedPrice, price);
					} else {
						$input.prop("checked", true);
						$(this).addClass("active");
						// 状态为选中的复选框个数
						var chkCheckedCount = $("input[class='chk']:checked").length;
						if (cardsCountThisPage == chkCheckedCount) {
							$("#chkThisPage").prop("checked", true);
							$("#chkThisPage").parent().addClass("active");
						}
						// 计算卡片的选中个数及总价值
						chkCheckedNum ++;
						chkCheckedPrice = accAdd(chkCheckedPrice, price);
					}
					$("#total_number").text(chkCheckedNum);
					$("#total_price").text(chkCheckedPrice);
					return false;
				});
				/* 复选框相关 - END */

				// 表头固定
				$(window).scroll(function() {
					if ($(window).scrollTop() >= 7) {
						$(".toolbar_wapper_h").addClass("fixed");
					} else {
						$(".toolbar_wapper_h").removeClass("fixed");
					}
				});

				// 查看卡片详情
				$(".item_card_info ul").click(function() {
					var rwid = $(this).parent().attr("rwid");
					var editable = $(this).parent().attr("editable");
					$cardModal.prop("src", "${request.contextPath}/Query/BsAstCard/card/" + rwid + "/" + editable);
					window.parent.alertCard();
				});

			});

		</script>
	</body>
</html>