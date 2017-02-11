<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>使用人-我要申领-待提交</title>
	<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
</head>
<body>
	<div class="container_card">
		<div class="main_tabs">
			<div class="container">
				<ul class="main_tabs_list">
					<li><a id="daitj" class="active" href="javascript:void(0)">待提交</a><span class="sanjx_jt active"></span></li>
					<li><a id="shenhz" href="javascript:void(0)">审核中</a><span class="sanjx_jt"></span></li>
					<li><a id="yish" href="javascript:void(0)">已审核</a><span class="sanjx_jt "></span></li>
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
						<form class="query_form" action="${request.contextPath}/orgSlpz/main/${pageId}/${currentUser.currentRoleCode}" method="get">
							<#-- 普通查找-->
							<input id="condsql" name="condsql" type="hidden" value="${condsql}" />
							<input id="keyvalueStr" name="keyvalueStr" type="text" value="${keyvalueStr}" />
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
						<#if pageId == "wysl">
							<li class="gn_add_btn"><a href="#">增加申领资产</a><span></span></li>
							<li class="toobar_line"></li>
							<li class="gn_del_btn"><a href="javascript:void(0)">删除申领</a><span></span></li>
							<li class="toobar_line"></li>
							<li class="gn_submit_btn"><a href="javascript:void(0)">提交申领</a><span></span></li>
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
						<col width=10%></col>
						<col width=8%></col>
						<col width=8%></col>
						<col width=7%></col>
						<col width=7%></col>
						<col width=8%></col>
						<col width=8%></col>
						<col width=10%></col>
						<col width=10%></col>
						<col width=5%></col>
						<col width=5%></col>
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
						<td class colspan="2">
							<a href="javascript: void(0)">
								业务操作
								<span class="card_order_jt"></span>
							</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="list_wapper_content">
				<table>
					<colgroup>
						<col width=3%></col>
						<col width=3%></col>
						<col width=10%></col>
						<col width=8%></col>
						<col width=8%></col>
						<col width=7%></col>
						<col width=7%></col>
						<col width=8%></col>
						<col width=8%></col>
						<col width=10%></col>
						<col width=10%></col>
						<col width=5%></col>
						<col width=5%></col>
					</colgroup>
					<#list page.results as obj> 
						<tr >
							<td class="xuhao">${obj_index + 1}</td>
							<td class="list_td_label">
								<label class="list_label fl"><input class="chk" type="checkbox" value="${obj['RWID']}" price="${obj['YUJJZ']}"/></label>
							</td>
							<td><a href="javascript: void(0)">${obj["ZICFL"]}</a></td>
							<td>${obj["ZICMC"]}</td>
							<td>${obj["SHENBRQ"]}</td>
							<td>${obj["SHENBR"]}</td>
							<td>${obj["GUIGXH"]}</td>
							<td>${((obj["YUJDJ"]?string("0.00"))!"0.00")}</td>
							<td>${((obj["SHUL"]?string("0.00"))!"0.00")}</td>
							<td>${((obj["YUJJZ"]?string("0.00"))!"0.00")}</td>
							<td>${obj["SHENLYT"]}</td>
							<td>${obj["SHENLYY"]}</td>
							<#if pageId == "wysl">
								<#--待提交-->
								<td><a class="fr sl_tj" href="javascript:void(0)">提交</a></td>
								<td><a class="font_false sl_tj_cancel" href="javascript:void(0)">删除</a></td>
							<#elseif pageId == "auditting">
								<#--审核中-->
								<td><a class="shiyongren reviewProcess fr" href="javascript:void(0)">查看流程</a></td>
								<td><a class="shiyongren font_false sl_submit_cancel" href="javascript:void(0)">取消送审</a></td>
							<#elseif pageId == "auditted">
								<#--已审核-->
								<td colspan="2"><a class="danwei reviewProcess" href="#">查看流程</a></td>
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
	<form class="filter_form" action="" method="post">
		<div class="more_search">
			<div class="more_search_main">
				<table>
					<tr>
						<td class="more_search_item">资产名称：</td>
						<td><input name="zicmc" type="text" placeholder="可模糊查询资产名称" /></td>
						<td class="more_search_item">规格型号：</td>
						<td><input name="guigxh" type="text"/></td>
					</tr>
					<tr>
						<td class="more_search_item">资产大类：</td>
						<td>
							<select>
								<option value=""></option>
								<option value="">土地、房屋及构筑物</option>
								<option value="">通用设备</option>
								<option value="">专用设备</option>
								<option value="">文物和陈列品</option>
								<option value="">图书、档案</option>
								<option value="">家具、用具、装具及动植物</option>
								<option value="">无形资产</option>
							</select>
						</td>
						<td class="more_search_item">申领用途：</td>
						<td>
							<select>
								<option value=""></option>
								<option value="">办公使用</option>
								<option value="">教学使用</option>
								<option value="">培训使用</option>
								<option value="">执法执勤</option>
								<option value="">窗口使用</option>
								<option value="">专业用途</option>
								<option value="">其他业务使用</option>
								<option value="">用于公共服务对象</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="more_search_item">预计单价：</td>
						<td><input name="objcode_min" type="text" style="text-align: right"/></td>
						<td class="more_search_item" style="text-align: center">至</td>
						<td><input name="objcode_max" type="text" style="text-align: right"/></td>
					</tr>
					<tr class="search_date">
						<td class="more_search_item">申领日期：</td>
						<td class="search_datebox"><input id="shenlrq_begin" name="shenlrq_begin" type="text"/></td>
						<td class="more_search_item" style="text-align: center">
							至
							<div class="query_button_tips">起始日期不能大于截止日期！</div>
						</td>
						<td class="search_datebox"><input id="shenlrq_end" name="shenlrq_end" type="text"/></td>
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
	<#include "/base/base_org_js.ftl" />	
	<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
	<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
	<script>
		$(function(){

			setMaxheight(0);
			<#--申领日期-->
			$('#shenlrq_begin').ligerDateEditor();
			$('#shenlrq_end').ligerDateEditor();
			$('.gn_add_btn').click(function() {//增加申领资产
				var index = layer.open({
					type:2,
					title:'申领资产分类',
					content:'${request.contextPath}/findZicfl',
					area:['800px','560px']
				})
				<#--window.parent.alertPublicModal("申领资产分类","${request.contextPath}/findZicfl");-->
			});
			<#--页签跳转显示     BEGIN-->
			<#--跳转待提交-->
			$("#daitj").click(function(){
				var actionUrl = "${request.contextPath}/orgSlpz/main/wysl/${currentUser.currentRoleCode}";
				$(".query_form").prop("action",actionUrl).submit();
			})
			<#--跳转审核中-->
			$("#shenhz").click(function(){
				var actionUrl = "${request.contextPath}/orgSlpz/main/auditting/${currentUser.currentRoleCode}";
				$(".query_form").prop("action",actionUrl).submit();
			})
			<#--跳转已审核-->
			$("#yish").click(function(){
				var actionUrl = "${request.contextPath}/orgSlpz/main/auditted/${currentUser.currentRoleCode}";
				$(".query_form").prop("action",actionUrl).submit();
			})
			<#--页签显示-->
			<#if pageId == "wysl">
				$(".main_tabs_list a").removeClass("active");
				$(".main_tabs_list span").removeClass("active");
				$("#daitj").addClass("active");
				$("#daitj").next().addClass("active");
			<#elseif pageId == "auditting">
				$(".main_tabs_list a").removeClass("active");
				$(".main_tabs_list span").removeClass("active");
				$("#shenhz").addClass("active");
				$("#shenhz").next().addClass("active");
			<#elseif pageId == "auditted">
				$(".main_tabs_list a").removeClass("active");
				$(".main_tabs_list span").removeClass("active");
				$("#yish").addClass("active");
				$("#yish").next().addClass("active");
			</#if>
			<#--页签跳转显示     END-->
			
			<#--待提交页面     BEGIN-->
			//删除申领单
			$(".gn_del_btn").click(function() {
				var shenldIdStr;
				deleteSlds(shenldIdStr);
			});
			$('.sl_tj_cancel').click(function(){
				var shenldIdStr = $(this).parents('tr').find('input').val();
				deleteSlds(shenldIdStr);
			})
			//提交申领单
			$('.sl_tj').click(function(){
				var shenldIdStr = $(this).parents('tr').find('input').val();
				submitSlds(shenldIdStr);
			})
			$(".gn_submit_btn").click(function() {
				var shenldIdStr;
				submitSlds(shenldIdStr);
			});
			//取消送审
			$(".gn_cancel_btn").click(function(){
				var shenldIdStr = $(this).parents('tr').find('input').val();
				cancelSubmitSlds(shenldIdStr);
			})
			$(".sl_submit_cancel").click(function(){
				var shenldIdStr = $(this).parents('tr').find('input').val();
				cancelSubmitSlds(shenldIdStr);
			})
			<#--待提交页面     END-->
			
			<#--审核中        BEGIN-->
			<#--工作流查看-->
			$(".reviewProcess").click(function(){
				var checkedIdStr = $(this).parents('tr').find('input').val();
				window.parent.alertEditModal("审核流程","${request.contextPath}/orgSlpz/getWf/${currentUser.currentRoleCode}/" + checkedIdStr);
			})
			<#--审核中        END-->
			
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
		
		function submitSlds(shenldIdStr){
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
						{"_method": "PUT",
						 "checkedIdStr": idsStr,
						 "pzzt":pzztStr,
						 "condsql":condsqlStr,
						 "keyvalue":keyvalueStr,
						 "wfzt":wfztStr,
						 "shenpyj":shenpyjStr
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
		
		function cancelSubmitSlds(shenldIdStr){
			var idArr = new Array();
			var count = 0;
			var pzztStr = $("#pzzt").val();
			var condsqlStr = $("#condsql").val();
			var keyvalueStr = $("#keyvalue").val();
			var wfztStr = $("#wfzt").val();
			var shenpyjStr = $("#shenpyj").val();
			var pageId = "${pageId}";
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
						{"_method": "PUT",
						 "checkedIdStr": idsStr,
						 "pzzt":pzztStr,
						 "condsql":condsqlStr,
						 "keyvalue":keyvalueStr,
						 "wfzt":wfztStr,
						 "shenpyj":shenpyjStr,
						 "pageId":pageId
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
		
		
	</script>
</body>
</html>