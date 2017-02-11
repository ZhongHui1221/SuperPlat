<!-- 土地基本信息模版 已改-->
<div class="card_info_main">
	<div class="detail_card_info">
		<table>
			<tr>
				<td class="text-idt"><span>*</span>坐落位置</td>
				<td colspan="3" class="colspan_width musthaveinfo"><input type="text" name="zuolwz" disabled value="${cardDetailInfo["ZUOLWZ"]}"></td>
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
				<td class="text-idt"><span>*</span>产权形式</td>
				<td class="musthaveinfo">
					<select name="chanqxsid" disabled>
						<option value="CHANQXS">${cardDetailInfo["CHANQXS"]}</option>
					</select>
				</td>
				<td class="text-idt">土地级次</td>
				<td>
					<select name="tudjcid" disabled>
						<option value="TUDJC">${cardDetailInfo["TUDJC"]}</option>
					</select>
				</td>
				<td class="text-idt">权属证明</td>
				<td><input type="text" name="quanszm" disabled value="${cardDetailInfo["QUANSZM"]}"></td>
			</tr>
			<tr>
				<td class="text-idt"><span>*</span>权属性质</td>
				<td class="musthaveinfo">
					<select name="quansxzid" disabled>
						<option value="">${cardDetailInfo["QUANSXZ"]}</option>
					</select>
				</td>
				<td class="text-idt">权属证号</td>
				<td><input type="text" name="quanszh" disabled value="${cardDetailInfo["QUANSZH"]}"></td>
				<td class="text-idt">发证日期</td>
				<td><input class="card_datedit" type="text" name="licencedate" disabled value="${cardDetailInfo["LICENCEDATE"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">权属年限（月）</td>
				<td class="mustnumber"><input type="text" name="quansnx" disabled value="${cardDetailInfo["QUANSNX"]}"></td>
				<td class="text-idt"><span>*</span>地类（用途）</td>
				<td class="musthaveinfo">
					<select name="dilytid" disabled>
						<option value="">${cardDetailInfo["DILYT"]}</option>
					</select>
				</td>
				<td class="text-idt">使用权类型</td>
				<td>
					<select name="tudsyqlxid" disabled>
						<option value="">${cardDetailInfo["TUDSYQLX"]}</option>
					</select>
				</td>
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
				<td class="text-idt">使用权面积（m²）</td>
				<td class="mustnumber"><input type="text" name="mianj" disabled value="${cardDetailInfo["MIANJ"]}"></td>
				<td class="text-idt">其中：独用面积(m²)</td>
				<td class="mustnumber"><input type="text" name="duymj" disabled value="${cardDetailInfo["DUYMJ"]}"></td>
				<td class="text-idt">分摊面积（m²）</td>
				<td class="mustnumber"><input type="text" name="fentmj" disabled value="${cardDetailInfo["FENTMJ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">自用面积（m²）</td>
				<td class="mustnumber"><input type="text" name="ziymj" disabled value="${cardDetailInfo["ZIYMJ"]}"></td>
				<td class="text-idt">自用价值（元）</td>
				<td class="mustnumber"><input type="text" name="ziyjz" disabled value="${cardDetailInfo["ZIYJZ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">出借面积（m²）</td>
				<td class="mustnumber"><input type="text" name="chujmj" disabled value="${cardDetailInfo["CHUJMJ"]}"></td>
				<td class="text-idt">出借价值（元）</td>
				<td class="mustnumber"><input type="text" name="chujjz" disabled value="${cardDetailInfo["CHUJJZ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">出租面积（m²）</td>
				<td class="mustnumber"><input type="text" name="chuzmj" disabled value="${cardDetailInfo["CHUZMJ"]}"></td>
				<td class="text-idt">出租价值（元）</td>
				<td class="mustnumber"><input type="text" name="chuzjz" disabled value="${cardDetailInfo["CHUZJZ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">其他面积（m²）</td>
				<td class="mustnumber"><input type="text" name="qitmj" disabled value="${cardDetailInfo["QITMJ"]}"></td>
				<td class="text-idt">其他价值（元）</td>
				<td class="mustnumber"><input type="text" name="qitjz" disabled value="${cardDetailInfo["QITJZ"]}"></td>
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
				<td class="text-idt">均价（元）</td>
				<td class="mustnumber"><input type="text" name="danj" disabled value="${cardDetailInfo["DANJ"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">财务入账日期</td>
				<td><input class="card_datedit" type="text" name="caiwrzrq" disabled value="${cardDetailInfo["CAIWRZRQ"]}"></td>
				<td class="text-idt">会计凭证号</td>
				<td><input type="text" name="kuaijpzh" disabled value="${cardDetailInfo["KUAIJPZH"]}"></td>
			</tr>
			<tr>
				<td class="text-idt">摊销年限（月）</td>
				<td class="mustnumber"><input type="text" name="zhejnx" disabled value="${cardDetailInfo["ZHEJNX"]}"></td>
				<td class="text-idt">累计摊销</td>
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
						<option value="">${cardDetailInfo["SHIYBM"]}</option>
					</select>
				</td>
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