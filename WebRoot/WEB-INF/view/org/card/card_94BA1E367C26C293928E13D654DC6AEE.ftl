<!-- 车辆基本信息模版 已改-->
<div class="card_info_main">
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt"><span>*</span>品牌</td>
				<td class="musthaveinfo"><input type="text" name="pinp" disabled value="${cardDetailInfo["PINP"]}"></td>
				<td class="text-idt"><span>*</span>规格型号</td>
				<td class="musthaveinfo"><input type="text" name="guigxh" disabled value="${cardDetailInfo["GUIGXH"]}"></td>
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
				<td class="text-idt">投入使用日期</td>
				<td><input class="card_datedit" type="text" name="toursyrq" disabled value="${cardDetailInfo["TOURSYRQ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">采购形式</td>
				<td>
					<select name="caigzzxsid" disabled>
						<option value="">${cardDetailInfo["CAIGZZXS"]}</option>
					</select>
				</td>
				<td class="text-idt">采购合同编号</td>
				<td><input type="text" name="hetbh" disabled value="${cardDetailInfo["HETBH"]}"></td>
				<td class="text-idt">车辆产地</td>
				<td><input type="text" name="chelcd" disabled value="${cardDetailInfo["CHELCD"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">供应商</td>
				<td><input type="text" name="jingxs" disabled value="${cardDetailInfo["JINGXS"]}"></td>
				<td class="text-idt"><span>*</span>编制情况</td>
				<td class="musthaveinfo">
					<select name="bianzqkid" disabled>
						<option value="">${cardDetailInfo["BIANZQK"]}</option>
					</select>
				</td>
				<td class="text-idt">联系电话</td>
				<td><input type="text" name="jingxsdh" disabled value="${cardDetailInfo["JINGXSDH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">保修截止日期</td>
				<td><input class="card_datedit" type="text" name="baoxjzrq" disabled value="${cardDetailInfo["BAOXJZRQ"]}"></td>
				<td class="text-idt">预计使用年限（月）</td>
				<td class="mustnumber"><input type="text" name="yujsmzl" disabled value="${cardDetailInfo["YUJSMZL"]}"></td>
				<td class="text-idt">定期保养年限（月）</td>
				<td class="mustnumber"><input type="text" name="baoyqx" disabled value="${cardDetailInfo["BAOYQX"]}"></td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>车辆用途</td>
				<td class="musthaveinfo">
					<select name="yongtflid" disabled>
						<option value="">${cardDetailInfo["YONGTFL"]}</option>
					</select>
				</td>
				<td class="text-idt">使用性质</td>
				<td><input type="text" name="shiyxz" disabled value="${cardDetailInfo["SHIYXZ"]}"></td>
				<td class="text-idt">车辆识别号</td>
				<td><input type="text" name="chelsbh" disabled value="${cardDetailInfo["CHELSBH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>号牌种类</td>
				<td class="musthaveinfo">
					<select name="haopzlid" disabled>
						<option value="">${cardDetailInfo["HAOPZL"]}</option>
					</select>
				</td>
				<td class="text-idt"><span>*</span>车牌号</td>
				<td class="musthaveinfo"><input type="text" name="cheph" disabled value="${cardDetailInfo["CHEPH"]}"></td>
				<td class="text-idt"><span>*</span>排气量（升）</td>
				<td class="musthaveinfo mustnumber"><input type="text" name="paiql" disabled value="${cardDetailInfo["PAIQL"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">发动机号</td>
				<td><input type="text" name="fadjh" disabled value="${cardDetailInfo["FADJH"]}"></td>
				<td></td>
				<td></td>
				<td class="text-idt"><span>*</span>行驶证注册日期</td>
				<td class="musthaveinfo"><input class="card_datedit" type="text" name="chelxszzcrq" disabled value="${cardDetailInfo["CHELXSZZCRQ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">原资产编号</td>
				<td><input type="text" name="yuanzcbh" disabled value="${cardDetailInfo["YUANZCBH"]}"></td>
			</tr>
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