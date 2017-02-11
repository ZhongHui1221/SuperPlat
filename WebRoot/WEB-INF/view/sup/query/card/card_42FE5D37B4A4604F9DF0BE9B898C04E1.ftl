<!-- 图书基本信息模版 -->
<div class="card_info_main">
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt">档案号</td>
				<td colspan="3" class="colspan_width"><input type="text" name="" disabled="true" value="${cardDetailInfo["DANGAH"]}"></td>
				<td class="text-idt">保存年限</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["BAOCNX"]}"></td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>获得方式</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["QUDFS"]}</option>
					</select>
				</td>
				<td class="text-idt"><span>*</span>购置日期</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["GOUZRQ"]}"></td>
				<td class="text-idt">投入使用日期</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["TOURSYRQ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>采购形式</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["CAIGZZXS"]}</option>
					</select>
				</td>
				<td class="text-idt">采购合同编号</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["HETBH"]}"></td>
				<td class="text-idt"><span>*</span>用途</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["YONGT"]}</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text-idt">供应商</td>
				<td colspan="3" class="colspan_width"><input type="text" name="" disabled="true" value="${cardDetailInfo["JINGXS"]}"></td>
				<td class="text-idt">联系电话</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["JINGXSDH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">出版社</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["CHUBS"]}"></td>
				<td></td>
				<td></td>
				<td class="text-idt">出版日期</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["CHUBRQ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">原资产编号</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["YUANZCBH"]}"></td>
			</tr>
		</table>
	</div>
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt">价值类型</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["JIAZLX"]}</option>
					</select>
				</td>
				<td class="text-idt"><span>*</span>价值（元）</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["JIAZ"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">发票号</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["FAPH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">财政补助收入</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["CAIZBTSR"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">科教项目收入</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["KEJXMSR"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">其他</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["QITSR"]?string("0.00"))!"0.00")}"></td>
			</tr>
			<tr>
				<td class="text-idt">预算项目编号</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["YUSXMBH"]}"></td>
				<td class="text-idt">单价（元）</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["DANJ"]?string("0.00"))!"0.00")}"></td>
			</tr>
			<tr>
				<td class="text-idt">财务入账日期</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["CAIWRZRQ"]}"></td>
				<td class="text-idt">会计凭证号</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["KUAIJPZH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">折旧年限（月）</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["ZHEJNX"]}"></td>
				<td class="text-idt">累计折旧</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["LEIJZJ"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">账面净值</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["JINGZ"]?string("0.00"))!"0.00")}"></td>
			</tr>
		</table>
	</div>
	<div class="detail_card_info" style="border-bottom: none">
		<table>
			<tr>
				<td class="text-idt"><span>*</span>管理部门</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["GUANLBM"]}</option>
					</select>
				</td>
				<td class="text-idt">使用状况</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["SHIYZK"]}</option>
					</select>
				</td>
				<td class="text-idt">存放地点</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["CUNFDD"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">使用部门</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["SHIYBM"]}</option>
					</select>
				</td>
				<td class="text-idt">使用人</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["SHIYR"]}</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text-idt">开箱人</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["KAIXR"]}"></td>
				<td class="text-idt">开箱日期</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["KAIXRQ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">备注</td>
				<td rowspan="2" colspan="3">
					<textarea disabled="true">${cardDetailInfo["BEIZ"]}</textarea>
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<td class="text-idt">预留1</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["YUL1"]}"></td>
				<td class="text-idt">预留2</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["YUL2"]}"></td>
				<td class="text-idt">预留3</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["YUL3"]}"></td>
			</tr>
		</table>
	</div>
</div>