<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>审核流程</title>
	<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
	<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
	<style>
		body {
		    min-width: 534px;
		}
		.list_wapper_content {
		    height: 85%;
		}
		.list_wapper_content td.tx_right{
			padding-left:10px;
			text-align: left;
		}
	</style>
</head>
<body>
	<div class="list_wapper">
		<div class="list_wapper_header">
			<table class="list_table_header">
				<colgroup>
					<col width=10%></col>
					<col width=25%></col>
					<col width=31%></col>
					<col width=12%></col>
					<col width=12%></col>
				</colgroup>
				<tr>
					<td><div class="xuhao_header">序号</div></td>
					<td class="sort">
						<a href="javascript: void(0)">
							操作人
							<span class="card_order_jt" column="SHENBDH"></span>
						</a>
					</td>
					<td class="sort">
						<a href="javascript: void(0)">
							操作时间
							<span class="card_order_jt" column="CHUZFS"></span>
						</a>
					</td>
					<td class="sort">
						<a href="javascript: void(0)">
							操作
							<span class="card_order_jt" column="PIFDH"></span>
						</a>
					</td>
					<td class="sort">
						<a href="javascript: void(0)">
							意见
							<span class="card_order_jt" column="PIFJE"></span>
						</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="list_wapper_content">
			<table>
				<colgroup>
					<col width=10%></col>
					<col width=25%></col>
					<col width=31%></col>
					<col width=12%></col>
					<col width=12%></col>
				</colgroup>
				<#list wfCursor as obj>
					<tr <#if obj?index % 2 == 0>class="tr_color" </#if>>
						<td class="xuhao">${obj_index + 1}</td>
						<td class="tx_right">${obj["AUDITUSER"]}</td>
						<td>${obj["AUDITTIME"]}</td>
						<td>${obj["AUDITMEMO"]}</td>
						<td>${obj["AUDITRLT"]}</td>
					</tr>
				</#list>
			</table>
		</div>
	</div>
	<script src="${request.contextPath}/static/framework/ligerui-lib/jquery/jquery-1.9.0.min.js"></script>
	<script>
		$(function(){
			$(".list_wapper").height($(window).height());
			$(".list_wapper .list_wapper_content").height($(".list_wapper").height() - 38);
			if ($(".list_wapper_content").height() > $(".list_wapper_content table").height()) {
				$(".list_wapper_header").css("padding-right", "0");
			} else {
				$(".list_wapper_header").css("padding-right", "17px");
			}
		})
	</script>
</body>
</html>