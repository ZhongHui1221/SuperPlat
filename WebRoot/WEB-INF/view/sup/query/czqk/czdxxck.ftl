<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>处置单信息查看</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body class="card_body">
		<div class="container_box container_card">
			<div style="height: 2%"></div>
			<div class="bread_menu_wapper ">
				<div class="fl bread_menu bread_menu_pd">
					<span>当前位置：</span>
					<a href="">处置情况</a> <i class="lead_to">&nbsp;>&nbsp;</i>
					<a href="">6月份申报单信息查看</a> <i class="lead_to">&nbsp;>&nbsp;</i>
					<a class="bread_menu_last">处置单信息查看</a>
				</div>
			</div>
			<div class="toolbar_wapper">
				<#-- 导入工具栏模板 -->
				<#include "/base/toolbar_box.ftl" />
			</div>
			<div class="list_wapper">
				<div class="list_wapper_header">
					<table class="list_table_header">
						<tr>
							<td style="width: 5%"><div class="xuhao_header">序号</div></td>
							<td style="width: 5%"></td>
							<td style="width: 16%" class="sort">
								<a href="javascript:void(0)">
									资产名称和规格
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 13%" class="sort">
								<a href="javascript:void(0)">
									单价
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 12%" class="sort">
								<a href="javascript:void(0)">
									数量
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 13%" class="sort">
								<a href="javascript:void(0)">
									价值
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 12%" class="sort">
								<a href="javascript:void(0)">
									处置方式
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 12%" class="sort">
								<a href="javascript:void(0)">
									处置原因
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 12%" class="sort">
								<a href="javascript:void(0)">
									审批状态
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<tr>
							<td style="width: 5%;background:#fafafa" class="xuhao">1</td>
							<td style="width: 5%" class="list_td_label"><label class="list_label fl"><input class="chk" type="checkbox" /></label></td>
							<td style="width: 16%"><a href="javascript:void(0)" class="item_card_info_list">台式机</a></td>
							<td style="width: 13%">1065</td>
							<td style="width: 12%">1</td>
							<td style="width: 13%">1065</td>
							<td style="width: 12%">报废</td>
							<td style="width: 12%"></td>
							<td style="width: 12%">同意</td>
						</tr>
						<tr style="background-color: #fafafa">
							<td style="width: 5%;background:#f5f5f5" class="xuhao">1</td>
							<td style="width: 5%" class="list_td_label"><label class="list_label fl"><input class="chk" type="checkbox" /></label></td>
							<td style="width: 16%"><a href="javascript:void(0)" class="item_card_info_list">台式机</a></td>
							<td style="width: 13%">1065</td>
							<td style="width: 12%">1</td>
							<td style="width: 13%">1065</td>
							<td style="width: 12%">报废</td>
							<td style="width: 12%"></td>
							<td style="width: 12%">同意</td>
						</tr>
					</table>
				</div>
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
			$(function(){
				setMaxheight(70);
			})
			window.onresize = function() {
				setMaxheight(70);
			}
		</script>
	</body>
</html>