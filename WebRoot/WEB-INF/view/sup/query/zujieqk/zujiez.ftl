<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>租借中</title>
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
				<div class="list_wapper_header" style="background:#ebf1f7;">
					<table class="list_table_header">
						<tr>
							<td style="width: 11%"></td>
							<td style="width: 9%" class="sort">
								<a href="javascript:void(0)">
									资产名称
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 11%" class="sort">
								<a href="javascript:void(0)">
									规格型号
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 10%" class="sort">
								<a href="javascript:void(0)">
									租借方式
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 14%" class="sort">
								<a href="javascript:void(0)">
									出租（借）数量
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 13%" class="sort">
								<a href="javascript:void(0)">
									租（借）期限
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 13%" class="sort">
								<a href="javascript:void(0)">
									承租（借）方
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
							<td style="width: 17%" class="sort">
								<a href="javascript:void(0)">
									累计取得收益（元）
									<span class="card_order_jt" column=""></span>
								</a>
							</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<colgroup>
					        <col width=11%></col>
					        <col width=9%></col>
					        <col width=11%></col>
					        <col width=10%></col>
					        <col width=14%></col>
					        <col width=13%></col>
					        <col width=13%></col>
					        <col width=17%></col>
					    </colgroup>
						<tr class="list_infolist">
							<td colspan="8">
								<ul>
									<li>1</li>
									<li class="list_td_label"><label class="list_label fl"><input class="chk" type="checkbox" /></label></li>
									<li>购置日期：2016-09-02</li>
									<li>资产编号：FW321321321321</li>
									<li>申报单号：CZ21212122</li>
									<li>批复日期：2016-09-02</li>
								</ul>
							</td>
						</tr>
						<tr class="list_imglist">
							<td class="list_img_item">
								<div class="list_img_wapper">
									<div class="list_img_content"><img src="http://www.poluoluo.com/qq/UploadFiles_7828/201611/2016110420035598.jpg" /></div>
								</div>
							</td>
							<td><a href="javascript:void(0)">公路交通房</a></td>
							<td>CZ43253</td>
							<td>出租</td>
							<td>200平方米</td>
							<td>2016-08-04至2016-06-10</td>
							<td>1212<i><a href="javascript:void(0)">查看合同</a></i></td>
							<td>0<i><a href="javascript:void(0)">登记收益</a></i></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="more_search">
			<div class="more_search_main">
				<table>
					<tr>
						<td class="more_search_item">资产名称：</td>
						<td><input type="text" name="" placeholder="可模糊查询资产名称" /></td>
						<td class="more_search_item">规格型号：</td>
						<td><input type="text" name="" /></td>
					</tr>
					<tr>
						<td class="more_search_item">租借方式：</td>
						<td>
							<select>
								<option value=""></option>
								<option value="">出租</option>
								<option value="">出借</option>
							</select>
						</td>
						<td class="more_search_item">租借数量：</td>
						<td><input type="text" name="" /></td>
					</tr>
					<tr>
						<td class="more_search_item">取得收益：</td>
						<td><input type="text" name="" /></td>
						<td class="more_search_item" style="text-align: center">至</td>
						<td ><input type="text" name=""></td>
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
	</body>
</html>