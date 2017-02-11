<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>盘点卡片列表 - 列表模式</title>
		<link rel="stylesheet" href="${request.contextPath}/static/framework/ligerui-lib/ligerUI/skins/Aqua/css/ligerui-all.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/reset.css" />
		<link rel="stylesheet" href="${request.contextPath}/static/css/iframe.css" />
	</head>

	<body class="card_body">
		<div class="container_box container_card" style="min-width: 980px">
			<div class="toolbar_wapper">
				<#-- 声明一个名为 queryUrl 的变量，并为其传入查询时需要访问的 URL -->
				<#assign queryUrl = "${request.contextPath}/Monitor/Pdjk/list" />
				<#-- 声明一个名为 exportUrl 的变量，并为其传入导出时需要访问的 URL -->
				<#assign exportUrl = "${request.contextPath}/Monitor/Pdjk/exportExcel" />
				<#-- 导入工具栏模板 -->
				<#include "/base/toolbar_box.ftl" />
			</div>
			<div class="list_wapper">
				<div class="list_wapper_header">
					<table class="list_table_header">
						<tr>
							<td style="width: 3%"><div class="xuhao_header">序号</div></td>
							<td style="width: 2%"></td>
							<td class="sort" style="width: 7%">
								<a href="javascript: void(0)">
									资产名称
									<span class="card_order_jt" column="ZICMC"></span>
								</a>
							</td>
							<td class="sort" style="width: 7%">
								<a href="javascript: void(0)">
									资产编号
									<span class="card_order_jt" column="OBJCODE"></span>
								</a>
							</td>
							<td class="sort" style="width: 6%">
								<a href="javascript: void(0)">
									规格型号
									<span class="card_order_jt" column="GUIGXH"></span>
								</a>
							</td>
							<td class="sort" style="width: 7%">
								<a href="javascript: void(0)">
									购置日期
									<span class="card_order_jt" column="GOUZRQ"></span>
								</a>
							</td>
							<td class="sort" style="width: 8%">
								<a href="javascript: void(0)">
									财务入账日期
									<span class="card_order_jt" column="CAIWRZRQ"></span>
								</a>
							</td>
							<td class="sort" style="width: 7%">
								<a href="javascript: void(0)">
									单价
									<span class="card_order_jt" column="DANJ"></span>
								</a>
							</td>
							<td class="sort" style="width: 4%">
								<a href="javascript: void(0)">
									数量
									<span class="card_order_jt" column="SHUL"></span>
								</a>
							</td>
							<td class="sort" style="width: 5%">
								<a href="javascript: void(0)">
									价值
									<span class="card_order_jt" column="JIAZ"></span>
								</a>
							</td>
							<td class="sort" style="width: 6%">
								<a href="javascript: void(0)">
									计量单位
									<span class="card_order_jt" column="JILDW"></span>
								</a>
							</td>
							<td class="sort" style="width: 6%">
								<a href="javascript: void(0)">
									存放地点
									<span class="card_order_jt" column="CUNFDD"></span>
								</a>
							</td>
							<td class="sort" style="width: 6%">
								<a href="javascript: void(0)">
									资产状态
									<span class="card_order_jt" column="SHIYZK"></span>
								</a>
							</td>
							<td class="sort" style="width: 7%">
								<a href="javascript: void(0)">
									使用部门
									<span class="card_order_jt" column="SHIYBM"></span>
								</a>
							</td>
							<td class="sort" style="width: 5%">
								<a href="javascript: void(0)">
									使用人
									<span class="card_order_jt" column="SHIYR"></span>
								</a>
							</td>
						</tr>
					</table>
				</div>
				<div class="list_wapper_content">
					<table>
						<#list page.results as obj>
							<tr <#if obj_index % 2 != 0>style="background: #fafafa"</#if>>
								<td class="xuhao" style="width: 3%; background: #fafafa">${obj_index + 1}</td>
								<td class="list_td_label" style="width: 2%"><label class="list_label fl"><input class="chk" type="checkbox" value="${obj['RWID']}" price="${obj['JIAZ']}" /></label></td>
								<td style="width: 7%"><a class="item_card_info_list" href="javascript: void(0)" rwid="${obj['RWID']}" editable="1">${obj["ZICMC"]}</a></td>
								<td style="width: 7%">${obj["OBJCODE"]}</td>
								<td style="width: 6%">${obj["GUIGXH"]}</td>
								<td style="width: 7%">${obj["GOUZRQ"]}</td>
								<td style="width: 8%"><#if obj["CAIWRZRQ"]??>${obj["CAIWRZRQ"]}<#else>未登账</#if></td>
								<td style="width: 7%">${obj["DANJ"]}</td>
								<td style="width: 4%">${obj["SHUL"]}</td>
								<td style="width: 5%">${obj["JIAZ"]}</td>
								<td style="width: 6%">${obj["JILDW"]}</td>
								<td style="width: 6%">${obj["CUNFDD"]}</td>
								<td style="width: 6%">${obj["SHIYZK"]}</td>
								<td style="width: 7%">${obj["SHIYBM"]}</td>
								<td style="width: 5%">${obj["SHIYR"]}</td>
							</tr>
						</#list>
					</table>
				</div>
			</div>
		</div>
		<form class="filter_form" action="${request.contextPath}/Monitor/Pdjk/list" method="post">
			<#-- 当前页数 -->
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
			<#-- 来源模块（用于标识是从何处穿透至卡片列表） -->
			<input name="fromModel" type="hidden" value="${fromModel}" />
			<input name="sortpartStr" type="hidden" value="${sortpartStr}" />
			<#-- 盘点监控模块的特别参数 -->
			<input name="qcjzr" type="hidden" value="${qcjzr}" /> <#-- 清查基准日 -->
			<input name="pdjkType" type="hidden" value="${pdjkType}" />
			<input name="pdjkRwid" type="hidden" value="${pdjkRwid}" />
			<input name="pdjkOrgid" type="hidden" value="${pdjkOrgid}" />
			<input name="pdjkDeptid" type="hidden" value="${pdjkDeptid}" />
			<input name="colType" type="hidden" value="${colType}" />
			<#-- 额外参数 -->
			<input name="extra" type="hidden" value="${extra}" />
			<#-- 视图模式 -->
			<input id="viewMode" name="viewMode" type="hidden" value="${VIEW_MODE}" />
			<#-- 选中数据的 ID 集合 -->
			<input id="checkedIdStr" name="checkedIdStr" type="hidden" />
			<div class="more_search">
				<div class="more_search_main">
					<table>
						<tr>
							<td class="more_search_item">资产名称：</td>
							<td><input name="zicmc" type="text" value="${zicmc}" placeholder="可模糊查询资产名称" /></td>
							<td class="more_search_item">规格型号：</td>
							<td><input name="guigxh" type="text" value="${guigxh}" placeholder="可模糊查询规格型号" /></td>
						</tr>
						<tr>
							<td class="more_search_item">原资产编号：</td>
							<td><input name="yuanzcbh_min" type="text" value="${yuanzcbh_min}" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="yuanzcbh_max" type="text" value="${yuanzcbh_max}" /></td>
						</tr>
						<tr>
							<td class="more_search_item">资产编号：</td>
							<td><input name="objcode_min" type="text" value="${objcode_min}" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="objcode_max" type="text" value="${objcode_max}" /></td>
						</tr>
						<tr class="search_date">
							<td class="more_search_item">购置日期：</td>
							<td class="search_datebox"><input id="gouzrq_begin" name="gouzrq_begin" type="text" value="${gouzrq_begin}" /></td>
							<td class="more_search_item" style="text-align: center">
								至
								<div class="query_button_tips">起始日期不能大于截止日期！</div>
							</td>
							<td class="search_datebox"><input id="gouzrq_end" name="gouzrq_end" type="text" value="${gouzrq_end}" /></td>
						</tr>
						<tr class="search_date">
							<td class="more_search_item">财务入账：</td>
							<td class="search_datebox"><input id="caiwrzrq_begin" name="caiwrzrq_begin" type="text" value="${caiwrzrq_begin}" /></td>
							<td class="more_search_item" style="text-align: center">
								至
								<div class="query_button_tips">起始日期不能大于截止日期！</div>
							</td>
							<td class="search_datebox"><input id="caiwrzrq_end" name="caiwrzrq_end" type="text" value="${caiwrzrq_end}" /></td>
						</tr>
						<tr>
							<td class="more_search_item">单价：</td>
							<td><input name="danj_min" type="text" value="${danj_min}" /></td>
							<td class="more_search_item" style="text-align: center">至</td>
							<td><input name="danj_max" type="text" value="${danj_max}" /></td>
						</tr>

					<#--
						<tr>
							<td class="more_search_item">使用部门：</td>
							<td class="search_datebox"><input type="hidden" id="sybmCheckbox" name="" /></td>
							<td class="more_search_item">使用人：</td>
							<td class="search_datebox"><input type="hidden" id="syrCheckbox" name="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">资产大类：</td>
							<td class="search_datebox"><input type="hidden" id="zcdlCheckbox" name="" /></td>
							<td class="more_search_item">资产分类：</td>
							<td class="search_datebox"><input type="hidden" id="zcflCheckbox" name="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">卡片类型：</td>
							<td>
								<select>
									<option value=""></option>
									<option value="">主卡片</option>
									<option value="">有附属卡片的主卡片</option>
									<option value="">无附属卡片的主卡片</option>
									<option value="">附属卡片</option>
									<option value="">全部</option>
								</select>
							</td>
							<td class="more_search_item">是否待报废：</td>
							<td>
								<select>
									<option value=""></option>
									<option value="">未标识待报废</option>
									<option value="">标识待报废</option>
									<option value="">全部</option>
								</select>
							</td>
						</tr>
						<tr class="search_date">
							<td class="more_search_item">开箱日期：</td>
							<td class="search_datebox"><input id="kxdateBegin" name="kxdateBegin" type="text" value="" /></td>
							<td class="more_search_item" style="text-align: center">
								至
								<div class="query_button_tips">起始日期不能大于截止日期！</div>
							</td>
							<td class="search_datebox"><input id="kxdateEnd" name="kxdateEnd" type="text" value="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">凭证号：</td>
							<td><input type="text" name="" /></td>
							<td class="more_search_item">是否标记：</td>
							<td>
								<select>
									<option value=""></option>
									<option value="">未标记</option>
									<option value="">已标记</option>
									<option value="">全部</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="more_search_item">备注：</td>
							<td><input type="text" name="" /></td>
							<td class="more_search_item">取得方式：</td>
							<td>
								<select>
									<option value=""></option>
									<option value="">新购</option>
									<option value="">调拨</option>
									<option value="">接受捐赠</option>
									<option value="">自建</option>
									<option value="">置换</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="more_search_item">合同编号：</td>
							<td><input type="text" name="" /></td>
						</tr>
						<tr>
							<td class="more_search_item">批量查找：</td>
							<td colspan="3"><textarea class="more_search_textarea" form="" placeholder="您可以批量输入卡片编号"></textarea></td>
						</tr>
					-->

					</table>
				</div>
				<div class="more_search_bottom">
					<div class="iframe_btn iframe_btn_qk">清空</div>
					<input type="submit" class="iframe_btn iframe_btn_qd" value="确定" />
					<div class="iframe_btn iframe_btn_qx">取消</div>
				</div>
			</div>
		</form>
		<div class="total_price">
			<div class="container_box">
				您所选的资产共计：<span id="total_number">0</span>&nbsp;条，金额共计：<span id="total_price">0.00</span>&nbsp;元
			</div>
		</div>

		<#-- 导入基础 JS 模版，这里面引入了公共的类库，并已提供好一些通用的事件及函数 -->
		<#include "/base/base_js.ftl" />
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/core/base.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerDateEditor.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerCheckBox.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerResizable.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerTree.js"></script>
		<script src="${request.contextPath}/static/framework/ligerui-lib/ligerUI/js/plugins/ligerComboBox.js"></script>
		<script>

			$(function() {

				setMaxheight(36);

				// 使用部门数据
				var sybmData = [
								{ text: '财务处', id: '1' },
								{ text: '局领导', id: '2' },
							]
				// 使用人数据
				var syrData = [
								{text: '吴少', id: '1'},
								{text: '吴少青', id: '2'},
								{text: '吴少绿', id: '3'},
								{text: '吴少红', id: '4'},
								{text: '吴少黄', id: '5'}
							]
				// 资产大类数据
				var zcdlData = [
								{text: '土地、房屋及构筑物', id: '1'},
								{text: '通用设备', id: '2'},
								{text: '专用设备', id: '3'},
								{text: '文物和陈列品', id: '4'},
								{text: '图书、档案', id: '5'},
								{text: '家具、用具、装具及动植物', id: '6'},
								{text: '无形资产', id: '7'}
							]

				// 生成日历
				$("#gouzrq_begin").ligerDateEditor();
				$("#gouzrq_end").ligerDateEditor();
				$("#caiwrzrq_begin").ligerDateEditor();
				$("#caiwrzrq_end").ligerDateEditor();
				$("#kxdateBegin").ligerDateEditor();
				$("#kxdateEnd").ligerDateEditor();

				// 将日历文本框设为只读
				$("#gouzrq_begin, #gouzrq_end, #caiwrzrq_begin, #caiwrzrq_end").attr("readonly", true);

				$("#sybmCheckbox").ligerComboBox({ isShowCheckBox: true, isMultiSelect: true,
					data: sybmData,
					valueFieldID: 'sybmCheckbox'
				});
				$("#syrCheckbox").ligerComboBox({ isShowCheckBox: true, isMultiSelect: true,
					data: syrData,
					valueFieldID: 'syrCheckbox'
				});
				$("#zcdlCheckbox").ligerComboBox({ isShowCheckBox: true, isMultiSelect: true,
					selectBoxWidth: 180,
					data: zcdlData,
					valueFieldID: 'zcdlCheckbox'
				});
				$("#zcflCheckbox").ligerComboBox({
					selectBoxWidth: 200,
					selectBoxHeight: 200, valueField: 'text',treeLeafOnly:false,
					tree: { data: zcdlData, checkbox: false, idFieldName: 'text' }
				});

			});

			window.onresize = function() {
				setMaxheight(36);
			}

		</script>
	</body>
</html>