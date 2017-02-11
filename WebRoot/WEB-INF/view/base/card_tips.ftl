<#-- 卡片标签模版 -->

<#if obj["ISGWC"] == "1"><li class="card_tips_cang" title="公务仓">仓</li></#if>
<#if obj["BIAOJ"] == "1"><li class="card_tips_ji" title="已标记">记</li></#if>
<#if obj["DAIBF"] == "1"><li class="card_tips_fei" title="待报废">废</li></#if>
<#if obj["AUDITSTATE"] == "2"><li class="card_tips_zhang" title="财务已入账">账</li></#if>
<#if obj["ZICSX"] == "1">
	<li class="card_tips_gu" title="固定资产">固</li>
<#elseif obj["ZICSX"] == "2">
	<li class="card_tips_wu" title="无形资产">无</li>
<#else>
	<li class="card_tips_liu" title="流动资产">流</li>
</#if>
<#if obj["MCRWID"]??>
	<li class="card_tips_fu" title="附属卡片">附</li>
<#else>
	<li class="card_tips_zhu" title="主卡">主</li>
</#if>
<#if obj["SHIFGY"] == "1"><li class="card_tips_gong" title="公用资产">公</li></#if>