<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>卡片详情</title>
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<style>
			html{height: 100%;}
			body{font-family: "微软雅黑";font-size: 13px;color: #333;height: 100%;}
			.card_img{float: left;width: 182px;height: 180px;}
			.card_bigimg{height: 130px;border:1px solid #ccc;}
			.card_imglist li{float: left;width: 39px;height: 39px;margin: 5px 6px 5px 0;border:1px solid #ccc;}
			.card_maininfo{float: left;padding-left: 30px; font-size: 13px;}
			.card_maininfo li{height: 30px;line-height: 24px;position: relative;}
			.card_maininfo li input{border:1px solid #ddd;outline: none;height: 22px;line-height: 22px;text-indent: 5px;transition: 0.3s;}
			.detail_card_header{overflow: hidden;padding: 8px 0px 3px 8px;}
			.detail_card_tab{height: 34px;clear: both;border-top:1px solid #ccc;background:#d7e9fe;position: relative;}
			.baseinfo_edit{width: 50px;height: 22px;line-height: 22px;text-align: center;border:1px solid #ddd;background:#2f88f3;color: #fff;position: absolute;right: 10px;top: 5px;border-radius: 4px;cursor: pointer;}
			.detail_card_tab ul{padding-left: 10px;}
			.detail_card_tab li{float: left;width: 80px;height: 30px;line-height: 30px;margin-top: 4px;font-size: 14px;text-align: center;cursor: pointer;border-top-left-radius: 4px;border-top-right-radius: 4px;transition: 0.2s;margin-right: 2px;}
			.card_info_list{height: 340px;overflow-y: auto;}
			.card_tab_selsect{background:#fff;}
			.card_tab_hover{background:#EBF4FF;}
			.detail_card_info{font-size: 13px;}
			.detail_card_info td{width: 114px;height: 34px;line-height: 34px;}
			.detail_card_info td input{width: 112px;height: 22px;line-height: 22px;border:1px solid #ccc;text-indent: 5px;transition: 0.3s;}
			.detail_card_info .text-idt{text-indent: 16px;width: 136px;position: relative;}
			.detail_card_info{margin-top: 20px;padding-bottom: 10px;border-bottom: 1px solid #ccc;}
			.detail_card_info table{table-layout: fixed;}
			.detail_card_info select{width: 114px;height: 24px;background-color: #fff;border:1px solid #ccc;font-family: "微软雅黑";transition: 0.3s;}
			.detail_card_info textarea{width: 362px;background:#fff;border:1px solid #ccc;color:#999;margin-top:5px;transition: 0.3s;}
			.card_imglist li img{width: 100%;height: 100%;line-height: 40px;}
			.card_bigimg img{width: 100%;height: 100%;}
			.text-idt span{color: red;position: absolute;left: -6px;top: 0px;}
			input[disabled],input:disabled{background:#fff;color: #999;}
			.weixiu_header,.rizhi_header,.fushu_header,.zhejiu_header{padding-top: 2px;}
			.weixiu_header table{width: 100%;text-align: center;}
			.weixiu_header table td{border:1px solid #ccc;height: 26px;line-height: 26px;}
			.rizhi_header table{width: 100%;text-align: center;}
			.rizhi_header table td{border:1px solid #ccc;height: 26px;line-height: 26px;}
			.card_info_zhejiu table,.card_info_fushu table{width: 100%;text-align: center;}
			.card_info_zhejiu table td{width: 7.6%;border:1px solid #ccc;height: 26px;line-height: 26px;}
			.card_info_fushu table td{border:1px solid #ccc;height: 26px;line-height: 26px;}
			.card_info_item{display: none;}
			.bg_list{background:#fafafa}
			.detail_card_info .colspan_width input{width:362px;}
			.louceng_cont{height: 306px;border-top:1px solid #ccc;border-bottom: 1px solid #ccc;}
			.louceng_cont_bg{height: 406px}
			.louceng_tree{float: left;width: 25%;height: 100%;}
			.louceng_tree_inner{height: 100%;border-right: 1px solid #ccc;overflow-x: hidden;}
			.loucent_table{float: left;width: 75%;}
			.louceng_bottom{height: 32px;line-height: 32px;padding-left: 8px;}
			.loucent_table table{width: 100%;text-align: center;table-layout: fixed;}
			.loucent_table table td{border:1px solid #ccc;height: 26px;line-height: 26px;overflow: hidden;white-space: nowrap;text-overflow:ellipsis;}
			.l-tree a, .l-tree span{color: #333;}
			.l-selected{background:#fff!important;}
			#tree1 .l-selected span{color: #333!important;}
			#tree1 .l-over{background:#fff;}
			.zika_header table{width: 100%;text-align: center;}
			.zika_header table td{border:1px solid #ccc;height: 26px;line-height: 26px;}
			.rizhi_detail{width: 560px;height: 340px;position: fixed;top: 25%;left: 50%;margin-left: -280px;background:#fff;border:1px solid #2f89f4;display: none;z-index: 999;}
			.yuliu_wapper{width: 340px;height: 200px;position: fixed;top: 30%;left: 50%;margin-left: -170px;background:#fff;border:1px solid #2f89f4;display: none;z-index: 999;}
			.rizhi_detail_header{height: 34px;background:#2f89f4;position: relative;}
			.rizhi_detail_close{width: 16px;height: 16px;position: absolute;right: 10px;top: 8px;color: #fff;cursor: pointer;background-image:url(${request.contextPath}/static/image/card.png);background-position: -31px 0px;background-repeat: no-repeat;}
			.rizhi_detail_close:hover{background-position: -61px 0px;}
			.rizhi_detail_info{height: 32px;line-height: 32px;color: #fff;padding-left: 32px;}
			.rizhi_detail_icon{width: 16px;height: 16px;position: absolute;top: 8px;left: 8px;background-image:url(${request.contextPath}/static/image/card.png);background-position: -0px 0px;background-repeat: no-repeat;}
			.rizhi_detail_content{overflow-y: auto;}
			.rizhi_detail_content table{width: 100%;text-align: center;}
			.rizhi_detail_content table th,.rizhi_detail_content table td{height: 26px;line-height: 26px;border:1px solid #ccc;text-align: center;}
			.rizhi_detail_content table th{border-bottom: none;}
			.yuliu_wapper_content table{width: 100%;text-align: center;}
			.yuliu_wapper_content td{height: 32px;line-height: 32px;border:1px solid #ccc;text-align: center;}
			.card_cover{position: fixed;left: 0;top: 0;width: 100%;height: 100%;display: none;z-index: 998;}
			.log_detail a{color:#2f88f3;}
			.card_info_main td{position: relative;}
			.edit_yuliu{height: 30px;}
			.yulliu_bottom{width: 100%;height: 34px;position: absolute;left: 0px;bottom: 0px;}
			.edit_action{width: 100px;height: 34px;position: fixed;left: 50%;margin-left: -50px;top: 50%;background:rgba(0,0,0,0.8);color: #fff;text-align: center;line-height: 34px;border-radius: 4px;display: none;}
			/*可编辑部分*/
			.nopower input{}
			/*提示框*/
			.tip_wapper{position: absolute;height: 24px;line-height: 24px;color: #fff;text-align: center;z-index: 99;}
			.tip_wapper span{display: block;height: 24px;line-height: 24px;background:rgba(0,0,0,0.7);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#CC000000,endColorstr=#CC000000);padding: 2px 10px;border-radius: 4px;}
			.tip_wapper i{width: 12px;height: 12px;position: absolute;left: 40px;top: -11px;background: url(${request.contextPath}/static/image/tipwapperjt.png);}
			/*日历修改*/
			.l-text-date,.l-text-combobox{width: 114px;}
			.l-text{border:none;}
			.l-trigger, .l-trigger-hover, .l-trigger-pressed{top: 4px;right: 2px;}
			/* 日历 */
			.l-box-dateeditor-header{height: 26px;line-height: 26px;background: none;}
			.l-box-dateeditor-header-btn{top: 1px;}
			.l-box-dateeditor-header-text{height: 26px;line-height: 26px;color: #333;}
			.l-box-dateeditor-body thead td{border-bottom: none;line-height: 32px;line-height: 32px;}
			.l-box-dateeditor-body tbody td.l-box-dateeditor-holiday{color: #333;}
			.l-box-dateeditor-header-text a{color: #333;font-size: 13px;}
			.l-box-dateeditor-body td{height: 20px;line-height: 20px;}
			.l-box-dateeditor-toolbar{background: none;}
			.l-box-dateeditor-body{border:none;}
			.l-box-dateeditor-toolbar .l-button{border:none;background: none;}
			.l-box-dateeditor-body tbody td.l-box-dateeditor-today{background: #59A4FF;}
			.l-box-dateeditor-body tbody td.l-box-dateeditor-over, .l-box-dateeditor-body tbody td.l-box-dateeditor-selected{
				background:#59A4FF;}
			.l-box-dateeditor{width: 220px;border-color: #e6e6e6;padding-top:2px;margin-top:3px;border-radius: 4px;box-shadow: 0px 0px 2px #999;}
			.l-box-dateeditor-header-prevyear span,.l-box-dateeditor-header-prevmonth span,.l-box-dateeditor-header-nextmonth span,.l-box-dateeditor-header-nextyear span{background-image: url(../../static/image/dateeditor.png);}
			.l-box-dateeditor-header-prevyear span{background-position: -26px 0px;}
			.l-box-dateeditor-header-prevmonth span{background-position: -56px 0px;}
			.l-box-dateeditor-header-nextmonth span{background-position: -86px 0px;}
			.l-box-dateeditor-header-nextyear span{background-position: -116px 0px;}
			.l-box-dateeditor-header-prevyear:hover span,.l-box-dateeditor-header-prevmonth:hover span,.l-box-dateeditor-header-nextmonth:hover span,.l-box-dateeditor-header-nextyear:hover span{background-image: url(${request.contextPath}/static/image/dateeditor_hover.png);}
			.l-box-dateeditor-header-btn-over{background: none;border:none;}
			.l-box-dateeditor-toolbar .l-button-close{margin-left: 44px;color: #59A4FF;font-size:13px;}
			.l-box-dateeditor-toolbar .l-button-today{margin-left: 28px;color: #59A4FF;font-size:13px;}
			.l-box-dateeditor-header-prevmonth{left: 26px;}
			.l-box-dateeditor-header-nextmonth{right: 28px;}
			.l-box-dateeditor-monthselector li,.l-box-dateeditor-yearselector li{width: 61px;margin-top: 12px;}
			.l-trigger{border-color:#ddd;background:none;}
			.l-spinner-down-over{background:none;}
			.l-spinner-up-over{background:none;}
			.l-spinner-split{background:none;}
			.l-spinner-down:hover .l-spinner-icon{background-image:url(${request.contextPath}/static/image/icon-down-over.png);}
			.l-spinner-up:hover .l-spinner-icon{background-image:url(${request.contextPath}/static/image/icon-up-over.png);}
			/*树下拉菜单样式*/
			.l-box-select-inner{}
			.l-tree .l-selected span{color: #333;}
			.l-tree-noline .l-box{}
			.l-tree .l-over{background:none;}
			.l-tree .l-body span:hover{background:#abcdef;}
			.l-tree li .l-body{height: 18px;line-height: 18px;}
			.l-tree a, .l-tree span{height: 18px;line-height: 18px;}
			.l-trigger{border:none;background:#fff;}
			.l-trigger-hover{background:#fff;border:none;}
			.l-trigger-pressed{background:#fff;border-color: transparent;}
			.td_cover{width: 100%;height: 34px;position: absolute;top: 0px;left:0px;z-index: 9;}
			.l-tree .l-box{height: 18px;line-height: 18px;background-image: url(${request.contextPath}/static/image/treeforcard.png);}

		</style>
	</head>

	<body>
		<div class="detail_card_header">
			<div class="card_img">
				<div class="card_bigimg">
					<#if cardDetailInfo["FILENAME1"]??>
						<img src="${prefixPath}/FileFolder/${cardDetailInfo['FILENAME1']}.${cardDetailInfo['EXTENSION1']}" />
					<#else>
						<img src="${request.contextPath}/static/image/errorload.png" />
					</#if>
				</div>
				<div class="card_imglist">
					<ul>
						<li>
							<#if cardDetailInfo["FILENAME1"]??>
								<img src="${prefixPath}/FileFolder/${cardDetailInfo['FILENAME1']}.${cardDetailInfo['EXTENSION1']}" />
							<#else>
								<img src="${request.contextPath}/static/image/errorload.png" />
							</#if>
						</li>
						<li>
							<#if cardDetailInfo["FILENAME2"]??>
								<img src="${prefixPath}/FileFolder/${cardDetailInfo['FILENAME2']}.${cardDetailInfo['EXTENSION2']}" />
							<#else>
								<img src="${request.contextPath}/static/image/errorload.png" />
							</#if>
						</li>
						<li>
							<#if cardDetailInfo["FILENAME3"]??>
								<img src="${prefixPath}/FileFolder/${cardDetailInfo['FILENAME3']}.${cardDetailInfo['EXTENSION3']}" />
							<#else>
								<img src="${request.contextPath}/static/image/errorload.png" />
							</#if>
						</li>
						<li style="margin-right: 0">
							<#if cardDetailInfo["FILENAME4"]??>
								<img src="${prefixPath}/FileFolder/${cardDetailInfo['FILENAME4']}.${cardDetailInfo['EXTENSION4']}" />
							<#else>
								<img src="${request.contextPath}/static/image/errorload.png" />
							</#if>
						</li>
					</ul>
				</div>
			</div>
			<div class="card_maininfo">
				<ul>
					<li class="card_zcmc">资产名称：<input type="text" name="" value="${cardDetailInfo['ZICMC']}" disabled></li>
					<li>资产属性：固定资产</li>
					<li>资产分类：台式机</li>
					<li class="card_sl">数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量：<input type="text" name="" value="${cardDetailInfo['SHUL']}" disabled></li>
					<li class="card_jldw">计量单位：<input type="text" name="" value="台" disabled></li>
					<li class="card_jz">价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;值：<input type="text" name="" value="${cardDetailInfo['JIAZ']}" disabled></li>
				</ul>
			</div>
		</div>
		<div class="detail_card_cont">
			<div class="detail_card_tab">
				<ul>
					<li class="card_tab_selsect info_main" tabid="info_main">基本信息</li>
				</ul>
				<div class="baseinfo_edit" edit="false">修改</div>
			</div>
			<div class="card_info_list">
				<#-- 基本信息模版 -->
				<#include "${baseInfoByModelId_URL}" />
			</div>
		</div>
		<div class="yuliu_wapper" style="display: none">
			<div class="rizhi_detail_header">
				<div class="rizhi_detail_info">修改预留字段</div>
				<div class="rizhi_detail_icon"></div>
				<div class="rizhi_detail_close"></div>
			</div>
			<div class="yuliu_wapper_content">
				<table>
					<tr>
						<td class="yuliu_old"></td>
						<td><input type="text" name="" value=""></td>
					</tr>
					<tr>
						<td class="yuliu_old"></td>
						<td><input type="text" name="" value=""></td>
					</tr>
					<tr>
						<td class="yuliu_old"></td>
						<td><input type="text" name="" value=""></td>
					</tr>
				</table>
			</div>
			<div class="yulliu_bottom">
				<span class="iframe_btn iframe_btn_qd">确定</span>
				<span class="iframe_btn iframe_btn_qx">取消</span>
			</div>
		</div>
		<div class="edit_action">保存成功！</div>
		<div class="card_cover"></div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerTreeForCard.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditorForCard.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerComboBox.js"></script>

		<script>

			$(function() {
				var glbmData = [
							    { "text": "节点1", "id" : 0, "children": [
							        { "text": "节点1.1" },
							        { "text": "节点1.2" },
							        { "text": "节点1.3", "children": [
							                { "text": "节点1.3.1" ,"children": [
												{ "text": "节点1.3.1.1111111111111111" },
												{ "text": "节点1.3.1.2" }]
											},
							                { "text": "节点1.3.2" }
							        ]
							        },
							        { "text": "节点1.4" }
							        ]
							    },
							    { "text": "节点2" },
							    { "text": "节点3" },
							    { "text": "节点4" }
							]

				// 动态设置 card_info_list 高度
				$(".card_info_list").height($("body").height() - $(".detail_card_header").height() - 35 - 11);
				// 楼层框动态赋值最大高度
				$(".louceng_cont").height($(".card_info_list").height() - 34);			// 业务日志弹出框显示隐藏


				var treedata = [${floorVo}];

				// 鼠标悬浮图片切换
				$(".card_imglist li").mouseenter(function() {
					$(".card_bigimg img").attr("src", $(this).children("img").attr("src"));
				});

				// 卡片编辑功能
				$(".baseinfo_edit").click(function(){
					if($(this).attr("edit") == "false"){
						// 修改表单属性为可编辑
						$(".card_info_main input, .card_info_main select, .card_info_main textarea, .card_maininfo input").prop("disabled", false);
						// 改变无权限修改项背景色
						$(".nopower input, .nopower select").css("background", "#f0f0f0").prop("disabled", true);
						// 显示日历修改按钮
						$(".l-trigger").show();
						// 隐藏无权限修改项按钮
						$(".nopower .l-trigger").hide();
						// 显示树形下拉框按钮
						$(".td_cover").hide();
						// 编辑按钮状态切换
						$(this).html("保存").attr("edit", "true");
					}else{
						var canSubmit = true;
						// 基本信息表单正则验证代码
						$(".musthaveinfo").each(function(key, val){
							// 遍历每个必填项，为空则添加提示框
							if($(val).find("input, select").val().replace(/(^\s*)|(\s*$)/g, "") == ""){
								if(! $(val).children("div").hasClass("tip_wapper")){
									alertTip("该项不能为空", $(val), "td");
								}
								$(val).find("input, select").css({"border-color":"#f90", "box-shadow":"0px 0px 3px #f90"})
								// 滚动条滚动至第一个检测到未填写表单所在位置
								if(canSubmit){
									$(".card_info_list").scrollTop($(val).offset().top - 230);
								}
								canSubmit = false;
							}else{
								$(val).children(".tip_wapper").remove();
							}
						});
						// 判断canSubmit
						if(!canSubmit){
							return false;
						}else{
							// 修改表单状态为不可编辑
							$(".card_info_main input, .card_info_main select, .card_info_main textarea, .card_maininfo input").prop("disabled", true);
							// 去除无权限修改项的颜色
							$(".nopower input, .nopower select").css("background", "#fff");
							// 隐藏日期修改按钮 日期需要改为不可编辑(IE8需要做兼容)
							$(".l-trigger").hide();
							// 隐藏树形下拉框按钮
							$(".td_cover").show();
							// 删除tips
							$(".tip_wapper").remove();
							// 发送ajax请求保存修改内容
							//...
							// 编辑按钮状态切换
							$(this).html("修改").attr("edit", "false");
						}
					}
				});

				// input键盘事件，当输入不为空时tips消失
				$(".card_info_main, .card_maininfo").on("keyup", "input", function(){
					if($(this).val().replace(/(^\s*)|(\s*$)/g, "") != ""){
						$(this).siblings(".tip_wapper").hide();
					}else{
						$(this).siblings(".tip_wapper").show();
					}
				});
				$(".card_info_main, .card_maininfo").on("change", "select", function(){
					console.log($(this).val());
					if($(this).val().replace(/(^\s*)|(\s*$)/g, "") != ""){
						$(this).siblings(".tip_wapper").hide();
					}else{
						$(this).siblings(".tip_wapper").show();
					}
				});
				// input键盘事件，管理部门当select选项不为空时内容tips消失
				$(".musthaveinfo").on("click", "#glbmCheckbox_txt", function(){
					$(this).parents("td").children(".tip_wapper").remove();
				});

				// input键盘事件，只能输入二位小数
				$(".mustnumber").on("keyup", "input", function(){
					var val = $(this).val();
					val = val.replace(/[^\d.]/g,"").replace(/^\./g,"").replace(/\.{2,}/g,".").replace(".","$#$").replace(/\./g,"").replace("$#$",".").replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');
					$(this).val(val);
				}).on("keypress", "input", function(){
					var keyCode = event.keyCode;
					if ((keyCode >= 48 && keyCode <= 57 || keyCode == 46)){
						event.returnValue = true;
					} else {
						event.returnValue = false;
					}
				});

				//修改预留字段信息
				$(".edit_yuliu_btn").click(function(){
					var oldText = $(".yuliu_wapper_content .yuliu_old");
					$(".yuliu .text-idt").each(function(key, val){
						oldText.eq(key).html(val.innerHTML);
					});
					$(".yuliu_wapper").show();
				});
				$(".iframe_btn_qd").click(function(){

				});
				$(".iframe_btn_qx").click(function(){
					$(".yuliu_wapper").hide();
				});

				//数量，价值，单价，账面净值数据联动 (需要在每个模版上都加上相应类)
				$(".card_jz").keyup(function(){
					var card_jz = Number($(this).children("input").val());
					var card_sl = Number($(".card_sl").children("input").val());
					$(".jiazhi").children("input").val(card_jz);
					$(".zmjz").children("input").val(card_jz);
					$(".danjia").children("input").val((card_jz / card_sl).toFixed(2));
				});
				$(".card_sl").keyup(function(){
					var card_sl = Number($(".card_sl").children("input").val());
					var card_jz = Number($(".card_jz").children("input").val());
					if(card_sl == 0){
						alertTip("资产数量不能为空", $(".card_sl"), "li");
						return false;
					}else{
						$(".danjia").children("input").val((card_jz / card_sl).toFixed(2));
					}
				});
				$(".jiazhi").keyup(function(){
					var jiazhi = Number($(this).children("input").val());
					var card_sl = Number($(".card_sl").children("input").val());
					$(".card_jz, .zmjz").children("input").val(jiazhi);
					$(".danjia").children("input").val((jiazhi / card_sl).toFixed(2));
				});

				// 获取焦点时输入框或select框高亮
				$("body").on("focus", "input, select, textarea", function(){
					$(this).css({"border-color":"#f90", "box-shadow":"0px 0px 3px #f90"});
				}).on("blur", "input, select, textarea", function(){
					$(this).css({"border-color":"#ddd", "box-shadow":"none"});
				});

				// 日历生成
				$(".card_datedit").ligerDateEditor();
				// 默认隐藏日历编辑按钮
				$(".l-trigger").hide();
				$(".card_datedit").attr("readonly", true);

				// 管理部门下拉树生成
				$("#glbmCheckbox").ligerComboBox({
					selectBoxWidth: 200,
					selectBoxHeight: 160, valueField: 'text',treeLeafOnly:false,
					tree: { data: glbmData, checkbox: false, parentIcon: null, childIcon: null, idFieldName: 'text' }
				});

				//弹出提示框方法 that 指的是需要弹框的jq对象
				function alertTip(tipinfo, that, who){
					if(who == "li"){
						var $div = $("<div class='tip_wapper'><span>" + tipinfo + "</span><i></i></div>").css({"top": "28px", "right": "10px"});
					}else if(who == "td"){
						var $div = $("<div class='tip_wapper'><span>" + tipinfo + "</span><i></i></div>").css({"top": "32px", "left": "0px"});
					}
					$div.appendTo(that);
				}
			});

		</script>
	</body>
</html>