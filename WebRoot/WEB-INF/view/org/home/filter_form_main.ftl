<form class="filter_form" action="${queryUrl}" method="post">
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
				<tr>
					<td class="more_search_item">使用部门：</td>
					<td class="search_datebox"><input id="sybmCheckbox" name="" type="text" /></td>
					<td class="more_search_item">使用人：</td>
					<td class="search_datebox"><input id="syrCheckbox" name="" type="text" /></td>
				</tr>
				<tr>
					<td class="more_search_item">资产大类：</td>
					<td class="search_datebox"><input id="zcdlCheckbox" name="" type="text" /></td>
					<td class="more_search_item">资产分类：</td>
					<td class="search_datebox"><input id="zcflCheckbox" name="" type="text" /></td>
				</tr>
				<tr>
					<td class="more_search_item">使用状况：</td>
					<td class="search_datebox"><input id="syzkCheckbox" name="" type="text" /></td>
					<td class="more_search_item">管理部门：</td>
					<td class="search_datebox"><input id="glbmCheckbox" name="" type="text" /></td>
				</tr>
				<tr>
					<td class="more_search_item">存放地点：</td>
					<td><input name="" type="text" /></td>
					<td class="more_search_item">是否登账：</td>
					<td>
						<select>
							<option value=""></option>
							<option value="">未登账</option>
							<option value="">已登账</option>
							<option value="">全部</option>
						</select>
					</td>
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
					<td class="search_datebox"><input id="kxdateBegin" name="kxdateBegin" type="text" /></td>
					<td class="more_search_item" style="text-align: center">
						至
						<div class="query_button_tips">起始日期不能大于截止日期！</div>
					</td>
					<td class="search_datebox"><input id="kxdateEnd" name="kxdateEnd" type="text" /></td>
				</tr>
				<tr>
					<td class="more_search_item">凭证号：</td>
					<td><input type="text" /></td>
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
					<td><input type="text" /></td>
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
					<td><input type="text" /></td>
				</tr>
				<tr>
					<td class="more_search_item">批量查找：</td>
					<td colspan="3"><textarea class="more_search_textarea" placeholder="您可以批量输入卡片编号"></textarea></td>
				</tr>
			</table>
		</div>
		<div class="more_search_bottom">
			<div class="iframe_btn iframe_btn_qk">清空</div>
			<input type="submit" class="iframe_btn iframe_btn_qd" value="确定" />
			<div class="iframe_btn iframe_btn_qx">取消</div>
		</div>
	</div>
</form>