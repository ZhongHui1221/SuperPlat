<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>部门-配置管理</title>
	<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
	<style>
		.list_wapper.container{
			min-width:1028px;
		}
	</style>
</head>
<body>
	<div class="container_card">
		<div class="main_tabs">
			<div class="container">
				<ul class="main_tabs_list">
					<li><a id="bm_daish" class="active" href="javascript:void(0)">待审核</a><span class="sanjx_jt active"></span></li>
					<li><a id="bm_shenhz" href="javascript:void(0)">审核中</a><span class="sanjx_jt"></span></li>
					<li><a id="bm_yish" href="javascript:void(0)">已审核</a><span class="sanjx_jt "></span></li>
				</ul>
			</div>
		</div>
		<div class="toolbar_wapper container">
			<div class="toolbar_box">
				<div class="toolbar_left fl">
					<div class="toobar_chosethis fl">
						<label class="fl"><input id="chkThisPage" type="checkbox" /></label>
						<div class="fl">选择当前页</div>
					</div>
					<div class="toobar_search fl">
						<form class="query_form" action="" method="get">
							<#-- 普通查找-->
							<input id="condsql" name="condsql" type="hidden" value="${condsql}" />
							<input name="keyvalueStr" type="text" value="" />
							<#--业务相关-->
							<input id="pzzt" name="pzzt" type="hidden" value="${pzzt}" />
							<input id="wfzt" name="wfzt" type="hidden" value="${wfzt}" />
							<input id="shenpyj" name="shenpyj" type="hidden" value="${shenpyj}" />
							<#--多条件筛选-->
							<#-- 排序相关-->
							<input name="sortpartStr" type="hidden" value="${sortpartStr}" />
							<#-- 选中数据的 ID 集合 -->
							<input id="checkedIdStr" name="checkedIdStr" type="hidden" />
							<button class="toobar_search_btn" type="submit"><span></span></button>
						</form>
						<div class="searchcard_tip">请输入要查找的内容</div>
					</div>
					<div class="toobar_moresearch fl">更多筛选条件</div>
				</div>
				<div class="toolbar_right fr">
					<div class="toolbar_fy fl">
						<ul>
							<li class="toobar_jt toobar_jtll">
								<a class="toobar_jtll_a" href="javascript:void(0)"></a>
							</li>
							<li class="toobar_jt toobar_jtl">
								<a class="toobar_jtl_a" href="javascript:void(0)"></a>
							</li>
							<li class="toobar_pagenum"><input id="page_switch" type="text" value="${page.pageNo}" /></li>
							<li style="width: 10px">/</li>
							<li>${page.totalPageNo}</li>
							<li class="toobar_jt toobar_jtr">
								<a class="toobar_jtr_a" href="javascript:void(0)"></a>
							</li>
							<li class="toobar_jt toobar_jtrr">
								<a class="toobar_jtrr_a" href="javascript:void(0)"></a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="toolbar_box">
				<div class="toolbar_left fl">
					<ul class="shenl_action toolbar_left_list">
						<#if pageId == "peizgl">
							<li class="gn_check_btn reviewProcess bm_check_slds"><a href="#">审核</a><span></span></li>
							 <li class="toobar_line"></li>
							<li class="gn_apply_btn"><a href="#">申领</a><span></span></li> 
						<#elseif pageId == "auditting">
							<li class="gn_cancel_btn"><a href="javascript:void(0)">取消送审</a><span></span></li>
						</#if>
					</ul>
				</div>
				<div class="toolbar_right fr">
					<ul class="gongneng_list fl">
						<li class="toolbar_dc toolbar_item">导出<span></span></li>
						<li class="toobar_line"></li>
						<li class="toolbar_dy toolbar_item">打印 / 预览<span></span></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="list_wapper container">
			<div class="list_wapper_header">
				<table class="list_table_header">
					<colgroup>
						<col width=3%></col>
						<col width=3%></col>
						<col width=7%></col>
						<col width=7%></col>
						<col width=7%></col>
						<#if pageId == "peizgl">
							<col width=6%></col>
							<col width=6%></col>
							<col width=7%></col>
							<col width=8%></col>
							<col width=8%></col>
							<col width=7%></col>
							<col width=7%></col>
							<col width=5%></col>
							<col width=7%></col>
							<col width=4%></col>
							<col width=4%></col>
							<col width=4%></col>
						<#else>
							<col width=7%></col>
							<col width=7%></col>
							<col width=7%></col>
							<col width=8%></col>
							<col width=10%></col>
							<col width=10%></col>
							<col width=5%></col>
							<col width=7%></col>
							<col width=7%></col>
						</#if>
					</colgroup>
					<tr>
						<td><div class="xuhao_header">序号</div></td>
						<td></td>
						<td class="sort">
							<a href="javascript: void(0)">
								资产分类
								<span class="card_order_jt" column="ZICFL"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								资产名称
								<span class="card_order_jt" column="ZICMC"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								申报日期
								<span class="card_order_jt" column="SHENBRQ"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								申报人
								<span class="card_order_jt" column="SHENBR"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								规格要求
								<span class="card_order_jt" column="GUIGXH"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								预计单价(元)
								<span class="card_order_jt" column="YUJDJ"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								申报数量
								<span class="card_order_jt" column="SHUL"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								预计总价(元)
								<span class="card_order_jt" column="YUJJZ"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								申领用途
								<span class="card_order_jt" column="SHENLYT"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								申领原因
								<span class="card_order_jt" column="SHENLYY"></span>
							</a>
						</td>
						<#if pageId == "peizgl">
							<#--待审核-->
							<td class="sort">
								<a href="javascript: void(0)">
									状态
									<span class="card_order_jt" column="XUANZJE"></span>
								</a>
							</td>
							<td class colspan="4">
								<a href="javascript: void(0)">
									业务操作
									<span class="card_order_jt" column="XUANZJE"></span>
								</a>
							</td>
						<#elseif pageId == "auditting">
							<#--审核中-->
							<td class colspan="2">
								<a href="javascript: void(0)">
									业务操作
									<span class="card_order_jt" column="XUANZJE"></span>
								</a>
							</td>
						<#elseif pageId == "auditted">
							<#--已审核-->
							<td class="sort">
								<a href="javascript: void(0)">
									状态
									<span class="card_order_jt" column="XUANZJE"></span>
								</a>
							</td>
							<td class colspan="4">
								<a href="javascript: void(0)">
									业务操作
									<span class="card_order_jt" column="XUANZJE"></span>
								</a>
							</td>
						</#if>
					</tr>
				</table>
			</div>
			<div class="list_wapper_content">
				<table>
					<colgroup>
						<col width=3%></col>
						<col width=3%></col>
						<col width=7%></col>
						<col width=7%></col>
						<col width=7%></col>
						<#if pageId == "peizgl">
							<col width=6%></col>
							<col width=6%></col>
							<col width=7%></col>
							<col width=8%></col>
							<col width=8%></col>
							<col width=7%></col>
							<col width=7%></col>
							<col width=5%></col>
							<col width=7%></col>
							<col width=4%></col>
							<col width=4%></col>
							<col width=4%></col>
						<#else>
							<col width=7%></col>
							<col width=7%></col>
							<col width=7%></col>
							<col width=8%></col>
							<col width=10%></col>
							<col width=10%></col>
							<col width=5%></col>
							<col width=7%></col>
							<col width=7%></col>
						</#if>
					</colgroup>
					<#list page.results as obj> 
						<tr >
							<td class="xuhao">${obj_index + 1}</td>
							<td class="list_td_label">
								<label class="list_label fl"><input class="chk" type="checkbox" value="${obj['RWID']}" price="${obj['YUJJZ']}"/></label>
							</td>
							<td>${obj["ZICFL"]}</td>
							<td>${obj["ZICMC"]}</td>
							<td>${obj["SHENBRQ"]}</td>
							<td>${obj["SHENBR"]}</td>
							<td>${obj["GUIGXH"]}</td>
							<td>${((obj["YUJDJ"]?string("0.00"))!"0.00")}</td>
							<td>${((obj["SHUL"]?string("0.00"))!"0.00")}</td>
							<td>${((obj["YUJJZ"]?string("0.00"))!"0.00")}</td>
							<td>${obj["SHENLYT"]}</td>
							<td>${obj["SHENLYY"]}</td>
							<#if pageId == "peizgl">
								<td><#if (!obj["SHENQZT"]??) || (obj["SHENQZT"] == "0")>未提交<#elseif obj["SHENQZT"] == "2">待审核<#elseif obj["SHENQZT"] == "1">退回<#elseif obj["SHENQZT"] == "3">未提交(待定)</#if></td>
								<td><a class="shiyongren reviewProcess checkProcess" href="javascript:void(0)">查看流程</a></td>
								<td><a class="shiyongren reviewProcess" href="javascript:void(0)">编辑</a></td>
								<td <#if obj["SHENQRID"] != currentUser.id>colspan="2"</#if>><a class="danwei reviewProcess sl_sh" href="javascript:void(0)">审核</a></td>
								<#if obj["SHENQRID"] == currentUser.id>
									<td><a class="font_false sl_tj_cancel" href="javascript:void(0)">删除</a></td>
								</#if>
							<#elseif pageId == "auditting">
								<#--审核中-->
								<td><a class="shiyongren reviewProcess fr" href="javascript:void(0)">查看流程</a></td>
								<td><a class="shiyongren font_false" href="javascript:void(0)">取消送审</a></td>
							<#elseif pageId == "auditted">
								<#--已审核-->
								<td>状态</td>
								<td colspan="2"><a class="danwei reviewProcess" href="javascript:void(0)">查看流程</a></td>
							</#if>
						</tr>
					</#list> 
				</table>
			</div>
		</div>
	</div>
	<div class="total_price">
		<div class="container">
			您所选的资产共计：<span id="total_number">0</span>&nbsp;条，金额共计：<span id="total_price">0.00</span>&nbsp;元
		</div>
	</div>
	<#include "/base/base_org_js.ftl" />
	<script src="${request.contextPath}/static/framework/ligerui-lib/jquery/jquery-1.9.0.min.js"></script>
	<script>
		$(function(){
			setMaxheight(0);
			$('.gn_apply_btn').click(function(){//增加申领资产
				window.parent.alertPublicModal("申领资产分类","${request.contextPath}/findZicfl");
			});
			<#--页签跳转显示     BEGIN-->
			<#--跳转待审核-->
			$("#bm_daish").click(function(){
				var actionUrl = "${request.contextPath}/orgSlpz/main/peizgl/${currentUser.currentRoleCode}";
				$(".query_form").prop("action",actionUrl).submit();
			})
			<#--跳转审核中-->
			$("#bm_shenhz").click(function(){
				var actionUrl = "${request.contextPath}/orgSlpz/main/auditting/${currentUser.currentRoleCode}";
				$(".query_form").prop("action",actionUrl).submit();
			})
			<#--跳转已审核-->
			$("#bm_yish").click(function(){
				var actionUrl = "${request.contextPath}/orgSlpz/main/auditted/${currentUser.currentRoleCode}";
				$(".query_form").prop("action",actionUrl).submit();
			})
			<#--页签显示-->
			<#if pageId == "peizgl">
				$(".main_tabs_list a").removeClass("active");
				$(".main_tabs_list span").removeClass("active");
				$("#bm_daish").addClass("active");
				$("#bm_daish").next().addClass("active");
			<#elseif pageId == "auditting">
				$(".main_tabs_list a").removeClass("active");
				$(".main_tabs_list span").removeClass("active");
				$("#bm_shenhz").addClass("active");
				$("#bm_shenhz").next().addClass("active");
			<#elseif pageId == "auditted">
				$(".main_tabs_list a").removeClass("active");
				$(".main_tabs_list span").removeClass("active");
				$("#bm_yish").addClass("active");
				$("#bm_yish").next().addClass("active");
			</#if>
			<#--页签跳转显示     END-->
			
			<#--待提交页面     BEGIN-->
			//删除申领单
			$('.sl_tj_cancel').click(function(){
				var shenldIdStr = $(this).parents('tr').find('input').val();
				deleteSlds(shenldIdStr);
			})
			//审核申领单
			$('.bm_check_slds').click(function(){
	        	window.parent.alertPublicModal("选择审核的方式","${request.contextPath}/orgSlpz/getBmCheckPage/${currentUser.currentRoleCode}/" + checkedIdStr);
	      })
			$('.sl_sh').click(function(){
	        	window.parent.alertPublicModal("选择审核的方式","${request.contextPath}/orgSlpz/getBmCheckPage/${currentUser.currentRoleCode}/" + checkedIdStr);
	      })
			$('.sl_tj').click(function(){
				var shenldIdStr = $(this).parents('tr').find('input').val();
				checkSlds(shenldIdStr);
			})
			$(".gn_check_btn").click(function() {
				var shenldIdStr;
				checkSlds(shenldIdStr);
			});
			<#--待提交页面     END-->
			
			<#--工作流程查看-->
			$(".checkProcess").click(function(){
				var checkedIdStr = $(this).parents('tr').find('input').val();
				window.parent.alertEditModal("审核流程","${request.contextPath}/orgSlpz/getWf/${currentUser.currentRoleCode}/" + checkedIdStr);
			})

		})
		window.onresize = function(){
			setMaxheight(0);
		}
		// 卡片列表模式页面动态给列表赋值最大高度
		function setMaxheight(hdeff) {
			$(".list_wapper").height($(window).height() - 140 - hdeff);
			$(".list_wapper .list_wapper_content").height($(".list_wapper").height() - 50);
			if ($(".list_wapper_content").height() > $(".list_wapper_content table").height()) {
				$(".list_wapper_header").css("padding-right", "0");
			} else {
				$(".list_wapper_header").css("padding-right", "17px");
			}
		}
		
			function deleteSlds(shenldIdStr){
			alert("alala");
			var idArr = new Array();
			var count = 0;
			var pzztStr = $("#pzzt").val();
			var condsqlStr = $("#condsql").val();
			var keyvalueStr = $("keyvalue").val();
			if(shenldIdStr){
				idArr[count] = shenldIdStr;
			}else{
				$("input[class='chk']:checked").each(function() {
					idArr[count] = $(this).val();
					count++;
				});
			}
			if (idArr.length > 0) {
				$("#checkedIdStr").val(idArr);
				var idsStr = $("#checkedIdStr").val();
				$.post(
						"${request.contextPath}/orgSlpz/deleteShenld/${currentUser.currentRoleCode}",
						{"_method": "DELETE",
						 "checkedIdStr": idsStr,
						 "pzzt":pzztStr,
						 "condsql":condsqlStr,
						 "keyvalue":keyvalueStr
						 },
						function(data) {
							if (data == "SUCCESS") {
								$(".query_form").submit();
							} else {
								alert(data);
							}
						}
					);
			} 
		}
		
		function checkSlds(shenldIdStr){
			var idArr = new Array();
			var count = 0;
			var pzztStr = $("#pzzt").val();
			var condsqlStr = $("#condsql").val();
			var keyvalueStr = $("#keyvalue").val();
			var wfztStr = $("#wfzt").val();
			var shenpyjStr = $("#shenpyj").val();
			if(shenldIdStr){
				idArr[count] = shenldIdStr;
			}else{
				$("input[class='chk']:checked").each(function() {
					idArr[count] = $(this).val();
					count++;
				});
			}
			if (idArr.length > 0) {
				$("#checkedIdStr").val(idArr);
				var idsStr = $("#checkedIdStr").val();
				$.post(
						"${request.contextPath}/orgSlpz/submitShenld/${currentUser.currentRoleCode}",
						{"_method": "POST",
						 "checkedIdStr": idsStr,
						 "pzzt":pzztStr,
						 "condsql":condsqlStr,
						 "keyvalue":keyvalueStr,
						 "wfzt":wfztStr,
						 "shenpyj":shenpyjStr
						 },
						function(data) {
							if (data == "SUCCESS") {
								$(".query_form").prop("action","");
								$(".query_form").submit();
							} else {
								alert(data);
							}
						}
					);
			} 
		}

	</script>
</body>
</html>