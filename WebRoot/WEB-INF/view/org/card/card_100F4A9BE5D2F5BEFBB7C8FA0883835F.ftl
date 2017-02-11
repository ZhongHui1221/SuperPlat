<div class="card_info_main">
	<#--通用设备-->
	<!-- 对于无权限编辑的表单，需要在td上加一个 no_auth 类 -->
	<!-- 对于非空的表单，需要在td上添加一个 musthaveinfo 类 -->
	<!-- 对于只能输入数字的表单，需要在td上添加一个 mustnumber 类 -->
	<!-- 日历选择框，需要给input添加 card_datedit 类 -->

	<!-- 此模版目前添加的是单位资产管理员权限 -->
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt">品牌</td>
				<td><input type="text" name="pinp" disabled value="${cardDetailInfo['PINP']}" /></td>
				<td class="text-idt">规格型号</td>
				<td><input type="text" name="guigxh" disabled value="${cardDetailInfo['GUIGXH']}" /></td>
				<td class="text-idt"><span>*</span>用途</td>
				<td>
					<select name="yongtid" disabled>
						<#list ytList as obj>
							<option value="${obj.rwid}"
								<#if obj.rwid == cardDetailInfo["YONGTID"]>selected</#if>
							>${obj.objname}</option>
						</#list>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>取得方式</td>
				<td class="musthaveinfo">
					<select name="qudfsid" disabled>
						<#list qdfsList as obj>
							<option value="${obj.rwid}"
								<#if obj.rwid == cardDetailInfo["QUDFSID"]>selected</#if>
							>${obj.objname}</option>
						</#list>
					</select>
				</td>
				<td class="text-idt"><span>*</span>购置日期</td>
				<td class="no_auth"><input class="card_datedit" name="gouzrq" type="text" value="${cardDetailInfo['GOUZRQ']}" /></td>
				<td class="text-idt">投入使用日期</td>
				<td><input class="card_datedit" name="toursyrq" type="text" value="${cardDetailInfo['TOURSYRQ']}" /></td>
			</tr>
			<tr>
				<td class="text-idt">采购形式</td>
				<td>
					<select name="caigzzxsid" disabled>
						<#list cgxsList as obj>
							<option value="${obj.rwid}"
								<#if obj.rwid == cardDetailInfo["CAIGZZXSID"]>selected</#if>
							>${obj.objname}</option>
						</#list>
					</select>
				</td>
				<td class="text-idt">采购合同编号</td>
				<td><input name="hetbh" type="text" disabled value="${cardDetailInfo['HETBH']}" /></td>
				<td class="text-idt">生产厂家</td>
				<td><input name="shengccj" type="text" disabled value="${cardDetailInfo['SHENGCCJ']}" /></td>
			</tr>
			<tr>
				<td class="text-idt">供应商</td>
				<td colspan="3" class="colspan_width"><input name="jingxs" type="text" disabled value="${cardDetailInfo['JINGXS']}" /></td>
				<td class="text-idt">联系电话</td>
				<td><input name="jingxsdh" type="text" disabled value="${cardDetailInfo['JINGXSDH']}" /></td>
			</tr>
			<tr>
				<td class="text-idt">保修截止日期</td>
				<td><input class="card_datedit" name="baoxjzrq" type="text" value="${cardDetailInfo['BAOXJZRQ']}" /></td>
				<td class="text-idt">预计使用年限（月）</td>
				<td class="mustnumber"><input name="yujsmzl" type="text" disabled value="${cardDetailInfo['YUJSMZL']}" /></td>
				<td class="text-idt">定期保养期限（月）</td>
				<td class="mustnumber"><input name="baoyqx" type="text" disabled value="${cardDetailInfo['BAOYQX']}" /></td>
			</tr>
			<tr>
				<td class="text-idt">原资产编号</td>
				<td><input name="yuanzcbh" type="text" disabled value="${cardDetailInfo['YUANZCBH']}" /></td>
			</tr>
		</table>
	</div>
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt">价值类型</td>
				<td class="no_auth">
					<select name="jiazlxid" disabled>
						<option value="">${cardDetailInfo["JIAZLX"]}</option>
					</select>
				</td>
				<td class="text-idt"><span>*</span>价值（元）</td>
				<td class="jiazhi"><input name="jiaz" type="text" disabled value="${cardDetailInfo['JIAZ']}" /></td>
				<td class="text-idt">发票号</td>
				<td><input name="faph" type="text" disabled value="${cardDetailInfo['FAPH']}" /></td>
			</tr>
			<tr>
				<td class="text-idt">财政补助收入</td>
				<td class="no_auth"><input name="caizbtsr" type="text" disabled value="${cardDetailInfo['CAIZBTSR']}" /></td>
				<td class="text-idt">科教项目收入</td>
				<td class="no_auth"><input name="kejxmsr" type="text" disabled value="${cardDetailInfo['KEJXMSR']}" /></td>
				<td class="text-idt">其他</td>
				<td class="no_auth"><input name="qitsr" type="text" disabled value="${cardDetailInfo['QITSR']}" /></td>
			</tr>
			<tr>
				<td class="text-idt">财务入账日期</td>
				<td class="no_auth"><input class="card_datedit" name="caiwrzrq" type="text" /></td>
				<td class="text-idt">会计凭证号</td>
				<td class="no_auth"><input name="kuaijpzh" type="text" disabled value="${cardDetailInfo['KUAIJPZH']}" /></td>
			</tr>
			<tr>
				<td class="text-idt">预算项目编号</td>
				<td class="no_auth"><input name="yusxmbh" type="text" disabled value="${cardDetailInfo['YUSXMBH']}" /></td>
				<td class="text-idt">单价（元）</td>
				<td class="no_auth danjia"><input name="danj" type="text" disabled value="${cardDetailInfo['DANJ']}" /></td>
			</tr>
			<tr>
				<td class="text-idt">折旧年限（月）</td>
				<td class="no_auth"><input name="zhejnx" type="text" disabled value="${cardDetailInfo['ZHEJNX']}" /></td>
				<td class="text-idt">累计折旧</td>
				<td class="no_auth"><input name="leijzj" type="text" disabled value="${cardDetailInfo['LEIJZJ']}" /></td>
				<td class="text-idt">账面净值</td>
				<td class="no_auth zmjz"><input name="jingz" type="text" disabled value="${cardDetailInfo['JINGZ']}" /></td>
			</tr>
		</table>
	</div>
	<div class="detail_card_info" style="border-bottom: none">
		<table>
			<tr>
				<td class="text-idt"><span>*</span>管理部门</td>
				<td class="musthaveinfo"><div class="td_cover"></div><input id="glbmCheckbox" name="guanlbmid" type="hidden" disabled /></td>
				<td class="text-idt">使用状况</td>
				<td class="no_auth">
					<select name="shiyzkid" disabled>
						<option value="">${cardDetailInfo["SHIYZK"]}</option>
					</select>
				</td>
				<td class="text-idt">存放地点</td>
				<td><input id="cunfangdd" name="cunfddid" type="text" disabled value="${cardDetailInfo['CUNFDD']}" /></td>
			</tr>
			<tr>
				<td class="text-idt">使用部门</td>
				<td class="no_auth">
					<select name="shiybmid" disabled>
						<option value="">${cardDetailInfo["SHIYBM"]}</option>
					</select>
				</td>
				<td class="text-idt">使用人</td>
				<td class="no_auth">
					<select name="shiyrid" disabled>
						<option value="">${cardDetailInfo["SHIYBM"]}</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text-idt">开箱人</td>
				<td><input name="kaixr" type="text" disabled value="${cardDetailInfo['KAIXR']}" /></td>
				<td class="text-idt">开箱日期</td>
				<td><input class="card_datedit" name="kaixrq" type="text" value="${cardDetailInfo['KAIXRQ']}" /></td>
			</tr>
			<tr>
				<td class="text-idt">备注</td>
				<td rowspan="2" colspan="3">
					<textarea name="beiz" disabled>${cardDetailInfo["BEIZ"]}</textarea>
				</td>
			</tr>
		</table>
		<table class="yuliu">
			<tr>
				<td class="text-idt">预留1</td>
				<td><input name="yul1" type="text" disabled /></td>
				<td class="text-idt">预留2</td>
				<td><input name="yul2" type="text" disabled /></td>
				<td class="text-idt">预留3</td>
				<td><input name="yul3" type="text" disabled /></td>
			</tr>
		</table>
	</div>
	<div class="edit_yuliu"><a class="edit_yuliu_btn" href="javascript: void(0)">修改预留字段</a></div>
</div>