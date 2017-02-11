<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>盘盈卡片</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body class="card_body">
		<div class="container_box container_card">
			<div class="toolbar_wapper toolbar_wapper_pd">
				<div class="toolbar_box">
					<div class="toolbar_left fl">
						<div class="toobar_search fl">
							<form class="query_form" action="${request.contextPath}/Monitor/Pdjk/pdCard" method="post">
								<#-- 当前页数 -->
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
								<#-- 来源模块（用于标识是从何处穿透至卡片列表） -->
								<input name="fromModel" type="hidden" value="${fromModel}" />
								<input name="keyvalueStr" type="text" value="${keyvalueStr}" />
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
								<button class="toobar_search_btn" type="submit"><span></span></button>
							</form>
						</div>
						<div class="toobar_moresearch fl">更多筛选条件</div>
						<div class="pd_jizhunri fl">盘点基准日：</div>
						<div class="pd_timeselect fl">
							<form id="pd_card" action="${request.contextPath}/Monitor/Pdjk/pdCard" method="post">
								<#-- 当前页数 -->
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
								<#-- 来源模块（用于标识是从何处穿透至卡片列表） -->
								<input name="fromModel" type="hidden" value="${fromModel}" />
								<#-- <input name="keyvalueStr" type="text" value="${keyvalueStr}" /> -->
								<input name="sortpartStr" type="hidden" value="${sortpartStr}" />
								<#-- 盘点监控模块的特别参数 -->
								<#-- <input name="qcjzr" type="hidden" value="${qcjzr}" /> --> <#-- 清查基准日 -->
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
				</div>
				<div class="toolbar_box toolbar_box2">
					<div class="toolbar_left fl">
						<div class="toolbar_choseall fl">
							<label class="fl"><input id="chkAll" type="checkbox" /></label>
							<div class="fl">全选</div>
						</div>
						<div class="toobar_chosethis fl">
							<label class="fl"><input id="chkThisPage" type="checkbox" /></label>
							<div class="fl">选择当前页</div>
						</div>
					</div>
					<div class="toolbar_right fr">
						<div class="toolbar_dc fl">
							导出<span></span>
							<div class="tips_dc_wushuju">请选择要导出的数据！</div>
						</div>
						<div class="toolbar_fy fl">
							<ul>
								<li class="toobar_jt toobar_jtll" pageNo="1" <#if page.hasPrev>able="true"</#if>>
									<a <#if page.hasPrev>href="javascript: void(0)" class="toobar_jtll_a"</#if>></a>
								</li>
								<li class="toobar_jt toobar_jtl" pageNo="${page.prev}" <#if page.hasPrev>able="true"</#if>>
									<a <#if page.hasPrev>href="javascript: void(0)" class="toobar_jtl_a"</#if>></a>
								</li>
								<li class="toobar_pagenum"><input id="page_switch" type="text" value="${page.pageNo}" /></li>
								<li style="width: 10px">/</li>
								<li>${page.totalPageNo}</li>
								<li class="toobar_jt toobar_jtr" pageNo="${page.next}" <#if page.hasNext>able="true"</#if>>
									<a <#if page.hasNext>href="javascript: void(0)" class="toobar_jtr_a"</#if>></a>
								</li>
								<li class="toobar_jt toobar_jtrr" pageNo="${page.totalPageNo}" <#if page.hasNext>able="true"</#if>>
									<a <#if page.hasNext>href="javascript: void(0)" class="toobar_jtrr_a"</#if>></a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="list_wapper">
				<div class="list_wapper_header" style="background: #ebf1f7">
					<table class="list_table_header">
						<tr>
							<td style="width: 5%"><div class="xuhao_header" style="background: #ebf1f7">序号</div></td>
							<td style="width: 3%"></td>
							<td class="sort" style="width: 19%">
								<a href="javascript: void(0)">
									资产名称
									<span class="card_order_jt" column="ZICMC"></span>
								</a>
							</td>
							<td class="sort" style="width: 9%">
								<a href="javascript: void(0)">
									资产大类
									<span class="card_order_jt" column="ZICFL"></span>
								</a>
							</td>
							<td class="sort" style="width: 8%">
								<a href="javascript: void(0)">
									申报人
									<span class="card_order_jt" column="SHENBR"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript: void(0)">
									盘点基准日
									<span class="card_order_jt" column="QCJZR"></span>
								</a>
							</td>
							<td class="sort" style="width: 9%">
								<a href="javascript: void(0)">
									发现日期
									<span class="card_order_jt" column="CREATETIME"></span>
								</a>
							</td>
							<td class="sort" style="width: 9%">
								<a href="javascript: void(0)">
									存放地点
									<span class="card_order_jt" column="CUNFDD"></span>
								</a>
							</td>
							<td class="sort" style="width: 9%">
								<a href="javascript: void(0)">
									计量单位
									<span class="card_order_jt" column="JILDW"></span>
								</a>
							</td>
							<td class="sort" style="width: 9%">
								<a href="javascript: void(0)">
									卡片数量
									<span class="card_order_jt" column="SHUL"></span>
								</a>
							</td>
							<td class="sort" style="width: 10%">
								<a href="javascript: void(0)">
									盘盈说明
									<span class="card_order_jt" column="BEIZ"></span>
								</a>
							</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<colgroup>
							<col width="5%"></col>
							<col width="3%"></col>
							<col width="19%"></col>
							<col width="9%"></col>
							<col width="8%"></col>
							<col width="10%"></col>
							<col width="9%"></col>
							<col width="9%"></col>
							<col width="9%"></col>
							<col width="9%"></col>
							<col width="10%"></col>
						</colgroup>
						<#list page.results as obj>
							<tr class="list_imglist" <#if obj_index % 2 != 0>style="background-color: #fafafa"</#if>>
								<td class="xuhao" style="background-color: #fafafa">${obj_index + 1}</td>
								<td class="list_td_label"><label class="list_label list_label_py fl"><input class="chk" type="checkbox" value="${obj['RWID']}"/></label></td>
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
									<a class="list_name_wapper" href="javascript: void(0)">${obj["ZICMC"]}</a>
								</td>
								<td>${obj["ZICFL"]}</td>
								<td>${obj["SHENBR"]}</td>
								<td>${obj["QCJZR"]}</td>
								<td>${obj["CREATETIME"]}</td>
								<td>${obj["CUNFDD"]}</td>
								<td>${obj["JILDW"]}</td>
								<td>${obj["SHUL"]}</td>
								<td>${obj["BEIZ"]}</td>
							</tr>
						</#list>
					</table>
				</div>
			</div>
		</div>
		<form class="filter_form" action="${request.contextPath}/Monitor/Pdjk/pdCard" method="post">
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
							<td class="more_search_item">资产分类：</td>
							<td><input name="zicflid" type="text" value="${zicflid}" placeholder="可模糊查询资产分类" /></td>
						</tr>
						<tr class="search_date">
							<td class="more_search_item">发现日期：</td>
							<td class="search_datebox"><input id="date_begin" name="date_begin" type="text" value="${date_begin}" /></td>
							<td class="more_search_item" style="text-align: center">
								至
								<div class="query_button_tips">起始日期不能大于截止日期！</div>
							</td>
							<td class="search_datebox"><input id="date_end" name="date_end" type="text" value="${date_end}" /></td>
						</tr>
						<tr>
							<td class="more_search_item">申报人：</td>
							<td>
								<select name="shiyrid">
									<option value="">请选择…</option>
									<#list usersCursor as obj>
										<option value="${obj['RWID']}" <#if obj["RWID"] == shiyrid>selected</#if>>${obj["OBJNAME"]}</option>
									</#list>
								</select>
							</td>
						</tr>
					</table>
				</div>
				<div class="more_search_bottom">
					<div class="iframe_btn iframe_btn_qk">清空</div>
					<input type="submit" class="iframe_btn iframe_btn_qd" value="确定" />
					<div class="iframe_btn iframe_btn_qx">取消</div>
				</div>
			</div>
			<div class="total_price">
				<div class="container_box">
					您所选的资产共计：<span id="total_number">0</span>&nbsp;条
				</div>
			</div>
		</form>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
		<script>

			$(function() {
				// 如需重写基础 JS 模版中的事件，应当事先移除本页所有已绑定的函数，否则可能会产生一些难以处理的 bug
				$("form").off();

				setMaxheight(70);

				// 生成日历
				$("#date_begin").ligerDateEditor();
				$("#date_end").ligerDateEditor();

				// 将日历文本框设为只读
				$("#date_begin, #date_end").attr("readonly", true);

				// 盘点基准日切换查询
				$("#qcjzr").change(function() {
					var qcjzr = $(this).val();
					$("#pd_card").prop("action", "${request.contextPath}/Monitor/Pdjk/pdCard");
					$("#pd_card").submit();
				});

				$(".toolbar_dc").click(function() {
					var idArr = new Array();
					var count = 0;
					$("input[class='chk']:checked").each(function() {
						idArr[count] = $(this).val();
						count++;
					});
					if (idArr.length > 0) {
						$("#pd_card #checkedIdStr").val(idArr);
						var $action = $("#pd_card").prop("action");
						$("#pd_card").prop("action", "${request.contextPath}/Monitor/Pdjk/exportExcel").submit();
						$("#pd_card").prop("action", $action);
					} else {
						// 提示框
						$(".tips_dc_wushuju").fadeIn(200).delay(800).fadeOut(400);
					}
				});

				$("#pd_card").submit(function() {
					var $action = $(this).prop("action");
					// 仅在导出操作时屏蔽动画
					if ($action.indexOf("export") < 0) {
						$iframe.prev(".l-tab-loading").show();
					}
				});

			});

			window.onresize = function() {
				setMaxheight(70);
			}

		</script>
	</body>
</html>