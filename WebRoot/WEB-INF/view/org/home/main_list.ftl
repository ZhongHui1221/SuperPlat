<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>所有资产 - 列表模式</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe_org.css" />
	</head>

	<body>
		<div class="container_card">
			<div class="main_tabs">
				<div class="container">
					<ul class="main_tabs_list">
						<li><a class="active" href="">所有资产</a><span class="sanjx_jt active"></span></li>
						<li><a href="">待收货</a><span class="sanjx_jt"></span></li>
						<li><a href="">待维修</a><span class="sanjx_jt"></span></li>
						<li><a href="">待转移</a><span class="sanjx_jt"></span></li>
						<li><a href="">待处置</a><span class="sanjx_jt"></span></li>
					</ul>
				</div>
			</div>
			<div class="toolbar_wapper container">
				<#-- 声明一个名为 queryUrl 的变量，并为其传入查询时需要访问的 URL -->
				<#assign queryUrl = "${request.contextPath}/orgHome/main" />
				<#-- 导入工具栏模板 -->
				<#include "/base/toolbar_box_org.ftl" />
			</div>
			<div class="list_wapper container">
				<div class="list_wapper_header">
					<table class="list_table_header">
						<colgroup>
							<col width="3%"></col>
							<col width="3%"></col>
							<col width="10%"></col>
							<col width="8%"></col>
							<col width="9%"></col>
							<col width="9%"></col>
							<col width="9%"></col>
							<col width="9%"></col>
							<col width="8%"></col>
							<col width="8%"></col>
							<col width="8%"></col>
							<col width="8%"></col>
							<col width="8%"></col>
						</colgroup>
						<tr>
							<td><div class="xuhao_header">序号</div></td>
							<td></td>
							<td class="sort">
								<a href="javascript: void(0)">
									资产编号
									<span class="card_order_jt" column="OBJCODE"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									资产名称
									<span class="card_order_jt" column="ZICMC"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									规格型号
									<span class="card_order_jt" column="GUIGXH"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									使用状态
									<span class="card_order_jt" column="SHIYZK"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									存放地点
									<span class="card_order_jt" column="CUNFDD"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									使用部门
									<span class="card_order_jt" column="SHIYBM"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									计量单位
									<span class="card_order_jt" column="JILDW"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									数量
									<span class="card_order_jt" column="SHUL"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									价值
									<span class="card_order_jt" column="JIAZ"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									使用人
									<span class="card_order_jt" column="SHIYR"></span>
								</a>
							</td>
							<td class="sort">
								<a href="javascript: void(0)">
									单价
									<span class="card_order_jt" column="DANJ"></span>
								</a>
							</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<colgroup>
							<col width="3%"></col>
							<col width="3%"></col>
							<col width="10%"></col>
							<col width="8%"></col>
							<col width="9%"></col>
							<col width="9%"></col>
							<col width="9%"></col>
							<col width="9%"></col>
							<col width="8%"></col>
							<col width="8%"></col>
							<col width="8%"></col>
							<col width="8%"></col>
							<col width="8%"></col>
						</colgroup>
						<#list page.results as obj>
							<tr <#if obj_index % 2 != 0>class="tr_color"</#if>>
								<td class="xuhao">${obj_index + 1}</td>
								<td class="list_td_label">
									<label class="list_label fl"><input class="chk" type="checkbox" value="${obj['RWID']}" price="${obj['JIAZ']}" /></label>
								</td>
								<td><a class="item_card_info_list" href="javascript: void(0)" rwid="${obj['RWID']}" editable="0">${obj["OBJCODE"]}</a></td>
								<td>${obj["ZICMC"]}</td>
								<td>${obj["GUIGXH"]}</td>
								<td>${obj["SHIYZK"]}</td>
								<td>${obj["CUNFDD"]}</td>
								<td>${obj["SHIYBM"]}</td>
								<td>${obj["JILDW"]}</td>
								<td>${obj["SHUL"]}</td>
								<td>${obj["JIAZ"]}</td>
								<td>${obj["SHIYR"]}</td>
								<td>${obj["DANJ"]}</td>
							</tr>
						</#list>
					</table>
				</div>
			</div>
		</div>
		<#-- 导入更多筛选主模板 -->
		<#include "/org/home/filter_form_main.ftl" />

		<div class="total_price">
			<div class="container">
				您所选的资产共计：<span id="total_number">0</span>&nbsp;条，金额共计：<span id="total_price">0.00</span>&nbsp;元
			</div>
		</div>
		<!-- 日期范围选择弹出框 -->
		<div class="date_range_modal">
			<table>
				<tr>
					<td><div class="query_info fl">开始时间：</div></td>
					<td><div><input id="beginDateStr_m" name="" type="text" value="" /></div></td>
				</tr>
				<tr>
					<td><div class="query_info fl">到期时间：</div></td>
					<td><div><input id="endDateStr_m" name="" type="text" value="" /></div></td>
				</tr>
			</table>
		</div>

		<#include "/base/base_org_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerCheckBox.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerResizable.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerTree.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerComboBox.js"></script>
		<script>

			$(function() {

				setMaxheight(0);

				// 使用人数据
				var syrData = [
								{text: '吴少', id: '1'},
								{text: '吴少青', id: '2'},
								{text: '吴少绿', id: '3'},
								{text: '吴少红', id: '4'},
								{text: '吴少青', id: '5'},
								{text: '吴少绿', id: '6'},
								{text: '吴少红', id: '7'},
								{text: '吴少青', id: '8'},
								{text: '吴少绿', id: '9'},
								{text: '吴少红', id: '10'},
								{text: '吴少青', id: '11'},
								{text: '吴少绿', id: '12'},
								{text: '吴少红', id: '13'},
								{text: '吴少青', id: '14'},
								{text: '吴少绿', id: '15'},
								{text: '吴少红', id: '16'},
								{text: '吴少黄', id: '17'}
							]

				// 资产大类数据
				var zcdlData = [
								{text: '土地房屋及构筑物', id: '1'},
								{text: '通用设备', id: '2'},
								{text: '专用设备', id: '3'},
								{text: '文物及陈列品', id: '4'},
								{text: '图书档案', id: '5'}
							]

				// 资产分类, 管理部门, 使用部门等数据
				var zcflData = [
							    { "text": "节点1", "id" : 1, "children": [
							        { "text": "节点1.1", "id": "11" },
							        { "text": "节点1.2", "id": "12" },
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
							    { "text": "节点2", "id": 2 },
							    { "text": "节点3", "id": 3 },
							    { "text": "节点4", "id": 4 }
							]
				// 使用状况数据
				var syzkData = [
								{text: '入库', id: '1'},
								{text: '在用', id: '2', children: [
									{text: '自用', id: '21'},
									{text: '公用', id: '22'},
								]},
								{text: '出租', id: '3'},
								{text: '出借', id: '4'},
								{text: '闲置', id: '5'}
							]

				// 生成日历
				$("#gouzrq_begin, #gouzrq_end, #caiwrzrq_begin, #caiwrzrq_end, #kxdateBegin, #kxdateEnd").ligerDateEditor();

				// 将日历文本框设为只读
				$("#gouzrq_begin, #gouzrq_end, #caiwrzrq_begin, #caiwrzrq_end").attr("readonly", true);

				// 资产大类下拉复选框
				$("#zcdlCheckbox").ligerComboBox({
					isShowCheckBox: true,
					isMultiSelect: true,
					selectBoxWidth: 180,
					data: zcdlData,
					valueFieldID: 'zcdlCheckbox'
				});

				// 使用人下拉复选框
				$("#syrCheckbox").ligerComboBox({
					isShowCheckBox: true,
					isMultiSelect: true,
					selectBoxHeight: 180,
					data: syrData,
					valueFieldID: 'syrCheckbox'
				});

				// 使用部门下拉树
				$("#sybmCheckbox").ligerComboBox({
					selectBoxWidth: 200,
					selectBoxHeight: 200,
					valueField: 'text',
					treeLeafOnly:false,
					slide: true,
					tree: {
						data: zcflData,
						checkbox: true,
						autoCheckboxEven: false,
						parentIcon : false,
						childIcon : false,
						idFieldName: 'text'
					}
				});

				// 资产分类下拉树
				$("#zcflCheckbox").ligerComboBox({
					selectBoxWidth : 200,
					selectBoxHeight : 200,
					treeLeafOnly:false,
					slide: true,
					valueField : 'text',
					tree : {
						data : zcflData,
						checkbox : false,
						parentIcon : false,
						childIcon : false,
						idFieldName : 'text'
					}
				});

				// 使用状况下拉树
				$("#syzkCheckbox").ligerComboBox({
					selectBoxWidth: 150,
					selectBoxHeight: 150,
					treeLeafOnly:false,
					slide: true,
					valueField: 'text',
					tree: {
						data: syzkData,
						checkbox: true,
						parentIcon : false,
						childIcon : false,
						idFieldName: 'text'
					}
				});

				// 管理部门下拉树
				$("#glbmCheckbox").ligerComboBox({
					selectBoxWidth: 200,
					selectBoxHeight: 200,
					valueField: 'text',
					treeLeafOnly:false,
					slide: true,
					tree: {
						data: zcflData,
						checkbox: true,
						autoCheckboxEven: false,
						parentIcon : false,
						childIcon : false,
						idFieldName: 'text'
					}
				});

			});

			window.onresize = function() {
				setMaxheight(0);
			}

		</script>
	</body>
</html>