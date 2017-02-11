<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible"  content="IE=edge,chrome=1">
		<meta name="renderer" content="webkit">
		<title>信息变更 - 待提交</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
	</head>
	<body>
		<div class="container_card">
			<div class="main_tabs">
				<div class="container">
					<ul class="main_tabs_list">
						<li><a class="active" href="">待提交</a><span class="sanjx_jt active"></span></li>
						<li><a href="./xinxigengz_daishenhe.htm">待审核</a><span class="sanjx_jt"></span></li>
						<li><a href="./xinxigengz_shenhezhong.htm">审核中</a><span class="sanjx_jt "></span></li>
						<li><a href="./xinxigengz_yishenhe.htm">已审核</a><span class="sanjx_jt"></span></li>
						<li><a href="./xinxigengz_yishenxiao.htm">已生效</a><span class="sanjx_jt"></span></li>
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
							<form class="query_form" action="" method="post">
								<input name="keyvalueStr" type="text" value="" />
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
								<li class="toobar_pagenum"><input id="page_switch" type="text" value="1" /></li>
								<li style="width: 10px">/</li>
								<li>100</li>
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
				<div class="toolbar_box" style="margin-bottom: 4px">
					<div class="toolbar_left fl">
						<ul class="yewu_action">
							<li class="yewu_shanchu toolbar_item"><a href="javascript:void(0)">删除</a><span></span></li>
							<li class="toobar_line"></li>
							<!-- 单位资产管理员角色 只显示送财务审批 -->
							<li class="yewu_scwsp toolbar_item"><a href="javascript:void(0)">送财务审批</a><span></span></li>
							<li class="toobar_line"></li>
							<!-- 财务制单人员 只显示送资产管理员审批 -->
							<li class="yewu_szcglysp toolbar_item"><a href="javascript:void(0)">送资产管理员审批</a><span></span></li>
						</ul>
					</div>
					<div class="toolbar_right fr">
						<ul class="gongneng_list fl">
							<li class="toolbar_dc toolbar_item">导出<span></span></li>
							<li class="toobar_line"></li>
							<li class="toolbar_dy toolbar_item">打印 / 预览<span></span></li>
						</ul>
						<div class="toolbar_tips">您尚未勾选任何数据！</div>
					</div>
				</div>
			</div>
			<div class="list_wapper container">
				<div class="list_wapper_header">
					<table class="list_table_header">
						<colgroup>
							<col width="4%"></col>
							<col width="3%"></col>
							<col width="7%"></col>
							<col width="8%"></col>
							<col width="8%"></col>
							<col width="9%"></col>
							<col width="10%"></col>
							<col width="8%"></col>
							<col width="6%"></col>
							<col width="7%"></col>
							<col width="6%"></col>
							<col width="5%"></col>
							<col width="9%"></col>
							<col width="10%"></col>
						</colgroup>
						<tr>
							<td><div class="xuhao_header">序号</div></td>
							<td></td>
							<td class="sort">
								<a href="javascript: void(0)">
									更正方式
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									资产名称
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									资产编号
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									购置日期
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									财务入账日期
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									凭证号
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									面积
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									折旧年限
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									价值
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									数量
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									更正原因
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td>操作</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<colgroup>
							<col width="4%"></col>
							<col width="3%"></col>
							<col width="7%"></col>
							<col width="8%"></col>
							<col width="8%"></col>
							<col width="9%"></col>
							<col width="10%"></col>
							<col width="8%"></col>
							<col width="6%"></col>
							<col width="7%"></col>
							<col width="6%"></col>
							<col width="5%"></col>
							<col width="9%"></col>
							<col width="5%"></col>
							<col width="5%"></col>
						</colgroup>
						<!-- tr 分为 修改和删除 2种类型 -->
						<tr class="list_xxgz">
							<td class="xuhao">1</td>
							<td class="list_td_label">
								<label class="list_label fl"><input class="chk" type="checkbox" /></label>
							</td>
							<td>修改</td>
							<td><a class="xxgz_zcmc" href="javascript: void(0)">笔记本电脑</a></td>
							<td class="xxgz_zcbh">PF20160</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_gzrq_b">2016-11-12</div>
								<div class="xxgz_current_info">2017-11-12</div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_cwrzrq_b">2016-11-12</div>
								<div class="xxgz_current_info">2017-11-12</div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_pzh_b">1234</div>
								<div class="xxgz_current_info">12</div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_mj_b">100</div>
								<div class="xxgz_current_info">90</div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_zjnx_b"></div>
								<div class="xxgz_current_info"></div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_jz_b">1000</div>
								<div class="xxgz_current_info">200</div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_sl_b">1</div>
								<div class="xxgz_current_info">2</div>
							</td>
							<td>
								<div class="gzyy_info">更正原因是网上购物淘宝</div>
							</td>
							<td><a class="xxgz_edit" href="javascript:void(0)">编辑</a></td>
							<td><a class="xxgz_delete" href="javascript:void(0)">删除</a></td>
						</tr>
						<tr class="list_xxgz tr_color">
							<td class="xuhao">1</td>
							<td class="list_td_label">
								<label class="list_label fl"><input class="chk" type="checkbox" /></label>
							</td>
							<td>修改</td>
							<td><a class="xxgz_zcmc" href="javascript: void(0)">笔记本电脑</a></td>
							<td class="xxgz_zcbh">PF20160</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_gzrq_b">2016-11-12</div>
								<div class="xxgz_current_info">2017-11-12</div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_cwrzrq_b">2016-11-12</div>
								<div class="xxgz_current_info">2017-11-12</div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_pzh_b">1234</div>
								<div class="xxgz_current_info">12</div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_mj_b">100</div>
								<div class="xxgz_current_info">90</div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_zjnx_b"></div>
								<div class="xxgz_current_info"></div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_jz_b">1000</div>
								<div class="xxgz_current_info">200</div>
							</td>
							<td class="border_td">
								<div class="xxgz_before_info xxgz_sl_b">1</div>
								<div class="xxgz_current_info">2</div>
							</td>
							<td>
								<div class="gzyy_info">更正原因是网上购物淘宝</div>
							</td>
							<td><a class="xxgz_edit" href="javascript:void(0)">编辑</a></td>
							<td><a class="xxgz_delete" href="javascript:void(0)">删除</a></td>
						</tr>
						<tr class="list_xxgz">
							<td class="xuhao">1</td>
							<td class="list_td_label">
								<label class="list_label fl"><input class="chk" type="checkbox" /></label>
							</td>
							<td>删除</td>
							<td><a href="javascript: void(0)">笔记本电脑</a></td>
							<td>PF20160</td>
							<td>2017-11-12</td>
							<td>2017-11-12</td>
							<td>1234</td>
							<td>100</td>
							<td>1</td>
							<td>20</td>
							<td>1</td>
							<td>
								<div class="gzyy_info">更正原因是网上购物淘宝</div>
							</td>
							<td><a class="xxgz_edit" href="javascript:void(0)">编辑</a></td>
							<td><a class="xxgz_delete" href="javascript:void(0)">删除</a></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="total_price">
			<div class="container">
				您所选的资产共计：<span id="total_number">0</span>&nbsp;条，金额共计：<span id="total_price">0.00</span>&nbsp;元
			</div>
		</div>
		<!-- 编辑弹出框 -->
		<div class="xxgz_edit_container">
			<div class="ifm_in_modal_header">
				<div class="ifm_in_modal_info">编辑信息更正</div>
				<div class="ifm_about_icon"></div>
				<div class="ifm_close"></div>
			</div>
			<div class="xxgz_edit_wapper">
				<table class="xxgz_edit_table">
					<tr>
						<td class="td_item">资产名称：</td>
						<td class="td_info td_xxgz_zcmc"></td>
						<td class="td_info">资产编号：<span class="td_xxgz_zcbh"></span></td>
					</tr>
					<tr>
						<td class="td_item"><span>*</span>更正方式：</td>
						<td class="td_info">
							<select class="td_info_select xxgz_gzfs">
								<option value="edit">修改</option>
								<option value="delete">删除</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="td_item"></td>
						<td class="td_info" style="text-align: center">更正前</td>
						<td class="td_info" style="text-align: center">更正后</td>
					</tr>
					<tr class="tr_item">
						<td class="td_item">购置日期：</td>
						<td class="td_info td_i_disabled td_xxgz_gzrq_b"></td>
						<td class="td_info"><input type="text" id="gzrqDate"></td>
					</tr>
					<tr class="tr_item">
						<td class="td_item">财务入账：</td>
						<td class="td_info td_i_disabled td_xxgz_cwrzrq_b"></td>
						<td class="td_info"><input type="text" id="cwrzDate"></td>
					</tr>
					<tr class="tr_item">
						<td class="td_item">凭证号：</td>
						<td class="td_info td_i_disabled td_xxgz_pzh_b"></td>
						<td class="td_info"><input type="text" id="" name=""></td>
					</tr>
					<tr class="tr_item">
						<td class="td_item">面积：</td>
						<td class="td_info td_i_disabled td_xxgz_mj_b"></td>
						<td class="td_info"><input type="text" id="" name=""></td>
					</tr>
					<tr class="tr_item">
						<td class="td_item">折旧年限：</td>
						<td class="td_info td_i_disabled td_xxgz_zjnx_b"></td>
						<td class="td_info"><input type="text" id="" name=""></td>
					</tr>
					<tr class="tr_item">
						<td class="td_item">数量：</td>
						<td class="td_info td_i_disabled td_xxgz_sl_b"></td>
						<td class="td_info"><input type="text" id="" name=""></td>
					</tr>
					<tr class="tr_item">
						<td class="td_item">价值：</td>
						<td class="td_info td_i_disabled td_xxgz_jz_b"></td>
						<td class="td_info"><input type="text" id="" name=""></td>
					</tr>
					<tr class="tr_item">
						<td class="td_item">更正原因：</td>
						<td class="td_info td_info_text" colspan="2"><textarea></textarea></td>
					</tr>
				</table>
			</div>
			<div class="xxgz_bottom">
				<input class="iframe_btn xxgz_btn_qd" type="button" value="确定">
				<div class="iframe_btn  iframe_btn_qx xxgz_btn_qx">取消</div>
			</div>
		</div>
		<!-- 信息变更5个页面更多筛选字段都一样 -->
		<form class="filter_form" action="" method="post">
			<div class="more_search">
				<div class="more_search_main">
					<table>
						<tr>
							<td class="more_search_item">资产名称：</td>
							<td><input name="zicmc" type="text" value="" placeholder="可模糊查询资产名称" /></td>
							<td class="more_search_item">规格型号：</td>
							<td><input name="guigxh" type="text" value="" placeholder="可模糊查询规格型号" /></td>
						</tr>
						<tr class="search_date">
							<td class="more_search_item">购置日期：</td>
							<td class="search_datebox"><input id="gouzrq_begin" name="gouzrq_begin" type="text" value="" /></td>
							<td class="more_search_item" style="text-align: center">
								至
								<div class="query_button_tips">起始日期不能大于截止日期！</div>
							</td>
							<td class="search_datebox"><input id="gouzrq_end" name="gouzrq_end" type="text" value="" /></td>
						</tr>
						<tr class="search_date">
							<td class="more_search_item">财务入账：</td>
							<td class="search_datebox"><input id="caiwrzrq_begin" name="caiwrzrq_begin" type="text" value="" /></td>
							<td class="more_search_item" style="text-align: center">
								至
								<div class="query_button_tips">起始日期不能大于截止日期！</div>
							</td>
							<td class="search_datebox"><input id="caiwrzrq_end" name="caiwrzrq_end" type="text" value="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">面积：</td>
							<td><input name="mianj_min" type="text" value="" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="mianj_max" type="text" value="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">折旧年限：</td>
							<td><input name="zhejnx_min" type="text" value="" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="zhejnx_max" type="text" value="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">价值：</td>
							<td><input name="jiaz_min" type="text" value="" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="jiaz_max" type="text" value="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">数量：</td>
							<td><input name="shul_min" type="text" value="" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="shul_max" type="text" value="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">凭证号：</td>
							<td><input type="text" name="" /></td>
							<td class="more_search_item">更正方式：</td>
							<td>
								<select>
									<option value=""></option>
									<option value="edit">修改</option>
									<option value="delete">删除</option>
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
		</form>
		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_org_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
		<script>

			$(function(){

				setMaxheight(0);

				// 生成日历
				$("#gzrqDate, #cwrzDate, #gouzrq_begin, #gouzrq_end, #caiwrzrq_begin, #caiwrzrq_end").ligerDateEditor();

				// 弹出编辑框
				$(".xxgz_edit").click(function() {
					var $tr = $(this).parents(".list_xxgz");
					$(".td_xxgz_zcmc").text($tr.find(".xxgz_zcmc").text());
					$(".td_xxgz_zcbh").text($tr.find(".xxgz_zcbh").text());
					$(".td_xxgz_gzrq_b").text($tr.find(".xxgz_gzrq_b").text());
					$(".td_xxgz_cwrzrq_b").text($tr.find(".xxgz_cwrzrq_b").text());
					$(".td_xxgz_pzh_b").text($tr.find(".xxgz_pzh_b").text());
					$(".td_xxgz_mj_b").text($tr.find(".xxgz_mj_b").text());
					$(".td_xxgz_zjnx_b").text($tr.find(".xxgz_zjnx_b").text());
					$(".td_xxgz_sl_b").text($tr.find(".xxgz_sl_b").text());
					$(".td_xxgz_jz_b").text($tr.find(".xxgz_jz_b").text());
					$(".xxgz_edit_container").show();
				});

				// 编辑方式切换效果
				$(".xxgz_gzfs").change(function() {
					if($(this).val() == "delete") {
						$(".xxgz_edit_wapper .td_i_disabled").next("td").addClass("td_i_disabled").children().hide();
					}else if($(this).val() == "edit"){
						$(".xxgz_edit_wapper .td_i_disabled").next("td").removeClass("td_i_disabled").children().show();
					}
				});

				// 确定修改
				$(".xxgz_btn_qd").click(function(){
					alert("修改成功！");
					$(".iframe_btn_qx").trigger("click");
				});

			})

			window.onresize = function() {
				setMaxheight(0);
			}

		</script>
	</body>
</html>

