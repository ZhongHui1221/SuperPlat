<div class="card_info_main">
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt">品牌</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["PINP"]}"></td>
				<td class="text-idt">规格型号</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["GUIGXH"]}"></td>
				<td class="text-idt"><span>*</span>用途</td>
				<td>
					<select disabled>
						<option>${cardDetailInfo["YONGT"]}</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>获取方式</td>
				<td>
					<select disabled>
						<option>${cardDetailInfo["QUDFS"]}</option>
					</select>
				</td>
				<td class="text-idt"><span>*</span>购置日期</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["GOUZRQ"]}"></td>
				<td class="text-idt">投入使用日期</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["TOURSYRQ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">采购形式</td>
				<td>
					<select disabled>
						<option>${cardDetailInfo["CAIGZZXS"]}</option>
					</select>
				</td>
				<td class="text-idt">采购合同编号</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["HETBH"]}"></td>
				<td class="text-idt">生产厂家</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["SHENGCCJ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">供应商</td>
				<td colspan="3" class="colspan_width"><input type="text" name="" disabled value="${cardDetailInfo["JINGXS"]}"></td>
				<td class="text-idt">联系电话</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["JINGXSDH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">保修截止日期</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["BAOXJZRQ"]}"></td>
				<td class="text-idt">预计使用年限（月）</td>
				<td><input type="text" name="" disabled value="0" value="${cardDetailInfo["YUJSMZL"]}"></td>
				<td class="text-idt">定期保养期限（月）</td>
				<td><input type="text" name="" disabled value="0" value="${cardDetailInfo["BAOYQX"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">原资产编号</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["YUANZCBH"]}"></td>
			</tr>
		</table>
	</div>
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt">价值类型</td>
				<td>
					<select disabled>
						<option value="">${cardDetailInfo["JIAZLX"]}</option>
					</select>
				</td>
				<td class="text-idt"><span>*</span>价值（元）</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["JIAZ"]}"></td>
				<td class="text-idt">发票号</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["FAPH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">财政补助收入</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["CAIZBTSR"]}"></td>
				<td class="text-idt">科教项目收入</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["KEJXMSR"]}"></td>
				<td class="text-idt">其他</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["QITSR"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">财务入账日期</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["CAIWRZRQ"]}"></td>
				<td class="text-idt">会计凭证号</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["KUAIJPZH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">折旧年限（月）</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["ZHEJNX"]}"></td>
				<td class="text-idt">累计折旧</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["LEIJZJ"]}"></td>
				<td class="text-idt">账面净值</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["JINGZ"]}"></td>
			</tr>
		</table>
	</div>
	<div class="detail_card_info" style="border-bottom: none">
		<table>
			<tr>
				<td class="text-idt"><span>*</span>管理部门</td>
				<td>
					<select disabled>
						<option value="">${cardDetailInfo["GUANLBM"]}</option>
					</select>
				</td>
				<td class="text-idt">使用状况</td>
				<td>
					<select disabled>
						<option value="">${cardDetailInfo["SHIYZK"]}</option>
					</select>
				</td>
				<td class="text-idt">存放地点</td>
				<td>
					<select disabled>
						<option value="">${cardDetailInfo["CUNFDD"]}</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text-idt">使用部门</td>
				<td>
					<select disabled>
						<option value="">${cardDetailInfo["SHIYBM"]}</option>
					</select>
				</td>
				<td class="text-idt">使用人</td>
				<td>
					<select disabled>
						<option value="">${cardDetailInfo["SHIYR"]}</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text-idt">开箱人</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["KAIXR"]}"></td>
				<td class="text-idt">开箱日期</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["KAIXRQ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">备注</td>
				<td rowspan="2" colspan="3">
					<textarea disabled>${cardDetailInfo["BEIZ"]}</textarea>
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<td class="text-idt">预留1</td>
				<td><input type="text" name="" disabled value=""></td>
				<td class="text-idt">预留2</td>
				<td><input type="text" name="" disabled value=""></td>
				<td class="text-idt">预留3</td>
				<td><input type="text" name="" disabled value=""></td>
			</tr>
		</table>
	</div>
</div>