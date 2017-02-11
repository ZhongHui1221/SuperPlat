<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>审核通过用户</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
	</head>

	<body>
		<div class="container_card">
			<div class="main_tabs">
				<div class="container">
					<ul class="main_tabs_list">
						<li><a href="dwzcgly_userAuditing.html">待审核</a><span class="sanjx_jt"></span></li>
						<li><a class="active" href="javascript:void(0)">审核通过</a><span class="sanjx_jt active"></span></li>
					</ul>
				</div>
			</div>
			<div class="list_wapper container">
				<div class="list_wapper_header">
					<table class="list_table_header">
						<colgroup>
							<col width=3%></col>
							<col width=3%></col>
							<col width=10%></col>
							<col width=10%></col>
							<col width=15%></col>
							<col width=14%></col>
							<col width=10%></col>
							<col width=10%></col>
							<col width=10%></col>
							<col width=15%></col>
						</colgroup>
						<tr>
							<td><div class="xuhao_header">序号</div></td>
							<td></td>
							<td class="sort">
								<a href="javascript: void(0)">
									用户名
									<span class="card_order_jt" column="SHENBDH"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									姓名
									<span class="card_order_jt" column="CHUZFS"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									手机号
									<span class="card_order_jt" column="PIFDH"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									隶属部门
									<span class="card_order_jt" column="PIFJE"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									职责
									<span class="card_order_jt" column="PIFSL"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									职级
									<span class="card_order_jt" column="XUANZSL"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									是否在编
									<span class="card_order_jt" column="XUANZJE"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									审核时间
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
							<col width=10%></col>
							<col width=10%></col>
							<col width=15%></col>
							<col width=14%></col>
							<col width=10%></col>
							<col width=10%></col>
							<col width=10%></col>
							<col width=15%></col>
						</colgroup>
						<tr >
							<td class="xuhao">1</td>
							<td class="list_td_label">
								<label class="list_label fl"><input class="chk" type="checkbox" /></label>
							</td>
							<td><a href="javascript: void(0)">ZS</a></td>
							<td>张三</td>
							<td>12345678909</td>
							<td>1支队</td>
							<td>使用人</td>
							<td>办事员</td>
							<td>否</td>
							<td>2016-09-20&nbsp;&nbsp;13:31</td>
						</tr>
					</table>
				</div>
			</div>
			</div>
		</div>

		<script src="${request.contextPath}/static/js/jquery-1.9.0.min.js"></script>
		<script src="${request.contextPath}/static/js/iframe_org.js"></script>
		<script>
			$(function(){
				setMaxheight(0);
			})
			window.onresize = function(){
				setMaxheight(0);
			}
		</script>
	</body>
</html>