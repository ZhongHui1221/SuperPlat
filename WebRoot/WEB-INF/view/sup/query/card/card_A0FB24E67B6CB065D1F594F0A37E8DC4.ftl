<!-- 无形资产大类模版 -->
<div class="card_info_main">
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt">发明人</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["FAMR"]}"></td>
				<td class="text-idt">申请日期</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["LICENCEDATE"]}"></td>
				<td class="text-idt">发明名称</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["FAMMC"]}"></td>
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
				<td class="text-idt">专利号</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["ZHUANLH"]}"></td>
				<td class="text-idt">授权公告日</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["SHOUQGGZ"]}"></td>
				<td class="text-idt">证书号</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["ZHENGSH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">注册登记机关</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["ZHUCDJJG"]}"></td>
				<td class="text-idt">注册登记日期</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["ZHUCDJRQ"]}"></td>
				<td class="text-idt">批准文号</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["PIZWH"]}"></td>
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
				<td><input type="text" name="" disabled value="${((cardDetailInfo["JIAZ"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">发票号</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["FAPH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">财政补助收入</td>
				<td><input type="text" name="" disabled value="${((cardDetailInfo["CAIZBTSR"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">科教项目收入</td>
				<td><input type="text" name="" disabled value="${((cardDetailInfo["KEJXMSR"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">其他</td>
				<td><input type="text" name="" disabled value="${((cardDetailInfo["QITSR"]?string("0.00"))!"0.00")}"></td>
			</tr>
			<tr>
				<td class="text-idt">预算项目编号</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["YUSXMBH"]}"></td>
				<td class="text-idt">单价（元）</td>
				<td><input type="text" name="" disabled value="${((cardDetailInfo["DANJ"]?string("0.00"))!"0.00")}"></td>
			</tr>
			<tr>
				<td class="text-idt">财务入账日期</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["CAIWRZRQ"]}"></td>
				<td class="text-idt">会计凭证号</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["KUAIJPZH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">摊销年限（月）</td>
				<td><input type="text" name="" disabled value="${cardDetailInfo["ZHEJNX"]}"></td>
				<td class="text-idt">累计摊销</td>
				<td><input type="text" name="" disabled value="${((cardDetailInfo["LEIJZJ"]?string("0.00"))!"0.00")}"></td>
				<td class="text-idt">账面净值</td>
				<td><input type="text" name="" disabled value="${((cardDetailInfo["JINGZ"]?string("0.00"))!"0.00")}"></td>
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
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["CUNFDD"]}"></td>
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
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["YUL1"]}"></td>
				<td class="text-idt">预留2</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["YUL2"]}"></td>
				<td class="text-idt">预留3</td>
				<td><input type="text" name="" disabled="true" value="${cardDetailInfo["YUL3"]}"></td>
			</tr>
		</table>
	</div>
</div>