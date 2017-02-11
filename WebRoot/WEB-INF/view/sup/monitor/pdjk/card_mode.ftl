<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>盘点卡片列表 - 卡片模式</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body style="background: #fff">
		<div class="container_box container_card">
			<div class="toolbar_wapper_card">
				<div class="toolbar_wapper_h">
					<#-- 声明一个名为 queryUrl 的变量，并为其传入查询时需要访问的 URL -->
					<#assign queryUrl = "${request.contextPath}/Monitor/Pdjk/list" />
					<#-- 声明一个名为 exportUrl 的变量，并为其传入导出时需要访问的 URL -->
					<#assign exportUrl = "${request.contextPath}/Monitor/Pdjk/exportExcel" />
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
		<form class="filter_form" action="${request.contextPath}/Monitor/Pdjk/list" method="post">
			<#-- 当前页数 -->
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
			<#-- 来源模块（用于标识是从何处穿透至卡片列表） -->
			<input name="fromModel" type="hidden" value="${fromModel}" />
			<input name="sortpartStr" type="hidden" value="${sortpartStr}" />
			<#-- 盘点监控模块的特别参数 -->
			<input name="qcjzr" type="hidden" value="${qcjzr}" /> <#-- 清查基准日 -->
			<input name="pdjkType" type="hidden" value="${pdjkType}" />
			<input name="pdjkRwid" type="hidden" value="${pdjkRwid}" />
			<input name="pdjkOrgid" type="hidden" value="${pdjkOrgid}" />
			<input name="pdjkDeptid" type="hidden" value="${pdjkDeptid}" />
			<input name="colType" type="hidden" value="${colType}" />
			<#-- 额外参数 -->
			<input name="extra" type="hidden" value="${extra}" />
			<#-- 视图模式 -->
			<input id="viewMode" name="viewMode" type="hidden" value="${VIEW_MODE}" />
			<#-- 选中数据的 ID 集合 -->
			<input id="checkedIdStr" name="checkedIdStr" type="hidden" />
			<div class="more_search">
				<div class="more_search_main">
					<table>
						<tr>
							<td class="more_search_item">资产名称：</td>
							<td><input name="zicmc" type="text" value="${zicmc}" placeholder="可模糊查询资产名称" /></td>
							<td class="more_search_item">规格型号：</td>
							<td><input name="guigxh" type="text" value="${guigxh}" placeholder="可模糊查询规格型号" /></td>
						</tr>
						<tr>
							<td class="more_search_item">原资产编号：</td>
							<td><input name="yuanzcbh_min" type="text" value="${yuanzcbh_min}" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="yuanzcbh_max" type="text" value="${yuanzcbh_max}" /></td>
						</tr>
						<tr>
							<td class="more_search_item">资产编号：</td>
							<td><input name="objcode_min" type="text" value="${objcode_min}" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="objcode_max" type="text" value="${objcode_max}" /></td>
						</tr>
						<tr class="search_date">
							<td class="more_search_item">购置日期：</td>
							<td class="search_datebox"><input id="gouzrq_begin" name="gouzrq_begin" type="text" value="${gouzrq_begin}" /></td>
							<td class="more_search_item" style="text-align: center">
								至
								<div class="query_button_tips">起始日期不能大于截止日期！</div>
							</td>
							<td class="search_datebox"><input id="gouzrq_end" name="gouzrq_end" type="text" value="${gouzrq_end}" /></td>
						</tr>
						<tr class="search_date">
							<td class="more_search_item">财务入账：</td>
							<td class="search_datebox"><input id="caiwrzrq_begin" name="caiwrzrq_begin" type="text" value="${caiwrzrq_begin}" /></td>
							<td class="more_search_item" style="text-align: center">
								至
								<div class="query_button_tips">起始日期不能大于截止日期！</div>
							</td>
							<td class="search_datebox"><input id="caiwrzrq_end" name="caiwrzrq_end" type="text" value="${caiwrzrq_end}" /></td>
						</tr>
						<tr>
							<td class="more_search_item">单价：</td>
							<td><input name="danj_min" type="text" value="${danj_min}" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="danj_max" type="text" value="${danj_max}" /></td>
						</tr>

					<#--
						<tr>
							<td class="more_search_item">使用部门：</td>
							<td class="search_datebox"><input type="hidden" id="sybmCheckbox" name="" /></td>
							<td class="more_search_item">使用人：</td>
							<td class="search_datebox"><input type="hidden" id="syrCheckbox" name="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">资产大类：</td>
							<td class="search_datebox"><input type="hidden" id="zcdlCheckbox" name="" /></td>
							<td class="more_search_item">资产分类：</td>
							<td class="search_datebox"><input type="hidden" id="zcflCheckbox" name="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">卡片类型：</td>
							<td>
								<select>
									<option value=""></option>
									<option value="">主卡片</option>
									<option value="">有附属卡片的主卡片</option>
									<option value="">无附属卡片的主卡片</option>
									<option value="">附属卡片</option>
									<option value="">全部</option>
								</select>
							</td>
							<td class="more_search_item">是否待报废：</td>
							<td>
								<select>
									<option value=""></option>
									<option value="">未标识待报废</option>
									<option value="">标识待报废</option>
									<option value="">全部</option>
								</select>
							</td>
						</tr>
						<tr class="search_date">
							<td class="more_search_item">开箱日期：</td>
							<td class="search_datebox"><input id="kxdateBegin" name="kxdateBegin" type="text" value="" /></td>
							<td class="more_search_item" style="text-align: center">
								至
								<div class="query_button_tips">起始日期不能大于截止日期！</div>
							</td>
							<td class="search_datebox"><input id="kxdateEnd" name="kxdateEnd" type="text" value="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">凭证号：</td>
							<td><input type="text" name="" /></td>
							<td class="more_search_item">是否标记：</td>
							<td>
								<select>
									<option value=""></option>
									<option value="">未标记</option>
									<option value="">已标记</option>
									<option value="">全部</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="more_search_item">备注：</td>
							<td><input type="text" name="" /></td>
							<td class="more_search_item">取得方式：</td>
							<td>
								<select>
									<option value=""></option>
									<option value="">新购</option>
									<option value="">调拨</option>
									<option value="">接受捐赠</option>
									<option value="">自建</option>
									<option value="">置换</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="more_search_item">合同编号：</td>
							<td><input type="text" name="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">批量查找：</td>
							<td colspan="3"><textarea class="more_search_textarea" form="" placeholder="您可以批量输入卡片编号"></textarea></td>
						</tr>
					-->

					</table>
				</div>
				<div class="more_search_bottom">
					<div class="iframe_btn iframe_btn_qk">清空</div>
					<input type="submit" class="iframe_btn iframe_btn_qd" value="确定" />
					<div class="iframe_btn iframe_btn_qx">取消</div>
				</div>
			</div>
		</form>
		<div class="total_price">
			<div class="container_box">
				您所选的资产共计：<span id="total_number">0</span>&nbsp;条，金额共计：<span id="total_price">0.00</span>&nbsp;元
			</div>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerCheckBox.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerResizable.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerTree.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerComboBox.js"></script>
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

				// 生成日历
				$("#gouzrq_begin").ligerDateEditor();
				$("#gouzrq_end").ligerDateEditor();
				$("#caiwrzrq_begin").ligerDateEditor();
				$("#caiwrzrq_end").ligerDateEditor();
				$("#kxdateBegin").ligerDateEditor();
				$("#kxdateEnd").ligerDateEditor();

				// 将日历文本框设为只读
				$("#gouzrq_begin, #gouzrq_end, #caiwrzrq_begin, #caiwrzrq_end").attr("readonly", true);
			});

		</script>
	</body>
</html>