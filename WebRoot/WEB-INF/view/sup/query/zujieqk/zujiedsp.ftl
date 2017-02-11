<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>租借待审批</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body class="card_body">
		<div class="container_box container_card">
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
									租借方式
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 10%" class="sort">
								<a href="javascript:void(0)">
									申请时间
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 11%" class="sort">
								<a href="javascript:void(0)">
									原值（元）
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 10%" class="sort">
								<a href="javascript:void(0)">
									累计折旧
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 10%" class="sort">
								<a href="javascript:void(0)">
									净值（元）
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 16%" class="sort">
								<a href="javascript:void(0)">
									预计租金收益（元）
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 10%">
								<a href="javascript:void(0)">
									单据状态
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
							<td style="width: 11%">出租</td>
							<td style="width: 10%"><a href="#">2016-12-01</a></td><!-- 穿透到处置单详情页 -->
							<td style="width: 11%">300000</td>
							<td style="width: 10%">150000</td>
							<td style="width: 10%">212121</td>
							<td style="width: 16%">121212</td>
							<td style="width: 10%" data-detail=""><a href="javascript:void(0)">审核中</a></td>
						</tr>
						<tr style="background-color: #fafafa">
							<td style="width: 4%;background:#f5f5f5" class="xuhao">1</td>
							<td style="width: 4%" class="list_td_label"><label class="list_label fl"><input class="chk" type="checkbox" /></label></td>
							<td style="width: 11%"><a href="javascript:void(0)" class="">CZ20160621</a></td>
							<td style="width: 11%">出租</td>
							<td style="width: 10%"><a href="#">2016-12-01</a></td><!-- 穿透到处置单详情页 -->
							<td style="width: 11%">300000</td>
							<td style="width: 10%">150000</td>
							<td style="width: 10%">212121</td>
							<td style="width: 16%">121212</td>
							<td style="width: 10%" data-detail=""><a href="javascript:void(0)">审核中</a></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="more_search">
			<div class="more_search_main">
				<table>
					<tr>
						<td class="more_search_item">申报单号：</td>
						<td><input type="text" name="" placeholder="可模糊查询申报单" /></td>
						<td class="more_search_item">租借方式：</td>
						<td>
							<select>
								<option value=""></option>
								<option value="">出租</option>
								<option value="">出借</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="more_search_item">申请时间：</td>
						<td class="search_datebox"><input id="dateBegin" name="dateBegin" type="text" value="" /></td>
						<td class="more_search_item" style="text-align: center">至</td>
						<td class="search_datebox"><input id="dateEnd" name="dateEnd" type="text" value="" /></td>
					</tr>
					<tr>
						<td class="more_search_item">净值：</td>
						<td><input type="text" name="" /></td>
						<td class="more_search_item" style="text-align: center">至</td>
						<td ><input type="text" name="" /></td>
					</tr>
				</table>
			</div>
			<div class="more_search_bottom">
				<div class="iframe_btn iframe_btn_qk">清空</div>
				<input type="submit" class="iframe_btn iframe_btn_qd" value="确定" />
				<div class="iframe_btn iframe_btn_qx">取消</div>
			</div>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
		<script>
			$(function(){
				// 更多搜索框生成日历
				$("#dateBegin").ligerDateEditor();
				$("#dateEnd").ligerDateEditor();
				$("#dateBegin,#dateEnd").attr("readonly",true);
			})
		</script>
	</body>
</html>