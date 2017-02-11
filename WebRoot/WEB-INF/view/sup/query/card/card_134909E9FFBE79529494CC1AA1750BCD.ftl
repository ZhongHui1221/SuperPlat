<!-- 房屋基本信息模版 -->
<div class="card_info_main">
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt"><span>*</span>坐落位置</td>
				<td colspan="3" class="colspan_width"><input type="text" name="" disabled="true" value="${cardDetailInfo["ZUOLWZ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>取得方式</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["QUDFS"]}</option>
					</select>
				</td>
				<td class="text-idt"><span>*</span>购置日期</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["GOUZRQ"]}"></td>
				<td class="text-idt">用途</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["YONGT"]}</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>竣工日期</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["JUNGRQ"]}"></td>
				<td class="text-idt"><span>*</span>产权形式</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["CHANQXS"]}</option>
					</select>
				</td>
				<td class="text-idt"><span>*</span>投入使用日期</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["TOURSYRQ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>权属性质</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["QUANSXZ"]}</option>
					</select>
				</td>
				<td class="text-idt"><span>*</span>权属证号</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["QUANSZH"]}"></td>
				<td class="text-idt"><span>*</span>权属证明</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["QUANSZM"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">权属年限（月）</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["QUANSNX"]}"></td>
				<td class="text-idt"><span>*</span>设计用途</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["SHEJYT"]}"></td>
				<td class="text-idt"><span>*</span>发证日期</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["LICENCEDATE"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">预计使用年限（月）</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["YUJSMZL"]}"></td>
				<td class="text-idt"><span>*</span>房屋所有权人</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["TUDSYQR"]}"></td>
				<td class="text-idt"><span>*</span>建筑结构</td>
				<td>
					<select disabled="true">
						<option value="">${cardDetailInfo["JIANZJG"]}</option>
					</select>
				</td>
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
				<td class="text-idt">建筑面积（m²）</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["MIANJ"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">办公用房面积(m²)</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["XINGZBGMJ"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">业务用房面积(m²)</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["YEWYFMJ"]?string("0.00"))!"0.00")}"></td>
			</tr>
			<tr>
				<td class="text-idt">自用面积（m²）</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["ZIYMJ"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">自用价值（元）</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["ZIYJZ"]?string("0.00"))!"0.00")}"></td>
			</tr>
			<tr>
				<td class="text-idt">出借面积（m²）</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["CHUJMJ"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">出借价值（元）</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["CHUJJZ"]?string("0.00"))!"0.00")}"></td>
			</tr>
			<tr>
				<td class="text-idt">出租面积（m²）</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["CHUZMJ"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">出租价值（元）</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["CHUZJZ"]?string("0.00"))!"0.00")}"></td>
			</tr>
			<tr>
				<td class="text-idt">其他面积（m²）</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["QITMJ"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">其他价值（元）</td>
				<td><input type="text" name="" disabled="true" value="${((cardDetailInfo["QITJZ"]?string("0.00"))!"0.00")}"></td>
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
				<td class="text-idt">均价（元）</td>
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