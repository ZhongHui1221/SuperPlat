<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>申报单信息查看</title>
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
					<a class="bread_menu_last">6月份申报单信息查看</a>
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
							<td style="width: 4%"><div class="xuhao_header">序号</div></td>
							<td style="width: 4%"></td>
							<td style="width: 11%" class="sort">
								<a href="javascript:void(0)">
									申报单号
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 11%" class="sort">
								<a href="javascript:void(0)">
									批复时间
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 10%" class="sort">
								<a href="javascript:void(0)">
									处置方式
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 11%" class="sort">
								<a href="javascript:void(0)">
									批复单号
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 10%" class="sort">
								<a href="javascript:void(0)">
									批复状态
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 10%" class="sort">
								<a href="javascript:void(0)">
									批复数量
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 10%" class="sort">
								<a href="javascript:void(0)">
									批复金额
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 16%">
								<a href="javascript:void(0)">
									单位名称
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<tr>
							<td style="width: 4%;background:#fafafa" class="xuhao">1</td>
							<td style="width: 4%" class="list_td_label"><label class="list_label fl"><input class="chk" type="checkbox" /></label></td>
							<td style="width: 11%"><a href="javascript:void(0)" class="">CZ20160621</a></td>
							<td style="width: 11%">2016-12-01</td>
							<td style="width: 10%">出售</td>
							<td style="width: 11%">PFC2016138</td>
							<td style="width: 10%">同意</td>
							<td style="width: 10%">2</td>
							<td style="width: 10%">121212</td>
							<td style="width: 16%">上海市人力资源中心</td>
						</tr>
						<tr style="background-color: #fafafa">
							<td style="width: 4%;background:#f5f5f5" class="xuhao">1</td>
							<td style="width: 4%" class="list_td_label"><label class="list_label fl"><input class="chk" type="checkbox" /></label></td>
							<td style="width: 11%"><a href="javascript:void(0)" class="">CZ20160621</a></td>
							<td style="width: 11%">2016-12-01</td>
							<td style="width: 10%">出售</td>
							<td style="width: 11%">PFC2016138</td>
							<td style="width: 10%">同意</td>
							<td style="width: 10%">2</td>
							<td style="width: 10%">121212</td>
							<td style="width: 16%">上海市人力资源中心</td>
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