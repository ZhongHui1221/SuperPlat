<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>部门-配置管理</title>
	<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
</head>
<body>
	<div class="container_card">
		<div class="main_tabs">
			<div class="container">
				<ul class="main_tabs_list">
					<li><a id="danwei_daish" class="active" href="javascript:void(0)">待审核</a><span class="sanjx_jt active"></span></li>
					<li><a id="danwei_yish"href="javascript:void(0)">已审核</a><span class="sanjx_jt "></span></li>
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
						<li class="gn_check_btn"><a href="#">审核</a><span></span></li>
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
						<col width=9%></col>
						<col width=9%></col>
						<col width=10%></col>
						<col width=7%></col>
						<col width=7%></col>
						<col width=8%></col>
						<col width=8%></col>
						<col width=8%></col>
						<col width=8%></col>
						<col width=8%></col>
						<#-- 待审核 -->
						<#-- <col width=12%></col> -->
						<#-- 已审核 -->
						<col width="4%"></col>
						<col width="8%"></col>
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
						<#-- 待审核 -->
						<#-- <td class="sort" colspan="2">
							<a href="javascript: void(0)">
								业务操作
								<span class="card_order_jt" column="XUANZJE"></span>
							</a>
						</td> -->
						<#-- 已审核 -->
						<td class="sort">
							<a href="javascript: void(0)">
								状态
								<span class="card_order_jt" column="XUANZJE"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								业务操作
								<span class="card_order_jt" column="XUANZJE"></span>
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
						<col width=9%></col>
						<col width=9%></col>
						<col width=10%></col>
						<col width=7%></col>
						<col width=7%></col>
						<col width=8%></col>
						<col width=8%></col>
						<col width=8%></col>
						<col width=8%></col>
						<col width=8%></col>
						<#-- 待审核 -->
						<#-- <col width=12%></col> -->
						<#-- 已审核 -->
						<col width="4%"></col>
						<col width="8%"></col>
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
							<#-- 待审核 -->
							<#-- <td colspan="2"><a class="shenlsh" href="#">审核</a></td> -->
							<#-- 已审核 -->
							<td>状态</td>
							<td><a href="#">查看流程</a></td>
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
			$('.shenlsh').click(function(){//选择审核的方式
				window.parent.alertPublicModal("选择审核的方式","./page/shenling/sl_shenhe_danwei.html");;
			})
		})
		window.onresize = function(){
			setMaxheight(0);
		}
		
		function setMaxheight(hdeff) {
			$(".list_wapper").height($(window).height() - 140 - hdeff);
			$(".list_wapper .list_wapper_content").height($(".list_wapper").height() - 50);
			if ($(".list_wapper_content").height() > $(".list_wapper_content table").height()) {
				$(".list_wapper_header").css("padding-right", "0");
			} else {
				$(".list_wapper_header").css("padding-right", "17px");
			}
		}
	</script>
</body>
</html>