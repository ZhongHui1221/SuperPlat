<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="renderer" content="webkit">
		<title>存放地点管理</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/framework/zTree/css/zTreeStyle.css" />
		<style>
			body{overflow: hidden;position: relative;}
			.list_wapper_header{padding-right: 0px;}
			.list_wapper{height: 476px;}
			.list_wapper_content{height: 440px;}
			#menuContent{width: 374px;height: 300px;overflow-y: auto;border: 1px solid #ccc;background-color: #fff;z-index: 999;}
			#slide_tree{width: 364px;}
			.edit_modal_cover{position: fixed;width: 100%;height: 100%;display: none;}
			.edit_cunfang_t span{color: #ff3034;}
		</style>
	</head>

	<body>
		<div class="danwei_tree_l">
			<ul id="danwei_tree" class="ztree"></ul>
		</div>
		<div class="cunfang_r">
			<div class="cunfang_r_header">
				<div class="toobar_search fl">
					<input id="deptid" type="hidden" />
					<input id="storageid" type="hidden" />
					<input type="text" />
					<button class="toobar_search_btn" type="submit"><span></span></button>
				</div>
				<a class="cunfang_add" href="javascript:void(0)">新增<span></span></a>
			</div>
			<div class="cunfang_r_list">
				<div class="list_wapper">
					<div class="list_wapper_header">
						<table class="list_table_header">
							<colgroup>
								<col width=8%></col>
								<col width=25%></col>
								<col width=20%></col>
								<col width=15%></col>
								<col width=8%></col>
								<col width=8%></col>
								<col width=8%></col>
								<col width=8%></col>
							</colgroup>
							<tr>
								<td><div class="xuhao_header">序号</div></td>
								<td>存放地点</td>
								<td>所属部门</td>
								<td>备注信息</td>
								<td colspan="4">操作</td>
							</tr>
						</table>
					</div>
					<div class="list_wapper_content">
						<table>
							<colgroup>
								<col width=8%></col>
								<col width=25%></col>
								<col width=20%></col>
								<col width=15%></col>
								<col width=8%></col>
								<col width=8%></col>
								<col width=8%></col>
								<col width=8%></col>
							</colgroup>
							<tbody id="tb"></tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="edit_modal edit_cunfang">
			<div class="edit_modal_header">
				<div class="edit_modal_info">编辑存放地点</div>
				<div class="edit_modal_icon"></div>
				<div class="edit_modal_close"></div>
			</div>
			<div class="edit_modal_content">
				<input id="cfddid" type="hidden" />
				<table>
					<tr>
						<td class="edit_cunfang_t"><span>*</span>存放地点：</td>
						<td class="edit_cunfang_dd"><input id="cfdd" type="text" /></td>
					</tr>
					<tr>
						<td class="edit_cunfang_t"><span>*</span>部门信息：</td>
						<td class="edit_cunfang_bm">
							<input id="bmData" type="text" readonly onclick="showMenu()" />
							<input id="depts" type="hidden" />
						</td>
					</tr>
					<tr>
						<td class="edit_cunfang_t">&nbsp;备注信息：</td>
						<td class="edit_cunfang_bz"><input id="bz" type="text" /></td>
					</tr>
				</table>
			</div>
			<div class="edit_modal_bottom">
				<input class="iframe_btn edit_btn_qd" type="button" value="确定">
				<div class="iframe_btn edit_btn_qx">取消</div>
			</div>
		</div>
		<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
			<ul id="slide_tree" class="ztree"></ul>
		</div>
		<div class="edit_modal_cover"></div>
		<script src="${request.contextPath}/static/framework/ligerui-lib/jquery/jquery-1.9.0.min.js"></script>
		<script src="${request.contextPath}/static/framework/zTree/js/jquery.ztree.core.min.js"></script>
		<script src="${request.contextPath}/static/framework/zTree/js/jquery.ztree.excheck.min.js"></script>
		<script src="${request.contextPath}/static/framework/layer/layer.js"></script>
		<script>

			// 存放地点左侧单位树配置
			var setting = {
				data: {
					simpleData: {
						enable: true
					}
				},
				view: {
					showIcon: false
				},
				callback: {
					onClick: switchDept
				}
			};

			// 存放地点下拉树
			var setting_bm = {
				check: {
					enable: true,
					chkboxType: { "Y" : "", "N" : "" }
				},
				view: {
					showIcon: false
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
					onCheck: onCheck
				}
			};

			// 数据格式
			var zNodes = ${deptTree};

			/* 下拉复选框相关 - BEGIN */
			function showMenu() {
				var cityObj = $("#bmData");
				var cityOffset = $("#bmData").offset();
				$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown(100).show();

				$("body").bind("mousedown", onBodyDown);
			}

			function onCheck(e, treeId, treeNode) {
				var zTree = $.fn.zTree.getZTreeObj("slide_tree");
				var nodes = zTree.getCheckedNodes(true);
				var namesArr = new Array();
				var idsArr = new Array();
				for (var i = 0; i < nodes.length; i++) {
					namesArr.push(nodes[i].name);
					idsArr.push(nodes[i].id);
				}
				$("#bmData").val(namesArr);
				$("#depts").val(idsArr);
			}

			function onBodyDown(event) {
				if (!(event.target.id == "menuBtn" || event.target.id == "citySel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
					hideMenu();
				}
			}

			function hideMenu() {
				$("#menuContent").hide();
				$("body").unbind("mousedown", onBodyDown);
			}
			/* 下拉复选框相关 - END */

			// 生成表格
			function createTable(data) {
				$("#tb").empty();
				var arr = eval(data);
				var htmlStr = '';
				for (var i = 0; i < arr.length; i++) {
					var objname = arr[i].OBJNAME != undefined ? arr[i].OBJNAME : "";
					var deptnames = arr[i].DEPTNAMES != undefined ? arr[i].DEPTNAMES : "";
					var beiz = arr[i].BEIZ != undefined ? arr[i].BEIZ : "";
					// 隔行变色
					if (i % 2 == 0) {
						htmlStr += '<tr>';
					} else {
						htmlStr += '<tr class="tr_color">';
					}
					htmlStr += '<td class="xuhao">' + (i + 1) + '</td>';
					htmlStr += '<td>' + objname + '</td>';
					htmlStr += '<td>' + deptnames + '</td>';
					htmlStr += '<td>' + beiz + '</td>';
					htmlStr += '<td><a class="cunfang_edit" href="javascript: void(0)" rwid="' + arr[i].RWID + '" depts="' + arr[i].DEPTIDS + '">修改</a></td>';
					htmlStr += '<td><a class="cunfang_delete" href="javascript: void(0)" rwid="' + arr[i].RWID + '">删除</a></td>';
					htmlStr += '<td><a class="cunfang_up" href="javascript: void(0)"></a></td>';
					htmlStr += '<td><a class="cunfang_down" href="javascript: void(0)"></a></td>';
					htmlStr += '</tr>';
				}
				$("#tb").append(htmlStr);
			}

			// 切换部门
			function switchDept(event, treeid, treeNode) {
				$("#deptid").val(treeNode.id);
				$.get(
					"${request.contextPath}/Storage/findStorages",
					{"deptid": treeNode.id},
					function(data) {
						// 生成表格
						createTable(data);
						checkScrollbar();
					}
				);

			}

			// 查询某部门的存放地点
			function findStorages() {
				var deptid = $("#deptid").val();
				$.get(
					"${request.contextPath}/Storage/findStorages",
					{"deptid": deptid},
					function(data) {
						// 生成表格
						createTable(data);
						checkScrollbar();
					}
				);
			}

			// 查询所有存放地点
			function findAllStorages() {
				$.get(
					"${request.contextPath}/Storage/findStorages",
					function(data) {
						// 生成表格
						createTable(data);
						checkScrollbar();
					}
				);
			}

			// 判断滚动条
			function checkScrollbar(){
				if($(".list_wapper_content table").height() > 440) {
					$(".list_wapper_header").css("padding-right", "17px");
				}else{
					$(".list_wapper_header").css("padding-right", "0px");
				}
			}

			$(function() {

				// 加载所有存放地点
				findAllStorages();

				// 生成单位树
				$.fn.zTree.init($("#danwei_tree"), setting, zNodes);
				$.fn.zTree.init($("#slide_tree"), setting_bm, zNodes);
				var $slide_tree = $.fn.zTree.getZTreeObj("slide_tree");

				// 点击新增按钮弹出编辑框
				$(".cunfang_add").click(function() {
					// 重置文本框及隐藏域
					$("input[type='text'], input[type='hidden']").val("");
					$slide_tree.checkAllNodes(false);
					$(".edit_modal, .edit_modal_cover").show();
				});

				// 点击修改出现弹出框
				$("body").on("click",".cunfang_edit", function() {
					$("#cfddid").val($(this).attr("rwid"));
					$("#depts").val($(this).attr("depts"));
					$(".edit_cunfang_dd input").val($(this).parents("tr").children("td").eq(1).html());
					$("#bmData").val($(this).parents("tr").children("td").eq(2).html());
					$(".edit_cunfang_bz input").val($(this).parents("tr").children("td").eq(3).html());
					$(".edit_modal, .edit_modal_cover").show();
				});

				// 点击删除弹出提示框
				$("body").on("click",".cunfang_delete", function() {
					var storageid = $(this).attr("rwid");
					//$("#storageid").val(rwid);
					var cfdd = $(this).parents("tr").children("td").eq(1).html();
					if (cfdd.length > 6) {
						cfdd = cfdd.slice(0,6) + "...";
					}
					layer.confirm(
						"确定要删除地点[" + cfdd + "]吗？",
						{icon : 3, title : "提示", shade : 0},
						function() {
							layer.closeAll();
							var loadid = layer.load(2);
							$.post(
								"${request.contextPath}/Storage/removeStorages",
								{"_method": "DELETE", "storageid": storageid},
								function(data) {
									layer.close(loadid);
									if (data == "SUCCESS") {
										findStorages();
										layer.msg(data, {icon : 1});
									} else {
										layer.msg(data, {icon : 0, anim : 6});
									}
								}
							);
						}
					)
				});

				// 隐藏编辑框
				$(".edit_btn_qx, .edit_modal_close").click(function() {
					$(".edit_modal, .edit_modal_cover").hide();
				});

				$(".edit_btn_qd").click(function() {
					// 参数收集
					var cfddid = $("#cfddid").val();
					var cfdd = $("#cfdd").val();
					var depts = $("#depts").val();
					var bz = $("#bz").val();

					// 添加
					if (cfddid == "") {
						$.post(
							"${request.contextPath}/Storage/add",
							{"objname": cfdd, "suosbmid": depts, "beiz": bz},
							function(data) {
								if (data == "SUCCESS") {
									findStorages();
									layer.msg(data, {icon : 1});
								} else {
									layer.msg(data, {icon : 0, anim : 6});
								}
							}
						);
					}
					// 修改
					else {
						$.post(
							"${request.contextPath}/Storage/modify",
							{"_method": "PUT", "cunfddid": cfddid, "objname": cfdd, "suosbmid": depts, "beiz": bz},
							function(data) {
								if (data == "SUCCESS") {
									findStorages();
									layer.msg(data, {icon : 1});
								} else {
									layer.msg(data, {icon : 0, anim : 6});
								}
							}
						);
					}
					$(".edit_modal, .edit_modal_cover").hide();
				});

				// 筛选
				$(".toobar_search input[type='text']").keyup(function() {
					var str = $(this).val();
					$(".list_wapper_content table tr").each(function(key, val){
						if($(val).children("td").eq(1).html().match(str) == null && $(val).children("td").eq(2).html().match(str) == null && $(val).children("td").eq(3).html().match(str) == null){
							$(val).hide();
						}else{
							$(val).show();
						}
					})
				});

				// 双击选取地点
				$(".list_wapper_content").on("dblclick", "tr", function() {
					// 如果卡片详情页未弹出则双击无效
					if ($('#card_iframe_modal', window.parent.document).css("display") == "none") {
						return false;
					}else{
						var storageid = $(this).find(".cunfang_edit").attr("rwid");
						var cfdd = $(this).children("td").eq("1").html();
						window.parent.setCardStorage(cfdd, storageid);
					}
				});

			});

		</script>
	</body>
</html>