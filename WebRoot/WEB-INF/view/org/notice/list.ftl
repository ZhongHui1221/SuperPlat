<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
		<title>公告管理 - 公告列表</title>
		<style>
			.list_wapper{height: 426px;}
			.list_wapper_content{height: 402px;}
			.container_card{min-height: 0px;}
		</style>
	</head>

	<body class="container_card">
		<div class="gggl_header">
			<ul class="gggl_tabs">
				<li class="gggl_lb select"><a>公告列表<span></span></a></li>
				<li class="gggl_xx"><a href="${request.contextPath}/Notice/toAdd">发布消息<span></span></a></li>
			</ul>
		</div>
		<div class="gggl_delete_wapper"><a class="gggl_delete" href="javascript:void(0)">删除<span></span></a></div>
		<div class="list_wapper container_panel">
			<div class="list_wapper_header">
				<table class="list_table_header">
					<colgroup>
						<col width=5%></col>
						<col width=5%></col>
						<col width=20%></col>
						<col width=12%></col>
						<col width=12%></col>
						<col width=12%></col>
						<col width=12%></col>
						<col width=12%></col>
					</colgroup>
					<tr>
						<td><div class="xuhao_header">序号</div></td>
						<td></td>
						<td class="sort">
							<a href="javascript: void(0)">
								标题
								<span class="card_order_jt" column="SHENBDH"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								发布者
								<span class="card_order_jt" column="CHUZFS"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								发布时间
								<span class="card_order_jt" column="PIFDH"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								失效时间
								<span class="card_order_jt" column="PIFJE"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								状态
								<span class="card_order_jt" column="PIFSL"></span>
							</a>
						</td>
						<td class="sort">
							<a href="javascript: void(0)">
								操作
								<span class="card_order_jt" column="XUANZSL"></span>
							</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="list_wapper_content">
				<table>
					<colgroup>
						<col width=5%></col>
						<col width=5%></col>
						<col width=20%></col>
						<col width=12%></col>
						<col width=12%></col>
						<col width=12%></col>
						<col width=12%></col>
						<col width=6%></col>
						<col width=6%></col>
					</colgroup>
					<tbody id="tb"></tbody>
				</table>
			</div>
		</div>

		<script src="${request.contextPath}/static/js/jquery-1.9.0.min.js"></script>
		<script src="${request.contextPath}/static/framework/layer/layer.js"></script>
		<script>

			$(function() {

				// 加载所有公告
				findNoticesForMng();

				// 点击公告栏条目弹出公告栏模态框
				$("#tb").on("click", ".gonggao_view", function() {
					var rwid = $(this).parents("tr").attr("rwid");
					window.parent.layer.open({
						type: 2,
						skin: "content_class",
						title: "公告信息",
						area: ["800px", "560px"],
						anim: 4,
						shadeClose: true,
						fixed: false,
						content: "${request.contextPath}/Notice/noticeDetail/" + rwid
					});
				});

				// 点击删除弹出提示框
				$("#tb").on("click",".gonggao_delete", function() {
					var rwid = $(this).parents("tr").attr("rwid");
					var noticeTitle = $(this).parents("tr").children("td").eq(2).text();
					if (noticeTitle.length > 6) {
						noticeTitle = noticeTitle.slice(0,6) + "...";
					}
					layer.confirm(
						"确定要删除公告[" + noticeTitle + "]吗？",
						{icon : 3, title : "提示", shade : 0},
						function() {
							layer.closeAll();
							var loadid = layer.load(2);
							$.post(
								"${request.contextPath}/Notice/removeNotices",
								{"_method": "DELETE", "rwid": rwid},
								function(data) {
									layer.close(loadid);
									if (data == "SUCCESS") {
										findNoticesForMng()
										layer.msg(data, {icon : 1});
									} else {
										layer.msg(data, {icon : 0, anim : 6});
									}
								}
							);
						}
					)
				});

				$(document).on("click", ".list_label", function() {
					var $input = $(this).children("input");
					if ($input.prop("checked")) {
						$input.prop("checked", false);
						$(this).removeClass("active");
					} else {
						$input.prop("checked", true);
						$(this).addClass("active");
					}
					return false;
				});

				// 删除操作
				$(".gggl_delete").click(function() {
					var idArr = new Array();
					var count = 0;
					$("input[class='chk']:checked").each(function() {
						idArr[count] = $(this).val();
						count++;
					});

					if (count == 0) {
						layer.alert("请选择卡片", {icon : 7, title : "提示"});
						return false;
					}

					layer.confirm(
						"是否要删除选中公告信息？",
						{icon : 3, title : "提示"},
						function() {
							var loadid = layer.load(2);
							$.post(
								//"${request.contextPath}/orgHome/applyForInvest",
								//{"_method": "PUT", "checkedIdStr": idArr.join()},
								function(data) {
									layer.close(loadid);
									if (data == "SUCCESS") {
										findNoticesForMng();
									} else {
										layer.msg(data, {icon : 0, anim : 6});
									}
								}
							);
						}
					);
				});
			});

			// 生成表格
			function createTable(data) {
				$("#tb").empty();
				var arr = eval(data);
				var htmlStr = '';
				for (var i = 0; i < arr.length; i++) {
					// 隔行变色
					if (i % 2 == 0) {
						htmlStr += '<tr rwid="' + arr[i].id + '">';
					} else {
						htmlStr += '<tr class="tr_color" rwid="' + arr[i].id + '">';
					}
					htmlStr += '<td class="xuhao">' + (i + 1) + '</td>';
					htmlStr += '<td class="list_td_label"><label class="list_label"><input class="chk" type="checkbox"/></label></td>';
					htmlStr += '<td>' + arr[i].title+ '</td>';
					htmlStr += '<td>' + arr[i].author + '</td>';
					htmlStr += '<td>' + arr[i].createDate + '</td>';
					htmlStr += '<td>' + arr[i].expiryDate + '</td>';
					htmlStr += '<td>???</td>';
					htmlStr += '<td><a class="gonggao_view" href="javascript: void(0)">查看</a></td>';
					htmlStr += '<td><a class="gonggao_delete" href="javascript: void(0)">删除</a></td>';
					htmlStr += '</tr>';
				}
				$("#tb").append(htmlStr);
			}

			// 查询所有公告
			function findNoticesForMng() {
				$.get(
					"${request.contextPath}/Notice/findNoticesForMng",
					function(data) {
						// 生成表格
						createTable(data);
					}
				);
			}

		</script>
	</body>
</html>