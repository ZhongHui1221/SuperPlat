<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/framework/zTree/css/zTreeStyle.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/framework/uploadify/uploadify.css" />
		<title>公告管理 - 发布消息</title>
		<style>
			body{position: relative;}
			.gggl_header{margin-bottom: 0px;}
			.ztree{padding: 0px;}
			.uploadify-queue-item{padding: 4px 10px;}
			.gggl_lb a span{background-position: 58px 0px;}
			.gggl_tabs .gggl_xx a span{background-position: 92px 0px;}
			#file_upload-button{background: transparent;border: none;color: #277fd0;text-shadow: none;font-weight: normal;width: 160px!important;background-image: url(${request.contextPath}/static/image/fujianicon.png);background-repeat: no-repeat;background-position: 6px 3px;}
			#file_upload{background: #e5f2fd;}
			.uploadify-button-text{font-family: "Microsoft YaHei";}
		</style>
	</head>

	<body>
		<div class="gggl_header">
			<ul class="gggl_tabs">
				<li class="gggl_lb"><a href="${request.contextPath}/Notice/list">公告列表<span></span></a></li>
				<li class="gggl_xx select"><a>发布消息<span></span></a></li>
			</ul>
		</div>
		<form action="${request.contextPath}/Notice/upload" method="post">
			<div class="gggl_wapper">
				<div class="gonggao_edit">
					<div class="gonggao_title">
						<textarea id="title" placeholder="公告标题"></textarea>
					</div>
					<div class="gonggao_detail">
						<textarea id="msg" placeholder="正文"></textarea>
					</div>
					<div class="gonggao_filelist">
						<input id="file_upload" type="file" />
						<div id="fileQueue"></div>
					</div>
					<div class="gonggao_lastdate">
						<div class="gonggao_ld_f">公告失效日期：</div>
						<input id="jiezrq" type="text" />
						<div class="gonggao_ld_l">该公告到期将失效</div>
					</div>
				</div>
				<div class="gonggao_people">
					<div class="gonggao_p_title">接收人员：</div>
					<div class="gonggao_select">
						<div class="gonggao_tree_wapper">
							<div class="zTreeDemoBackground left">
								<ul id="danwei_tree" class="ztree"></ul>
							</div>
						</div>
						<div class="gonggo_people">
							<ul></ul>
						</div>
					</div>
				</div>
			</div>
			<div class="gggl_bottom">
				<div class="iframe_btn gggl_btn_qx">取消</div>
				<input class="iframe_btn gggl_btn_qd" type="button" value="发布" onclick="add()" />
			</div>
		</form>

		<script src="${request.contextPath}/static/framework/ligerui-lib/jquery/jquery-1.9.0.min.js"></script>
		<script src="${request.contextPath}/static/framework/zTree/js/jquery.ztree.core.min.js"></script>
		<script src="${request.contextPath}/static/framework/zTree/js/jquery.ztree.excheck.min.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
		<script src="${request.contextPath}/static/framework/uploadify/jquery.uploadify.min.js"></script>
		<script>
			// 接收人员单位树配置(ztree插件)
			var setting = {
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
					onCheck: showMember
				}
			};

			// 单位树数据
			var zNodes = ${deptTree};
			console.log('zNodes');
			// 生成单位树
			$.fn.zTree.init($("#danwei_tree"), setting, zNodes);
			// 获取单位树对象
			var $danwei_tree = $.fn.zTree.getZTreeObj("danwei_tree");

			$(function() {
				console.log(zNodes);

				// 文件序号
				var fileindex = 0;

				$("#file_upload").uploadify({
					'debug': false,
					'auto': false,
					'swf': '${request.contextPath}/static/framework/uploadify/uploadify.swf',
					'uploader': '${request.contextPath}/Notice/upload',
					'queueID': 'fileQueue',
					'queueSizeLimit': 5,
					'fileTypeExts': '*.doc; *.docx; *.ppt; *.pptx; *.xls; *.xlsx',
					'multi': true,
					'buttonText': '添加附件',
					'width': '470',
					'fileSizeLimit': '20MB',
					'method': 'post',
					'removeCompleted': false,
					'onUploadStart': function(file) {
						// 动态传递 fileindex
						$('#file_upload').uploadify('settings', 'formData', {'fileindex': ++fileindex});
					},
					'onQueueComplete' : function(queueData) {
						// 队列上传完成后，重置 fileindex
						fileindex = 0;
					}
				});

				// 生成日历
				$("#jiezrq").ligerDateEditor();

				// 取消按钮点击关闭弹出框
				$(".gggl_btn_qx").click(function() {
					window.parent.closeModal(".notice_module");
				});

				// 发布
				$(".gggl_btn_qd").click(function() {
					// 公告提交代码...
					alert("发布成功！");
					window.parent.closeModal(".notice_module");
				});
			});

			function showMember(event, treeid, treeNode) {
				$(".gonggo_people ul").empty();
				var members = $danwei_tree.getCheckedNodes(true);
				for (var i = 0; i < members.length; i++) {
					if (members[i].member) {
						for (var j = 0; j < members[i].member.length; j++) {
							var li = $("<li>");
							li.html("<input type='checkbox' name='' value='" + members[i].member[j].id + "' checked><span>" + members[i].member[j].name + "</span>");
							li.appendTo($(".gonggo_people ul"));
						}
					} else {
						return;
					}
				}
			}

			function add() {
				// 参数收集
				var title = $("#title").val();
				var msg = $("#msg").val();
				var jiezrq = $("#jiezrq").val();
				$.post(
					"${request.contextPath}/Notice/add",
					{"title": title, "msg": msg, "jiezrq": jiezrq},
					function(data) {
						if (data == "SUCCESS") {
							$("#file_upload").uploadify("upload", "*");
						} else {
							alert(data);
						}
					}
				);
			}
		</script>
	</body>
</html>