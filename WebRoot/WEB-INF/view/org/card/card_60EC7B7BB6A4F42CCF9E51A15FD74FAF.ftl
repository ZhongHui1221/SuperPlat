<!-- 文物基本信息模版 已改-->
<div class="card_info_main">
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt">文物等级</td>
				<td>
					<select name="wenwdjid" disabled>
						<option value="">${cardDetailInfo["WENWDJ"]}</option>
					</select>
				</td>
				<td class="text-idt">藏品年代</td>
				<td><input type="text" name="cangpnd" disabled value="${cardDetailInfo["CANGPND"]}"></td>
				<td class="text-idt"><span>*</span>用途</td>
				<td class="musthaveinfo">
					<select name="yongtid" disabled>
						<option value="">${cardDetailInfo["YONGT"]}</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>取得方式</td>
				<td class="musthaveinfo">
					<select name="qudfsid" disabled>
						<option value="">${cardDetailInfo["QUDFS"]}</option>
					</select>
				</td>
				<td class="text-idt"><span>*</span>购置日期</td>
				<td class="musthaveinfo"><input class="card_datedit" type="text" name="gouzrq" disabled value="${cardDetailInfo["GOUZRQ"]}"></td>
				<td class="text-idt">来源地</td>
				<td><input type="text" name="laiyd" disabled value="${cardDetailInfo["LAIYD"]}"></td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>采购形式</td>
				<td class="musthaveinfo">
					<select name="caigzzxsid" disabled>
						<option value="">${cardDetailInfo["CAIGZZXS"]}</option>
					</select>
				</td>
				<td class="text-idt">采购合同编号</td>
				<td><input type="text" name="hetbh" disabled value="${cardDetailInfo["HETBH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">供应商</td>
				<td colspan="3" class="colspan_width"><input type="text" name="jingxs" disabled value="${cardDetailInfo["JINGXS"]}"></td>
				<td class="text-idt">联系电话</td>
				<td><input type="text" name="jingxsdh" disabled value="${cardDetailInfo["JINGXSDH"]}"></td>
			</tr>
			<td class="text-idt">原资产编号</td>
			<td><input type="text" name="yuanzcbh" disabled value="${cardDetailInfo["YUANZCBH"]}"></td>
		</table>
	</div>
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt">价值类型</td>
				<td>
					<select name="jiazlxid" disabled>
						<option value="">${cardDetailInfo["JIAZLX"]}</option>
					</select>
				</td>
				<td class="text-idt"><span>*</span>价值（元）</td>
				<td class="musthaveinfo mustnumber"><input type="text" name="jiaz" disabled value="${cardDetailInfo["JIAZ"]}"></td>
				<td class="text-idt">发票号</td>
				<td><input type="text" name="faph" disabled value="${cardDetailInfo["FAPH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">财政补助收入</td>
				<td class="mustnumber"><input type="text" name="caizbtsr" disabled value="${cardDetailInfo["CAIZBTSR"]}"></td>
				<td class="text-idt">科教项目收入</td>
				<td class="mustnumber"><input type="text" name="kejxmsr" disabled value="${cardDetailInfo["KEJXMSR"]}"></td>
				<td class="text-idt">其他</td>
				<td class="mustnumber"><input type="text" name="qitsr" disabled value="${cardDetailInfo["QITSR"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">预算项目编号</td>
				<td><input type="text" name="yusxmbh" disabled value="${cardDetailInfo["YUSXMBH"]}"></td>
				<td class="text-idt">单价（元）</td>
				<td class="mustnumber"><input type="text" name="danj" disabled value="${cardDetailInfo["DANJ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">财务入账日期</td>
				<td><input class="card_datedit" type="text" name="caiwrzrq" disabled value="${cardDetailInfo["CAIWRZRQ"]}"></td>
				<td class="text-idt">会计凭证号</td>
				<td><input type="text" name="kuaijpzh" disabled value="${cardDetailInfo["KUAIJPZH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">折旧年限（月）</td>
				<td class="mustnumber"><input type="text" name="zhejnx" disabled value="${cardDetailInfo["ZHEJNX"]}"></td>
				<td class="text-idt">累计折旧</td>
				<td class="mustnumber"><input type="text" name="leijzj" disabled value="${cardDetailInfo["LEIJZJ"]}"></td>
				<td class="text-idt">账面净值</td>
				<td class="mustnumber"><input type="text" name="jingz" disabled value="${cardDetailInfo["JINGZ"]}"></td>
			</tr>
		</table>
	</div>
	<div class="detail_card_info" style="border-bottom: none">
		<table>
			<tr>
				<td class="text-idt"><span>*</span>管理部门</td>
				<td class="musthaveinfo"><div class="td_cover"></div><input id="glbmCheckbox" name="guanlbmid" type="hidden" disabled /></td>
				<td class="text-idt">使用状况</td>
				<td>
					<select name="shiyzkid" disabled>
						<option value="">${cardDetailInfo["SHIYZK"]}</option>
					</select>
				</td>
				<td class="text-idt">存放地点</td>
				<td><input type="text" name="cunfddid" disabled value="${cardDetailInfo["CUNFDD"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">使用部门</td>
				<td>
					<select name="shiybmid" disabled>
						<option value="">${cardDetailInfo["SHIYBM"]}</option>
					</select>
				</td>
				<td class="text-idt">使用人</td>
				<td>
					<select name="shiyrid" disabled>
						<option value="">${cardDetailInfo["SHIYR"]}</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text-idt">开箱人</td>
				<td><input type="text" name="kaixr" disabled value="${cardDetailInfo["KAIXR"]}"></td>
				<td class="text-idt">开箱日期</td>
				<td><input class="card_datedit" type="text" name="kaixrq" disabled value="${cardDetailInfo["KAIXRQ"]}"></td>
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